const std = @import("std");
const xfit = @import("xfit.zig");
const system = @import("system.zig");
const window = @import("window.zig");
const input = @import("input.zig");
const math = @import("math.zig");
const __system = @import("__system.zig");
const __vulkan = @import("__vulkan.zig");
const __vulkan_allocator = @import("__vulkan_allocator.zig");
const root = @import("root");

pub const c = @cImport({
    @cDefine("XK_LATIN1", "1");
    @cDefine("XK_MISCELLANY", "1");
    @cInclude("X11/Xlib.h");
    @cInclude("X11/keysym.h");
    @cInclude("X11/extensions/Xrandr.h");
});

pub var display: ?*c.Display = null;
pub var def_screen_idx: usize = 0;
pub var wnd: c.Window = 0;
pub var screens: ?*c.XRRScreenResources = undefined;
pub var del_window: c.Atom = undefined;

var input_thread: std.Thread = undefined;

pub fn system_linux_start() void {
    display = c.XOpenDisplay(null);
    if (display == null) xfit.herrm("system_linux_start XOpenDisplay");
    def_screen_idx = @max(0, c.DefaultScreen(display));
    screens = c.XRRGetScreenResources(display, c.DefaultRootWindow(display));

    var i: usize = 0;
    while (i < screens.?.*.ncrtc) : (i += 1) {
        const crtc_info = c.XRRGetCrtcInfo(display, screens, screens.?.*.crtcs[i]);
        defer c.XRRFreeCrtcInfo(crtc_info);

        __system.monitors.append(system.monitor_info{
            .is_primary = i == def_screen_idx,
            .rect = math.recti.init(
                crtc_info.*.x,
                crtc_info.*.x + @as(c_int, @intCast(crtc_info.*.width)),
                crtc_info.*.y,
                crtc_info.*.y + @as(c_int, @intCast(crtc_info.*.height)),
            ),
            .resolutions = std.ArrayList(system.screen_info).init(std.heap.c_allocator),
        }) catch |e| xfit.herr3("MonitorEnumProc __system.monitors.append", e);
        const last = &__system.monitors.items[__system.monitors.items.len - 1];
        if (last.*.is_primary) __system.primary_monitor = last;
        //TODO resolutions add and primary_resolution
    }
}

fn render_func() void {
    //var ring = std.os.linux.IoUring.init(64, 0) catch |e| xfit.herr3("input_func IoUring.init", e);
    //var sqe = ring.get_sqe() catch |e| xfit.herr3("input_func ring.get_sqe", e);
    __vulkan.vulkan_start();

    root.xfit_init() catch |e| {
        xfit.herr3("xfit_init", e);
    };

    __vulkan_allocator.execute_and_wait_all_op();

    while (!xfit.exiting()) {
        __system.loop();
    }
    __vulkan_allocator.execute_and_wait_all_op();

    __vulkan.wait_device_idle();

    root.xfit_destroy() catch |e| {
        xfit.herr3("xfit_destroy", e);
    };

    __vulkan.vulkan_destroy();
}

pub fn linux_start() void {
    if (__system.init_set.window_width == xfit.init_setting.DEF_SIZE or __system.init_set.window_width == 0) __system.init_set.window_width = 960;
    if (__system.init_set.window_height == xfit.init_setting.DEF_SIZE or __system.init_set.window_height == 0) __system.init_set.window_height = 540;
    if (__system.init_set.window_x == xfit.init_setting.DEF_POS) __system.init_set.window_x = 0;
    if (__system.init_set.window_y == xfit.init_setting.DEF_POS) __system.init_set.window_y = 0;

    if (__system.init_set.screen_index > screens.?.*.ncrtc - 1) __system.init_set.screen_index = @intCast(def_screen_idx);

    wnd = c.XCreateWindow(
        display,
        @as(c_ulong, @intCast(c.RootWindow(display, __system.init_set.screen_index))),
        __system.init_set.window_x,
        __system.init_set.window_y,
        __system.init_set.window_width,
        __system.init_set.window_height,
        0,
        c.CopyFromParent,
        c.CopyFromParent,
        c.CopyFromParent,
        0,
        null,
    );
    _ = c.XSelectInput(display, wnd, c.KeyPressMask | c.KeyReleaseMask | c.ButtonReleaseMask | c.ButtonPressMask | c.PointerMotionMask | c.StructureNotifyMask);
    _ = c.XMapWindow(display, wnd);
    del_window = c.XInternAtom(display, "WM_DELETE_WINDOW", 0);
    _ = c.XSetWMProtocols(display, wnd, &del_window, 1);
    _ = c.XFlush(display);

    input_thread = std.Thread.spawn(.{}, render_func, .{}) catch unreachable;
}

