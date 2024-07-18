//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (9)
//--------------------------------------------------------------------------------
const IID_ICompositionDrawingSurfaceInterop_Value = Guid.initString("fd04e6e3-fe0c-4c3c-ab19-a07601a576ee");
pub const IID_ICompositionDrawingSurfaceInterop = &IID_ICompositionDrawingSurfaceInterop_Value;
pub const ICompositionDrawingSurfaceInterop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        BeginDraw: *const fn(
            self: *const ICompositionDrawingSurfaceInterop,
            updateRect: ?*const RECT,
            iid: ?*const Guid,
            updateObject: ?*?*anyopaque,
            updateOffset: ?*POINT,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        EndDraw: *const fn(
            self: *const ICompositionDrawingSurfaceInterop,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        Resize: *const fn(
            self: *const ICompositionDrawingSurfaceInterop,
            sizePixels: SIZE,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        Scroll: *const fn(
            self: *const ICompositionDrawingSurfaceInterop,
            scrollRect: ?*const RECT,
            clipRect: ?*const RECT,
            offsetX: i32,
            offsetY: i32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ResumeDraw: *const fn(
            self: *const ICompositionDrawingSurfaceInterop,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        SuspendDraw: *const fn(
            self: *const ICompositionDrawingSurfaceInterop,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionDrawingSurfaceInterop_BeginDraw(self: *const T, updateRect: ?*const RECT, iid: ?*const Guid, updateObject: ?*?*anyopaque, updateOffset: ?*POINT) callconv(.Inline) HRESULT {
            return @as(*const ICompositionDrawingSurfaceInterop.VTable, @ptrCast(self.vtable)).BeginDraw(@as(*const ICompositionDrawingSurfaceInterop, @ptrCast(self)), updateRect, iid, updateObject, updateOffset);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionDrawingSurfaceInterop_EndDraw(self: *const T) callconv(.Inline) HRESULT {
            return @as(*const ICompositionDrawingSurfaceInterop.VTable, @ptrCast(self.vtable)).EndDraw(@as(*const ICompositionDrawingSurfaceInterop, @ptrCast(self)));
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionDrawingSurfaceInterop_Resize(self: *const T, sizePixels: SIZE) callconv(.Inline) HRESULT {
            return @as(*const ICompositionDrawingSurfaceInterop.VTable, @ptrCast(self.vtable)).Resize(@as(*const ICompositionDrawingSurfaceInterop, @ptrCast(self)), sizePixels);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionDrawingSurfaceInterop_Scroll(self: *const T, scrollRect: ?*const RECT, clipRect: ?*const RECT, offsetX: i32, offsetY: i32) callconv(.Inline) HRESULT {
            return @as(*const ICompositionDrawingSurfaceInterop.VTable, @ptrCast(self.vtable)).Scroll(@as(*const ICompositionDrawingSurfaceInterop, @ptrCast(self)), scrollRect, clipRect, offsetX, offsetY);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionDrawingSurfaceInterop_ResumeDraw(self: *const T) callconv(.Inline) HRESULT {
            return @as(*const ICompositionDrawingSurfaceInterop.VTable, @ptrCast(self.vtable)).ResumeDraw(@as(*const ICompositionDrawingSurfaceInterop, @ptrCast(self)));
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionDrawingSurfaceInterop_SuspendDraw(self: *const T) callconv(.Inline) HRESULT {
            return @as(*const ICompositionDrawingSurfaceInterop.VTable, @ptrCast(self.vtable)).SuspendDraw(@as(*const ICompositionDrawingSurfaceInterop, @ptrCast(self)));
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_ICompositionDrawingSurfaceInterop2_Value = Guid.initString("41e64aae-98c0-4239-8e95-a330dd6aa18b");
pub const IID_ICompositionDrawingSurfaceInterop2 = &IID_ICompositionDrawingSurfaceInterop2_Value;
pub const ICompositionDrawingSurfaceInterop2 = extern struct {
    pub const VTable = extern struct {
        base: ICompositionDrawingSurfaceInterop.VTable,
        CopySurface: *const fn(
            self: *const ICompositionDrawingSurfaceInterop2,
            destinationResource: ?*IUnknown,
            destinationOffsetX: i32,
            destinationOffsetY: i32,
            sourceRectangle: ?*const RECT,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace ICompositionDrawingSurfaceInterop.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionDrawingSurfaceInterop2_CopySurface(self: *const T, destinationResource: ?*IUnknown, destinationOffsetX: i32, destinationOffsetY: i32, sourceRectangle: ?*const RECT) callconv(.Inline) HRESULT {
            return @as(*const ICompositionDrawingSurfaceInterop2.VTable, @ptrCast(self.vtable)).CopySurface(@as(*const ICompositionDrawingSurfaceInterop2, @ptrCast(self)), destinationResource, destinationOffsetX, destinationOffsetY, sourceRectangle);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_ICompositionGraphicsDeviceInterop_Value = Guid.initString("a116ff71-f8bf-4c8a-9c98-70779a32a9c8");
pub const IID_ICompositionGraphicsDeviceInterop = &IID_ICompositionGraphicsDeviceInterop_Value;
pub const ICompositionGraphicsDeviceInterop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetRenderingDevice: *const fn(
            self: *const ICompositionGraphicsDeviceInterop,
            value: ?*?*IUnknown,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        SetRenderingDevice: *const fn(
            self: *const ICompositionGraphicsDeviceInterop,
            value: ?*IUnknown,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionGraphicsDeviceInterop_GetRenderingDevice(self: *const T, value: ?*?*IUnknown) callconv(.Inline) HRESULT {
            return @as(*const ICompositionGraphicsDeviceInterop.VTable, @ptrCast(self.vtable)).GetRenderingDevice(@as(*const ICompositionGraphicsDeviceInterop, @ptrCast(self)), value);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionGraphicsDeviceInterop_SetRenderingDevice(self: *const T, value: ?*IUnknown) callconv(.Inline) HRESULT {
            return @as(*const ICompositionGraphicsDeviceInterop.VTable, @ptrCast(self.vtable)).SetRenderingDevice(@as(*const ICompositionGraphicsDeviceInterop, @ptrCast(self)), value);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_ICompositorInterop_Value = Guid.initString("25297d5c-3ad4-4c9c-b5cf-e36a38512330");
pub const IID_ICompositorInterop = &IID_ICompositorInterop_Value;
pub const ICompositorInterop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        CreateCompositionSurfaceForHandle: *const fn(
            self: *const ICompositorInterop,
            swapChain: ?HANDLE,
            result: ?**struct{comment: []const u8 = "MissingClrType ICompositionSurface.Windows.UI.Composition"},
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        CreateCompositionSurfaceForSwapChain: *const fn(
            self: *const ICompositorInterop,
            swapChain: ?*IUnknown,
            result: ?**struct{comment: []const u8 = "MissingClrType ICompositionSurface.Windows.UI.Composition"},
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        CreateGraphicsDevice: *const fn(
            self: *const ICompositorInterop,
            renderingDevice: ?*IUnknown,
            result: ?**struct{comment: []const u8 = "MissingClrType CompositionGraphicsDevice.Windows.UI.Composition"},
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositorInterop_CreateCompositionSurfaceForHandle(self: *const T, swapChain: ?HANDLE, result: ?**struct{comment: []const u8 = "MissingClrType ICompositionSurface.Windows.UI.Composition"}) callconv(.Inline) HRESULT {
            return @as(*const ICompositorInterop.VTable, @ptrCast(self.vtable)).CreateCompositionSurfaceForHandle(@as(*const ICompositorInterop, @ptrCast(self)), swapChain, result);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositorInterop_CreateCompositionSurfaceForSwapChain(self: *const T, swapChain: ?*IUnknown, result: ?**struct{comment: []const u8 = "MissingClrType ICompositionSurface.Windows.UI.Composition"}) callconv(.Inline) HRESULT {
            return @as(*const ICompositorInterop.VTable, @ptrCast(self.vtable)).CreateCompositionSurfaceForSwapChain(@as(*const ICompositorInterop, @ptrCast(self)), swapChain, result);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositorInterop_CreateGraphicsDevice(self: *const T, renderingDevice: ?*IUnknown, result: ?**struct{comment: []const u8 = "MissingClrType CompositionGraphicsDevice.Windows.UI.Composition"}) callconv(.Inline) HRESULT {
            return @as(*const ICompositorInterop.VTable, @ptrCast(self.vtable)).CreateGraphicsDevice(@as(*const ICompositorInterop, @ptrCast(self)), renderingDevice, result);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_ISwapChainInterop_Value = Guid.initString("26f496a0-7f38-45fb-88f7-faaabe67dd59");
pub const IID_ISwapChainInterop = &IID_ISwapChainInterop_Value;
pub const ISwapChainInterop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        SetSwapChain: *const fn(
            self: *const ISwapChainInterop,
            swapChain: ?*IUnknown,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ISwapChainInterop_SetSwapChain(self: *const T, swapChain: ?*IUnknown) callconv(.Inline) HRESULT {
            return @as(*const ISwapChainInterop.VTable, @ptrCast(self.vtable)).SetSwapChain(@as(*const ISwapChainInterop, @ptrCast(self)), swapChain);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IVisualInteractionSourceInterop_Value = Guid.initString("11f62cd1-2f9d-42d3-b05f-d6790d9e9f8e");
pub const IID_IVisualInteractionSourceInterop = &IID_IVisualInteractionSourceInterop_Value;
pub const IVisualInteractionSourceInterop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        TryRedirectForManipulation: *const fn(
            self: *const IVisualInteractionSourceInterop,
            pointerInfo: ?*const POINTER_INFO,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IVisualInteractionSourceInterop_TryRedirectForManipulation(self: *const T, pointerInfo: ?*const POINTER_INFO) callconv(.Inline) HRESULT {
            return @as(*const IVisualInteractionSourceInterop.VTable, @ptrCast(self.vtable)).TryRedirectForManipulation(@as(*const IVisualInteractionSourceInterop, @ptrCast(self)), pointerInfo);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_ICompositionCapabilitiesInteropFactory_Value = Guid.initString("2c9db356-e70d-4642-8298-bc4aa5b4865c");
pub const IID_ICompositionCapabilitiesInteropFactory = &IID_ICompositionCapabilitiesInteropFactory_Value;
pub const ICompositionCapabilitiesInteropFactory = extern struct {
    pub const VTable = extern struct {
        base: IInspectable.VTable,
        GetForWindow: *const fn(
            self: *const ICompositionCapabilitiesInteropFactory,
            hwnd: ?HWND,
            result: ?**struct{comment: []const u8 = "MissingClrType CompositionCapabilities.Windows.UI.Composition"},
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IInspectable.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositionCapabilitiesInteropFactory_GetForWindow(self: *const T, hwnd: ?HWND, result: ?**struct{comment: []const u8 = "MissingClrType CompositionCapabilities.Windows.UI.Composition"}) callconv(.Inline) HRESULT {
            return @as(*const ICompositionCapabilitiesInteropFactory.VTable, @ptrCast(self.vtable)).GetForWindow(@as(*const ICompositionCapabilitiesInteropFactory, @ptrCast(self)), hwnd, result);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_ICompositorDesktopInterop_Value = Guid.initString("29e691fa-4567-4dca-b319-d0f207eb6807");
pub const IID_ICompositorDesktopInterop = &IID_ICompositorDesktopInterop_Value;
pub const ICompositorDesktopInterop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        CreateDesktopWindowTarget: *const fn(
            self: *const ICompositorDesktopInterop,
            hwndTarget: ?HWND,
            isTopmost: BOOL,
            result: ?**struct{comment: []const u8 = "MissingClrType DesktopWindowTarget.Windows.UI.Composition.Desktop"},
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        EnsureOnThread: *const fn(
            self: *const ICompositorDesktopInterop,
            threadId: u32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositorDesktopInterop_CreateDesktopWindowTarget(self: *const T, hwndTarget: ?HWND, isTopmost: BOOL, result: ?**struct{comment: []const u8 = "MissingClrType DesktopWindowTarget.Windows.UI.Composition.Desktop"}) callconv(.Inline) HRESULT {
            return @as(*const ICompositorDesktopInterop.VTable, @ptrCast(self.vtable)).CreateDesktopWindowTarget(@as(*const ICompositorDesktopInterop, @ptrCast(self)), hwndTarget, isTopmost, result);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICompositorDesktopInterop_EnsureOnThread(self: *const T, threadId: u32) callconv(.Inline) HRESULT {
            return @as(*const ICompositorDesktopInterop.VTable, @ptrCast(self.vtable)).EnsureOnThread(@as(*const ICompositorDesktopInterop, @ptrCast(self)), threadId);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IDesktopWindowTargetInterop_Value = Guid.initString("35dbf59e-e3f9-45b0-81e7-fe75f4145dc9");
pub const IID_IDesktopWindowTargetInterop = &IID_IDesktopWindowTargetInterop_Value;
pub const IDesktopWindowTargetInterop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        // TODO: this function has a "SpecialName", should Zig do anything with this?
        get_Hwnd: *const fn(
            self: *const IDesktopWindowTargetInterop,
            value: ?*?HWND,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IDesktopWindowTargetInterop_get_Hwnd(self: *const T, value: ?*?HWND) callconv(.Inline) HRESULT {
            return @as(*const IDesktopWindowTargetInterop.VTable, @ptrCast(self.vtable)).get_Hwnd(@as(*const IDesktopWindowTargetInterop, @ptrCast(self)), value);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};


//--------------------------------------------------------------------------------
// Section: Functions (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../../zig.zig").unicode_mode) {
    .ansi => struct {
    },
    .wide => struct {
    },
    .unspecified => if (@import("builtin").is_test) struct {
    } else struct {
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (11)
//--------------------------------------------------------------------------------
const Guid = @import("../../zig.zig").Guid;
const BOOL = @import("../../foundation.zig").BOOL;
const HANDLE = @import("../../foundation.zig").HANDLE;
const HRESULT = @import("../../foundation.zig").HRESULT;
const HWND = @import("../../foundation.zig").HWND;
const IInspectable = @import("../../system/win_rt.zig").IInspectable;
const IUnknown = @import("../../system/com.zig").IUnknown;
const POINT = @import("../../foundation.zig").POINT;
const POINTER_INFO = @import("../../ui/input/pointer.zig").POINTER_INFO;
const RECT = @import("../../foundation.zig").RECT;
const SIZE = @import("../../foundation.zig").SIZE;

test {
    @setEvalBranchQuota(
        comptime @import("std").meta.declarations(@This()).len * 3
    );

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (comptime @import("std").meta.declarations(@This())) |decl| {
        _ = @field(@This(), decl.name);
    }
}
