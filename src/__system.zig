const std = @import("std");

const builtin = @import("builtin");
const ArrayList = std.ArrayList;

pub var allocator: std.mem.Allocator = undefined;

const system = @import("system.zig");
const window = @import("window.zig");
const __vulkan = @import("__vulkan.zig");
const __windows = if (!@import("builtin").is_test) @import("__windows.zig") else void;
const __android = if (!@import("builtin").is_test) @import("__android.zig") else void;
const __vulkan_allocator = @import("__vulkan_allocator.zig");
const math = @import("math.zig");
const input = @import("input.zig");
const mem = @import("mem.zig");

const render_command = @import("render_command.zig");
const __raw_input = @import("__raw_input.zig");

const root = @import("root");
const xfit = @import("xfit.zig");
pub var exiting: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);

comptime {
    @export(&lua_writestring, .{ .name = "lua_writestring", .linkage = .strong });
    @export(&lua_writestringerror, .{ .name = "lua_writestringerror", .linkage = .strong });
}

pub const _system = @extern(*const fn ([*c]const u8) callconv(.C) c_int, .{ .name = "system", .linkage = .strong });

fn lua_writestring(ptr: ?*const anyopaque, size: usize) callconv(.C) usize {
    xfit.write(@as([*]const u8, @ptrCast(ptr.?))[0..size]);
    return size;
}
//only has one %s
fn lua_writestringerror(fmt: [*c]const u8, _str: [*c]const u8) callconv(.C) void {
    ///// ! disable temporarily
    // var ap = @cVaStart();
    // defer @cVaEnd(&ap);

    // var out: ArrayList(u8) = ArrayList(u8).init(std.heap.c_allocator);
    // defer out.deinit();

    // var i: usize = 0;
    // while (fmt[i] != 0) : (i += 1) {
    //     if (fmt[i] == '%' and fmt[i + 1] == 's') {
    //         const str = @cVaArg(&ap, [*c]const u8);
    //         out.appendSlice(str[0..std.mem.len(str)]) catch unreachable;
    //         i += 1;
    //     } else {
    //         out.append(fmt[i]) catch unreachable;
    //     }
    // }
    // _ = lua_writestring(@ptrCast(out.items.ptr), out.items.len);

    var out: ArrayList(u8) = ArrayList(u8).init(std.heap.c_allocator);
    defer out.deinit();

    var i: usize = 0;
    while (fmt[i] != 0) : (i += 1) {
        if (fmt[i] == '%' and fmt[i + 1] == 's') {
            const str = _str;
            out.appendSlice(str[0..std.mem.len(str)]) catch unreachable;
            i += 1;
        } else {
            out.append(fmt[i]) catch unreachable;
        }
    }
    _ = lua_writestring(@ptrCast(out.items.ptr), out.items.len);
}

pub fn save_prev_window_state() void {
    if (init_set.screen_mode == .WINDOW) {
        prev_window = .{
            .x = window.x(),
            .y = window.y(),
            .width = window.width(),
            .height = window.height(),
            .state = if (xfit.platform == .windows) __windows.get_window_state() else window.state.Restore,
        };
    }
}

pub var prev_window: struct {
    x: i32,
    y: i32,
    width: u32,
    height: u32,
    state: window.state,
} = undefined;

pub var title: [:0]u8 = undefined;

pub var init_set: xfit.init_setting = .{};

pub var delta_time: u64 = 0;
pub var processor_core_len: u32 = 0;
pub var platform_ver: system.platform_version = undefined;
pub var __screen_orientation: window.screen_orientation = .unknown;

pub var mouse_out: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);
pub var mouse_scroll_dt: std.atomic.Value(i32) = std.atomic.Value(i32).init(0);

pub var Lmouse_click: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);
pub var Mmouse_click: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);
pub var Rmouse_click: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);

pub var Lmouse_down_func: ?*const fn (pos: math.point) void = null;
pub var Mmouse_down_func: ?*const fn (pos: math.point) void = null;
pub var Rmouse_down_func: ?*const fn (pos: math.point) void = null;

