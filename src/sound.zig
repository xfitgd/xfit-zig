pub const miniaudio = @cImport({
    @cDefine("MINIAUDIO_IMPLEMENTATION", "");
    @cInclude("miniaudio/miniaudio.h");
    @cInclude("miniaudio/miniaudio_libopus.h");
    @cInclude("miniaudio/miniaudio_libvorbis.h");
    @cInclude("miniaudio/miniaudio_ex.h"); //https://miniaud.io/docs/examples/custom_decoder.html
});

const system = @import("system.zig");
const std = @import("std");
const __system = @import("__system.zig");
const file = @import("file.zig");
const asset_file = @import("asset_file.zig");
const AutoHashMap = std.AutoHashMap;
const ArrayList = std.ArrayList;
const xfit = @import("xfit.zig");

const file_ = if (xfit.platform == .android) asset_file else file;
const Self = @This();

var g_ends: ArrayList(*Self) = undefined;

var sound_started: bool = false;

var engine: miniaudio.ma_engine = undefined;
var pCustomBackendVTables: [2][*c]miniaudio.ma_decoding_backend_vtable = .{ undefined, undefined };
var resourceManager: miniaudio.ma_resource_manager = undefined;
var g_mutex: std.Thread.Mutex = .{};
var g_mutex2: std.Thread.Mutex = .{};
var g_sem: std.Thread.Semaphore = .{};
var sounds: AutoHashMap(*Self, void) = undefined;
var g_thread: std.Thread = undefined;

__sound: ?miniaudio.ma_sound = null,
__audio_buf: miniaudio.ma_audio_buffer = undefined,
source: ?*sound_source = null,

fn start() void {
    sounds = AutoHashMap(*Self, void).init(std.heap.c_allocator);
    g_ends = ArrayList(*Self).init(std.heap.c_allocator);

    var resourceManagerConfig = miniaudio.ma_resource_manager_config_init();
    pCustomBackendVTables[0] = &miniaudio.g_ma_decoding_backend_vtable_libopus;
    pCustomBackendVTables[1] = &miniaudio.g_ma_decoding_backend_vtable_libvorbis;
    resourceManagerConfig.ppCustomDecodingBackendVTables = @ptrCast(&pCustomBackendVTables[0]);
    resourceManagerConfig.customDecodingBackendCount = 2;
    resourceManagerConfig.pCustomDecodingBackendUserData = null;

    var result = miniaudio.ma_resource_manager_init(&resourceManagerConfig, &resourceManager);
    if (result != miniaudio.MA_SUCCESS) xfit.herr2("miniaudio.ma_resource_manager_init {d}", .{result});
    var engineConfig: miniaudio.ma_engine_config = miniaudio.ma_engine_config_init();
    engineConfig.pResourceManager = &resourceManager;

    result = miniaudio.ma_engine_init(&engineConfig, &engine);

    if (result != miniaudio.MA_SUCCESS) xfit.herr2("miniaudio.ma_engine_init {d}", .{result});

    sound_started = true;
    g_thread = std.Thread.spawn(.{}, callback_thread, .{}) catch unreachable;
}

// fn data_callback(pDevice: [*c]miniaudio.ma_device, pOutput: ?*anyopaque, pInput: ?*const anyopaque, frameCount: miniaudio.ma_uint32) callconv(.C) void {
//     _ = pInput;
//     const pDataSource: ?*miniaudio.ma_data_source = @ptrCast(pDevice.*.pUserData);
//     if (pDataSource == null) {
//         return;
//     }
//     _ = miniaudio.ma_data_source_read_pcm_frames(pDataSource, pOutput, frameCount, null);
// }
fn end_callback(userdata: ?*anyopaque, sound: [*c]miniaudio.ma_sound) callconv(.C) void {
    _ = sound;
    const self: *Self = @alignCast(@ptrCast(userdata.?));

    g_mutex2.lock();
    g_ends.append(self) catch |e| xfit.herr3("g_ends.append", e);
    g_mutex2.unlock();
    g_sem.post();
}

fn callback_thread() void {
    while (@atomicLoad(bool, &sound_started, .acquire)) {
        g_sem.wait();
        if (!@atomicLoad(bool, &sound_started, .acquire)) break;

        var this: ?*Self = null;
        g_mutex2.lock();
        if (g_ends.items.len > 0) {
            this = g_ends.pop();
        }
        g_mutex2.unlock();
        if (this != null) {
            g_mutex.lock();
            if (miniaudio.ma_sound_is_looping(&this.?.*.__sound.?) == 0) {
                g_mutex.unlock();
                this.?.*.deinit();
            } else g_mutex.unlock();
        }
    }
}

