const std = @import("std");
const ArrayList = std.ArrayList;

const system = @import("system.zig");
const __system = @import("__system.zig");
const xfit = @import("xfit.zig");

const dbg = xfit.dbg;

const __vulkan_allocator = @import("__vulkan_allocator.zig");

const _allocator = __system.allocator;

const __vulkan = @import("__vulkan.zig");
const vk = __vulkan.vk;

const graphics = @import("graphics.zig");
const __render_command = @import("__render_command.zig");

pub const MAX_FRAME: usize = 3;

__refesh: [MAX_FRAME]bool = .{true} ** MAX_FRAME,
__command_buffers: [MAX_FRAME][]vk.CommandBuffer = undefined,
scene: ?[]*graphics.iobject = null,
const Self = @This();

pub fn init() *Self {
    const self = __system.allocator.create(Self) catch
        xfit.herrm("__system.allocator.create render_command");
    self.* = .{};
    __vulkan.load_instance_and_device();
    for (&self.*.__command_buffers) |*cmd| {
        cmd.* = __system.allocator.alloc(vk.CommandBuffer, __vulkan.get_swapchain_image_length()) catch
            xfit.herrm("render_command.__command_buffers.alloc");

        const allocInfo: vk.CommandBufferAllocateInfo = .{
            .command_pool = __vulkan.vkCommandPool,
            .level = .primary,
            .command_buffer_count = @intCast(__vulkan.get_swapchain_image_length()),
        };

        __vulkan.vkd.?.allocateCommandBuffers(&allocInfo, cmd.*.ptr) catch |e|
            xfit.herr3("render_command vkAllocateCommandBuffers vkCommandPool", e);
    }
    __render_command.mutex.lock();
    __render_command.render_cmd_list.?.append(self) catch xfit.herrm(" render_cmd_list.append(&self)");
    __render_command.mutex.unlock();
    return self;
}
pub fn deinit(self: *Self) void {
    __vulkan.load_instance_and_device();
    for (&self.__command_buffers) |*cmd| {
        __vulkan.vkd.?.freeCommandBuffers(__vulkan.vkCommandPool, @intCast(__vulkan.get_swapchain_image_length()), cmd.*.ptr);
        __system.allocator.free(cmd.*);
    }
    var i: usize = 0;
    __render_command.mutex.lock();
    while (i < __render_command.render_cmd_list.?.items.len) : (i += 1) {
        if (__render_command.render_cmd_list.?.items[i] == self) {
            _ = __render_command.render_cmd_list.?.orderedRemove(i);
            break;
        }
    }
    __render_command.mutex.unlock();
    __system.allocator.destroy(self);
}

///render_command안의 scene(구성)이 바뀔때 마다 호출(scene 내의 iobject 내부 리소스 값이 바뀔경우는 해당없음)
pub fn refresh(self: *Self) void {
    for (&self.*.__refesh) |*v| {
        @atomicStore(bool, v, true, .monotonic);
    }
}

const ERROR = error{IsDestroying};