pub fn vulkan_linux_start(vkSurface: *__vulkan.vk.SurfaceKHR) void {
    __vulkan.load_instance_and_device();
    if (vkSurface.* != .null_handle) {
        __vulkan.vki.?.destroySurfaceKHR(vkSurface.*, null);
    }
    const xlibSurfaceCreateInfo: __vulkan.vk.XlibSurfaceCreateInfoKHR = .{
        .window = wnd,
        .dpy = @ptrCast(display.?),
    };
    vkSurface.* = __vulkan.vki.?.createXlibSurfaceKHR(&xlibSurfaceCreateInfo, null) catch |e|
        xfit.herr3("createXlibSurfaceKHR", e);
}

pub fn linux_loop() void {
    var event: c.XEvent = undefined;
    while (!xfit.exiting()) {
        _ = c.XNextEvent(display, &event);
        switch (event.type) {
            c.ConfigureNotify => {
                const w = window.window_width();
                const h = window.window_height();
                const x = window.window_x();
                const y = window.window_y();
                if (w != event.xconfigure.width or h != event.xconfigure.height) {
                    @atomicStore(u32, &__system.init_set.window_width, @abs(event.xconfigure.width), .monotonic);
                    @atomicStore(u32, &__system.init_set.window_height, @abs(event.xconfigure.height), .monotonic);

                    if (__system.loop_start.load(.monotonic)) {
                        root.xfit_size() catch |e| {
                            xfit.herr3("xfit_size", e);
                        };
                        __system.size_update.store(true, .monotonic);
                    }
                }
                if (x != event.xconfigure.x or y != event.xconfigure.y) {
                    @atomicStore(i32, &__system.init_set.window_x, event.xconfigure.x, .monotonic);
                    @atomicStore(i32, &__system.init_set.window_y, event.xconfigure.y, .monotonic);

                    system.a_fn_call(__system.window_move_func, .{}) catch {};
                }
            },
            c.ClientMessage => {
                if (event.xclient.data.l[0] == del_window) {
                    __system.exiting.store(true, std.builtin.AtomicOrder.release);
                    return;
                }
            },
            c.KeyPress => {
                const keyr = c.XLookupKeysym(&event.xkey, 0);
                if (keyr > 0xffff) continue;
                var keyv: u16 = @intCast(keyr);
                const key: input.key = @enumFromInt(keyv);
                if (keyv > 0xff and keyv < 0xff00) {
                    @branchHint(.cold);
                    xfit.print("WARN linux_loop KeyPress out of range __system.keys[{d}] value : {d}\n", .{ __system.KEY_SIZE, keyv });
                    continue;
                } else if (keyv >= 0xff00) {
                    keyv = keyv - 0xff00 + 0xff;
                }
                //다른 스레드에서 __system.keys[keyv]를 수정하지 않고 읽기만하니 weak로도 충분하다.
                if (__system.keys[keyv].cmpxchgWeak(false, true, .monotonic, .monotonic) == null) {
                    //xfit.print_debug("input key_down {d}", .{wParam});
                    system.a_fn_call(__system.key_down_func, .{key}) catch {};
                }
            },
            c.KeyRelease => {
                const keyr = c.XLookupKeysym(&event.xkey, 0);
                if (keyr > 0xffff) continue;
                var keyv: u16 = @intCast(keyr);
                const key: input.key = @enumFromInt(keyv);
                if (keyv > 0xff and keyv < 0xff00) {
                    @branchHint(.cold);
                    xfit.print("WARN linux_loop KeyRelease out of range __system.keys[{d}] value : {d}\n", .{ __system.KEY_SIZE, keyv });
                    continue;
                } else if (keyv >= 0xff00) {
                    keyv = keyv - 0xff00 + 0xff;
                }
                __system.keys[keyv].store(false, std.builtin.AtomicOrder.monotonic);
                //xfit.print_debug("input key_up {d}", .{wParam});
                system.a_fn_call(__system.key_up_func, .{key}) catch {};
            },
            c.ButtonPress, c.ButtonRelease => |e| {
                switch (event.xbutton.button) {
                    1 => {
                        __system.Lmouse_click.store(e == c.ButtonPress, std.builtin.AtomicOrder.monotonic);
                        const mm = input.convert_set_mouse_pos(.{ @floatFromInt(event.xbutton.x), @floatFromInt(event.xbutton.y) });
                        system.a_fn_call(if (e == c.ButtonPress) __system.Lmouse_down_func else __system.Lmouse_up_func, .{mm}) catch {};
                    },
                    2 => {
                        __system.Mmouse_click.store(e == c.ButtonPress, std.builtin.AtomicOrder.monotonic);
                        const mm = input.convert_set_mouse_pos(.{ @floatFromInt(event.xbutton.x), @floatFromInt(event.xbutton.y) });
                        system.a_fn_call(if (e == c.ButtonPress) __system.Mmouse_down_func else __system.Mmouse_up_func, .{mm}) catch {};
                    },
                    3 => {
                        __system.Rmouse_click.store(e == c.ButtonPress, std.builtin.AtomicOrder.monotonic);
                        const mm = input.convert_set_mouse_pos(.{ @floatFromInt(event.xbutton.x), @floatFromInt(event.xbutton.y) });
                        system.a_fn_call(if (e == c.ButtonPress) __system.Rmouse_down_func else __system.Rmouse_up_func, .{mm}) catch {};
                    },
                    //8 => {}, Back
                    //9 => {}, Front
                    else => {},
                }
            },
            c.MotionNotify => {
                const w = window.window_width();
                const h = window.window_height();
                const mm = input.convert_set_mouse_pos(.{ @floatFromInt(event.xmotion.x), @floatFromInt(event.xmotion.y) });
                @atomicStore(f64, @as(*f64, @ptrCast(&__system.cursor_pos)), @bitCast(mm), .monotonic);
                if (input.is_mouse_out()) {
                    if (event.xmotion.x >= 0 and event.xmotion.y >= 0 and event.xmotion.x <= w and event.xmotion.y <= h) {
                        __system.mouse_out.store(false, .monotonic);
                        system.a_fn_call(__system.mouse_hover_func, .{}) catch {};
                    }
                } else {
                    if (event.xmotion.x < 0 or event.xmotion.y < 0 or event.xmotion.x > w or event.xmotion.y > h) {
                        __system.mouse_out.store(true, .monotonic);
                        system.a_fn_call(__system.mouse_leave_func, .{}) catch {};
                    }
                }
                system.a_fn_call(__system.mouse_move_func, .{mm}) catch {};
            },
            else => {},
        }
    }
}

pub fn linux_close() void {
    var event: c.XEvent = undefined;
    event.xclient.type = c.ClientMessage;
    event.xclient.window = wnd;
    event.xclient.message_type = c.XInternAtom(display, "WM_PROTOCOLS", 1);
    event.xclient.format = 32;
    event.xclient.data.l[0] = @intCast(c.XInternAtom(display, "WM_DELETE_WINDOW", 0));
    event.xclient.data.l[1] = c.CurrentTime;
    _ = c.XSendEvent(display, wnd, c.False, c.NoEventMask, &event);
}

pub fn linux_destroy() void {
    input_thread.join();
    _ = c.XDestroyWindow(display, wnd);
    _ = c.XCloseDisplay(display);

    c.XRRFreeScreenResources(screens);
}