pub const sound_source = struct {
    out_data: ?[]u8 = null,
    format: miniaudio.ma_format = undefined,
    channels: miniaudio.ma_uint32 = undefined,
    sampleRate: miniaudio.ma_uint32 = undefined,
    size_in_frames: miniaudio.ma_uint64 = undefined,

    ///first deinit connected sounds, then deinit -> no need to deinit connected sounds.
    pub fn deinit(self: *sound_source) void {
        g_mutex.lock();
        var it = sounds.keyIterator();
        while (it.next()) |v| {
            if (v.*.*.source == self) v.*.*.deinit2();
        }
        g_mutex.unlock();
        std.c.free(self.*.out_data.?.ptr);
        std.heap.c_allocator.destroy(self);
    }
    pub fn play_sound_memory(self: *sound_source, volume: f32, loop: bool) !?*Self {
        if (!@atomicLoad(bool, &sound_started, .acquire)) return null;

        const result_sound: *Self = try std.heap.c_allocator.create(Self);
        errdefer std.heap.c_allocator.destroy(self);
        result_sound.* = .{ .source = self };

        const audio_buf_config: miniaudio.ma_audio_buffer_config = .{
            .channels = self.*.channels,
            .format = self.*.format,
            .sampleRate = self.*.sampleRate,
            .pData = self.*.out_data.?.ptr,
            .sizeInFrames = self.*.size_in_frames,
        };
        var result = miniaudio.ma_audio_buffer_init(&audio_buf_config, &result_sound.*.__audio_buf);
        if (result != miniaudio.MA_SUCCESS) {
            xfit.print_error("miniaudio.ma_audio_buffer_init {d}\n", .{result});
            return std.posix.UnexpectedError.Unexpected;
        }

        var sound_config = miniaudio.ma_sound_config_init();
        sound_config.endCallback = end_callback;
        sound_config.pEndCallbackUserData = @ptrCast(result_sound);
        sound_config.pDataSource = &result_sound.*.__audio_buf;
        sound_config.isLooping = if (loop) miniaudio.MA_TRUE else miniaudio.MA_FALSE;

        result_sound.*.__sound = undefined;

        result = miniaudio.ma_sound_init_ex(&engine, &sound_config, &result_sound.*.__sound.?);
        if (result != miniaudio.MA_SUCCESS) {
            xfit.print_error("miniaudio.ma_sound_init_from_data_source {d}\n", .{result});
            return std.posix.UnexpectedError.Unexpected;
        }
        miniaudio.ma_sound_set_volume(&result_sound.*.__sound.?, volume);

        result = miniaudio.ma_sound_start(&result_sound.__sound.?);
        if (result != miniaudio.MA_SUCCESS) {
            xfit.print_error("miniaudio.ma_sound_start {d}\n", .{result});
            return std.posix.UnexpectedError.Unexpected;
        }
        g_mutex.lock();
        try sounds.put(result_sound, {});
        g_mutex.unlock();
        return result_sound;
    }
};

