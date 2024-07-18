//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (2)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows8.0'
const IID_IWICImageEncoder_Value = Guid.initString("04c75bf8-3ce1-473b-acc5-3cc4f5e94999");
pub const IID_IWICImageEncoder = &IID_IWICImageEncoder_Value;
pub const IWICImageEncoder = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        WriteFrame: *const fn(
            self: *const IWICImageEncoder,
            pImage: ?*ID2D1Image,
            pFrameEncode: ?*IWICBitmapFrameEncode,
            pImageParameters: ?*const WICImageParameters,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        WriteFrameThumbnail: *const fn(
            self: *const IWICImageEncoder,
            pImage: ?*ID2D1Image,
            pFrameEncode: ?*IWICBitmapFrameEncode,
            pImageParameters: ?*const WICImageParameters,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        WriteThumbnail: *const fn(
            self: *const IWICImageEncoder,
            pImage: ?*ID2D1Image,
            pEncoder: ?*IWICBitmapEncoder,
            pImageParameters: ?*const WICImageParameters,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IWICImageEncoder_WriteFrame(self: *const T, pImage: ?*ID2D1Image, pFrameEncode: ?*IWICBitmapFrameEncode, pImageParameters: ?*const WICImageParameters) callconv(.Inline) HRESULT {
            return @as(*const IWICImageEncoder.VTable, @ptrCast(self.vtable)).WriteFrame(@as(*const IWICImageEncoder, @ptrCast(self)), pImage, pFrameEncode, pImageParameters);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IWICImageEncoder_WriteFrameThumbnail(self: *const T, pImage: ?*ID2D1Image, pFrameEncode: ?*IWICBitmapFrameEncode, pImageParameters: ?*const WICImageParameters) callconv(.Inline) HRESULT {
            return @as(*const IWICImageEncoder.VTable, @ptrCast(self.vtable)).WriteFrameThumbnail(@as(*const IWICImageEncoder, @ptrCast(self)), pImage, pFrameEncode, pImageParameters);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IWICImageEncoder_WriteThumbnail(self: *const T, pImage: ?*ID2D1Image, pEncoder: ?*IWICBitmapEncoder, pImageParameters: ?*const WICImageParameters) callconv(.Inline) HRESULT {
            return @as(*const IWICImageEncoder.VTable, @ptrCast(self.vtable)).WriteThumbnail(@as(*const IWICImageEncoder, @ptrCast(self)), pImage, pEncoder, pImageParameters);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows8.0'
const IID_IWICImagingFactory2_Value = Guid.initString("7b816b45-1996-4476-b132-de9e247c8af0");
pub const IID_IWICImagingFactory2 = &IID_IWICImagingFactory2_Value;
pub const IWICImagingFactory2 = extern struct {
    pub const VTable = extern struct {
        base: IWICImagingFactory.VTable,
        CreateImageEncoder: *const fn(
            self: *const IWICImagingFactory2,
            pD2DDevice: ?*ID2D1Device,
            ppWICImageEncoder: ?*?*IWICImageEncoder,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IWICImagingFactory.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IWICImagingFactory2_CreateImageEncoder(self: *const T, pD2DDevice: ?*ID2D1Device, ppWICImageEncoder: ?*?*IWICImageEncoder) callconv(.Inline) HRESULT {
            return @as(*const IWICImagingFactory2.VTable, @ptrCast(self.vtable)).CreateImageEncoder(@as(*const IWICImagingFactory2, @ptrCast(self)), pD2DDevice, ppWICImageEncoder);
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
// Section: Imports (9)
//--------------------------------------------------------------------------------
const Guid = @import("../../zig.zig").Guid;
const HRESULT = @import("../../foundation.zig").HRESULT;
const ID2D1Device = @import("../../graphics/direct2d.zig").ID2D1Device;
const ID2D1Image = @import("../../graphics/direct2d.zig").ID2D1Image;
const IUnknown = @import("../../system/com.zig").IUnknown;
const IWICBitmapEncoder = @import("../../graphics/imaging.zig").IWICBitmapEncoder;
const IWICBitmapFrameEncode = @import("../../graphics/imaging.zig").IWICBitmapFrameEncode;
const IWICImagingFactory = @import("../../graphics/imaging.zig").IWICImagingFactory;
const WICImageParameters = @import("../../graphics/imaging.zig").WICImageParameters;

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