pub var Lmouse_up_func: ?*const fn (pos: math.point) void = null;
pub var Mmouse_up_func: ?*const fn (pos: math.point) void = null;
pub var Rmouse_up_func: ?*const fn (pos: math.point) void = null;

pub var mouse_scroll_func: ?*const fn (dt: i32) void = null;

pub var size_update: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);

pub var mouse_leave_func: ?*const fn () void = null;
pub var mouse_hover_func: ?*const fn () void = null;
pub var mouse_move_func: ?*const fn (pos: math.point) void = null;
pub var touch_move_func: ?*const fn (touch_idx: u32, pos: math.point) void = null;

pub var touch_down_func: ?*const fn (touch_idx: u32, pos: math.point) void = null;
pub var touch_up_func: ?*const fn (touch_idx: u32, pos: math.point) void = null;

pub var window_move_func: ?*const fn () void = null;
pub var window_size_func: ?*const fn () void = null;

pub var error_handling_func: ?*const fn (text: []u8, stack_trace: []u8) void = null;

pub var cursor_pos: math.point = undefined;

pub var pause: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);
pub var activated: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);

///false = key_up, true = key_down
pub var keys: [KEY_SIZE]std.atomic.Value(bool) = [_]std.atomic.Value(bool){std.atomic.Value(bool).init(false)} ** KEY_SIZE;
pub const KEY_SIZE = 512;
pub var key_down_func: ?*const fn (key_code: input.key) void = null;
pub var key_up_func: ?*const fn (key_code: input.key) void = null;

pub var monitors: ArrayList(system.monitor_info) = undefined;
pub var primary_monitor: *system.monitor_info = undefined;

pub var current_monitor: ?*const system.monitor_info = null;

pub var general_input_callback: ?input.general_input.CallbackFn = null;

pub fn init(_allocator: std.mem.Allocator, init_setting: *const xfit.init_setting) void {
    allocator = _allocator;

    monitors = ArrayList(system.monitor_info).init(allocator);
    if (xfit.is_mobile) {
        const width = init_set.window_width;
        const height = init_set.window_height;
        init_set = init_setting.*;
        init_set.window_width = width;
        init_set.window_height = height;
    } else {
        init_set = init_setting.*;
    }

    title = allocator.dupeZ(u8, init_set.window_title) catch |e| xfit.herr3("__system.init.title = allocator.dupeZ", e);
}

pub var loop_start: std.atomic.Value(bool) = std.atomic.Value(bool).init(false);

pub fn loop() void {
    const S = struct {
        var start: std.time.Instant = undefined;
        var now: std.time.Instant = undefined;
    };
    const ispause = xfit.paused();
    if (!loop_start.load(.monotonic)) {
        S.start = std.time.Instant.now() catch |e| xfit.herr3("S.start = std.time.Instant.now()", e);
        S.now = S.start;
        loop_start.store(true, .monotonic);
    } else {
        var maxframe = xfit.get_maxframe();
        if (ispause and maxframe == 0) {
            maxframe = 60;
        }
        var n = std.time.Instant.now() catch |e| xfit.herr3(" const n = std.time.Instant.now()", e);
        var _delta_time = n.since(S.now);

        if (maxframe > 0) {
            const maxf: u64 = @intFromFloat((1.0 * (1.0 / maxframe)) * 1000000000); //1 / (maxframe / 1); reduce division once
            if (maxf > _delta_time) {
                if (ispause) {
                    std.time.sleep(maxf - _delta_time); //wait state, accuracy is enough.
                } else {
                    xfit.sleep_ex(maxf - _delta_time);
                }
            }
            n = std.time.Instant.now() catch |e| xfit.herr3(" const n = std.time.Instant.now()", e);
            _delta_time = n.since(S.now);
        } else {}
        S.now = n;
        @atomicStore(u64, &delta_time, _delta_time, .monotonic);
    }
    if (!xfit.__xfit_test) {
        root.xfit_update() catch |e| {
            xfit.herr3("xfit_clean", e);
        };
    }

    if (!ispause) {
        __vulkan.drawFrame();
    }
}

pub fn destroy() void {
    monitors.deinit();
    allocator.free(title);
}

pub fn real_destroy() void {
    xfit.font.__destroy();
    xfit.sound.__destroy();
}