pub fn play_sound(path: []const u8, volume: f32, loop: bool) !?*Self {
    if (!@atomicLoad(bool, &sound_started, .acquire)) start();

    var self: *Self = undefined;
    self = try std.heap.c_allocator.create(Self);
    self.* = .{ .source = try std.heap.c_allocator.create(sound_source) };
    self.*.source.?.* = .{};
    errdefer {
        std.heap.c_allocator.destroy(self.source.?);
        std.heap.c_allocator.destroy(self);
    }

    var decoder: miniaudio.ma_decoder = undefined;
    var decoder_config = miniaudio.ma_decoder_config_init_default();
    decoder_config.ppCustomBackendVTables = @ptrCast(&pCustomBackendVTables[0]);
    decoder_config.customBackendCount = 2;

    const data = try file_.read_file(path, std.heap.c_allocator);
    defer std.heap.c_allocator.free(data);

    var result = miniaudio.ma_decoder_init_memory(data.ptr, data.len, &decoder_config, &decoder);
    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_decoder_init_memory {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    defer _ = miniaudio.ma_decoder_uninit(&decoder);

    result = miniaudio.ma_data_source_get_data_format(&decoder, &self.*.source.?.*.format, &self.*.source.?.*.channels, &self.*.source.?.*.sampleRate, null, 0);
    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_data_source_get_data_format {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    var output: ?*anyopaque = undefined;

    result = miniaudio.ma_decode_memory(data.ptr, data.len, &decoder_config, &self.*.source.?.*.size_in_frames, &output);

    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_decode_memory {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    self.*.source.?.*.out_data = @as([*]u8, @ptrCast(output.?))[0..@intCast(self.*.source.?.*.size_in_frames * self.*.source.?.*.channels)];

    const audio_buf_config: miniaudio.ma_audio_buffer_config = .{
        .channels = self.*.source.?.*.channels,
        .format = self.*.source.?.*.format,
        .sampleRate = self.*.source.?.*.sampleRate,
        .pData = self.*.source.?.*.out_data.?.ptr,
        .sizeInFrames = self.*.source.?.*.size_in_frames,
    };
    result = miniaudio.ma_audio_buffer_init(&audio_buf_config, &self.*.__audio_buf);
    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_audio_buffer_init {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }

    self.*.__sound = undefined;
    var sound_config = miniaudio.ma_sound_config_init();
    sound_config.endCallback = end_callback;
    sound_config.pEndCallbackUserData = @ptrCast(self);
    sound_config.pDataSource = &self.*.__audio_buf;
    sound_config.isLooping = if (loop) miniaudio.MA_TRUE else miniaudio.MA_FALSE;

    result = miniaudio.ma_sound_init_ex(&engine, &sound_config, &self.*.__sound.?);
    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_sound_init_from_data_source {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    miniaudio.ma_sound_set_volume(&self.*.__sound.?, volume);

    result = miniaudio.ma_sound_start(&self.__sound.?);
    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_sound_start {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    g_mutex.lock();
    try sounds.put(self, {});
    g_mutex.unlock();
    return self;
}

pub fn set_volume(self: *Self, _volume: f32) void {
    miniaudio.ma_sound_set_volume(&self.*.__sound.?, _volume);
}

pub fn set_speed(self: *Self, _pitch: f32) void {
    miniaudio.ma_sound_set_pitch(&self.*.__sound.?, _pitch);
}

pub fn pause(self: *Self) void {
    _ = miniaudio.ma_sound_stop(&self.*.__sound.?);
}
pub fn resume_(self: *Self) void {
    _ = miniaudio.ma_sound_start(&self.*.__sound.?);
}
pub fn get_length_in_sec(self: *Self) f32 {
    var res: f32 = undefined;
    _ = miniaudio.ma_sound_get_length_in_seconds(&self.*.__sound.?, &res);
    return res;
}
pub fn get_length_in(self: *Self) u64 {
    var res: u64 = undefined;
    _ = miniaudio.ma_sound_get_length_in_pcm_frames(&self.*.__sound.?, &res);
    return res;
}
pub fn get_pos(self: *Self) u64 {
    var res: u64 = undefined;
    _ = miniaudio.ma_sound_get_cursor_in_pcm_frames(&self.*.__sound.?, &res);
    return res;
}
pub fn get_pos_in_sec(self: *Self) f32 {
    var res: f32 = undefined;
    _ = miniaudio.ma_sound_get_cursor_in_seconds(&self.*.__sound.?, &res);
    return res;
}
pub fn set_pos(self: *Self, pos: u64) void {
    _ = miniaudio.ma_sound_seek_to_pcm_frame(&self.*.__sound.?, pos);
}
pub fn set_looping(self: *Self, loop: bool) void {
    _ = miniaudio.ma_sound_set_looping(&self.*.__sound.?, if (loop) miniaudio.MA_TRUE else miniaudio.MA_FALSE);
}
pub fn is_looping(self: *Self) bool {
    return miniaudio.ma_sound_is_looping(&self.*.__sound.?) == miniaudio.MA_TRUE;
}
pub fn is_playing(self: *Self) bool {
    return miniaudio.ma_sound_is_playing(&self.*.__sound.?) == miniaudio.MA_TRUE;
}

pub fn decode_sound_memory(data: []const u8) !*sound_source {
    if (!@atomicLoad(bool, &sound_started, .acquire)) start();

    const self: *sound_source = try std.heap.c_allocator.create(sound_source);
    errdefer std.heap.c_allocator.destroy(self);
    self.* = .{};

    var decoder: miniaudio.ma_decoder = undefined;
    var decoder_config = miniaudio.ma_decoder_config_init_default();
    decoder_config.ppCustomBackendVTables = @ptrCast(&pCustomBackendVTables[0]);
    decoder_config.customBackendCount = 2;

    var result = miniaudio.ma_decoder_init_memory(data.ptr, data.len, &decoder_config, &decoder);
    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_decoder_init_memory {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    defer _ = miniaudio.ma_decoder_uninit(&decoder);

    result = miniaudio.ma_data_source_get_data_format(&decoder, &self.*.format, &self.*.channels, &self.*.sampleRate, null, 0);
    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_data_source_get_data_format {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    var output: ?*anyopaque = undefined;

    result = miniaudio.ma_decode_memory(data.ptr, data.len, &decoder_config, &self.*.size_in_frames, &output);

    if (result != miniaudio.MA_SUCCESS) {
        xfit.print_error("miniaudio.ma_decode_memory {d}\n", .{result});
        return std.posix.UnexpectedError.Unexpected;
    }
    self.*.out_data = @as([*]u8, @ptrCast(output.?))[0..@intCast(self.*.size_in_frames * self.*.channels)];
    return self;
}

pub fn deinit(self: *Self) void {
    g_mutex.lock();
    self.*.deinit2();
    g_mutex.unlock();
}
fn deinit2(self: *Self) void {
    if (self.*.__sound == null) return;
    miniaudio.ma_sound_uninit(&self.*.__sound.?);
    miniaudio.ma_audio_buffer_uninit(&self.*.__audio_buf);
    std.heap.c_allocator.destroy(self);
    if (@atomicLoad(bool, &sound_started, .acquire)) {
        _ = sounds.remove(self);
    }
}

pub fn __destroy() void {
    if (!@atomicLoad(bool, &sound_started, .acquire)) return;
    @atomicStore(bool, &sound_started, false, .release);
    g_sem.post();
    g_thread.join();

    miniaudio.ma_engine_uninit(&engine);

    g_mutex.lock();
    var it = sounds.keyIterator();
    while (it.next()) |v| {
        v.*.*.deinit2();
    }
    g_mutex.unlock();
    g_ends.deinit();
    sounds.deinit();
}
