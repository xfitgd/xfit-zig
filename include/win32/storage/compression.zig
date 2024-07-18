//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (4)
//--------------------------------------------------------------------------------
pub const COMPRESS_ALGORITHM_INVALID = @as(u32, 0);
pub const COMPRESS_ALGORITHM_NULL = @as(u32, 1);
pub const COMPRESS_ALGORITHM_MAX = @as(u32, 6);
pub const COMPRESS_RAW = @as(u32, 536870912);

//--------------------------------------------------------------------------------
// Section: Types (6)
//--------------------------------------------------------------------------------
pub const COMPRESS_ALGORITHM = enum(u32) {
    MSZIP = 2,
    XPRESS = 3,
    XPRESS_HUFF = 4,
    LZMS = 5,
};
pub const COMPRESS_ALGORITHM_MSZIP = COMPRESS_ALGORITHM.MSZIP;
pub const COMPRESS_ALGORITHM_XPRESS = COMPRESS_ALGORITHM.XPRESS;
pub const COMPRESS_ALGORITHM_XPRESS_HUFF = COMPRESS_ALGORITHM.XPRESS_HUFF;
pub const COMPRESS_ALGORITHM_LZMS = COMPRESS_ALGORITHM.LZMS;

// TODO: this type has a FreeFunc 'CloseDecompressor', what can Zig do with this information?
// TODO: this type has an InvalidHandleValue of '0', what can Zig do with this information?
pub const COMPRESSOR_HANDLE = isize;

pub const PFN_COMPRESS_ALLOCATE = *const fn(
    UserContext: ?*anyopaque,
    Size: usize,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

pub const PFN_COMPRESS_FREE = *const fn(
    UserContext: ?*anyopaque,
    Memory: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) void;

pub const COMPRESS_ALLOCATION_ROUTINES = extern struct {
    Allocate: ?PFN_COMPRESS_ALLOCATE,
    Free: ?PFN_COMPRESS_FREE,
    UserContext: ?*anyopaque,
};

pub const COMPRESS_INFORMATION_CLASS = enum(i32) {
    INVALID = 0,
    BLOCK_SIZE = 1,
    LEVEL = 2,
};
pub const COMPRESS_INFORMATION_CLASS_INVALID = COMPRESS_INFORMATION_CLASS.INVALID;
pub const COMPRESS_INFORMATION_CLASS_BLOCK_SIZE = COMPRESS_INFORMATION_CLASS.BLOCK_SIZE;
pub const COMPRESS_INFORMATION_CLASS_LEVEL = COMPRESS_INFORMATION_CLASS.LEVEL;


//--------------------------------------------------------------------------------
// Section: Functions (12)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn CreateCompressor(
    Algorithm: COMPRESS_ALGORITHM,
    AllocationRoutines: ?*COMPRESS_ALLOCATION_ROUTINES,
    CompressorHandle: ?*isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn SetCompressorInformation(
    CompressorHandle: COMPRESSOR_HANDLE,
    CompressInformationClass: COMPRESS_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    CompressInformation: ?*const anyopaque,
    CompressInformationSize: usize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn QueryCompressorInformation(
    CompressorHandle: COMPRESSOR_HANDLE,
    CompressInformationClass: COMPRESS_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    CompressInformation: ?*anyopaque,
    CompressInformationSize: usize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn Compress(
    CompressorHandle: COMPRESSOR_HANDLE,
    // TODO: what to do with BytesParamIndex 2?
    UncompressedData: ?*const anyopaque,
    UncompressedDataSize: usize,
    // TODO: what to do with BytesParamIndex 4?
    CompressedBuffer: ?*anyopaque,
    CompressedBufferSize: usize,
    CompressedDataSize: ?*usize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn ResetCompressor(
    CompressorHandle: COMPRESSOR_HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn CloseCompressor(
    CompressorHandle: COMPRESSOR_HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn CreateDecompressor(
    Algorithm: COMPRESS_ALGORITHM,
    AllocationRoutines: ?*COMPRESS_ALLOCATION_ROUTINES,
    DecompressorHandle: ?*isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn SetDecompressorInformation(
    DecompressorHandle: isize,
    CompressInformationClass: COMPRESS_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    CompressInformation: ?*const anyopaque,
    CompressInformationSize: usize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn QueryDecompressorInformation(
    DecompressorHandle: isize,
    CompressInformationClass: COMPRESS_INFORMATION_CLASS,
    // TODO: what to do with BytesParamIndex 3?
    CompressInformation: ?*anyopaque,
    CompressInformationSize: usize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn Decompress(
    DecompressorHandle: isize,
    // TODO: what to do with BytesParamIndex 2?
    CompressedData: ?*const anyopaque,
    CompressedDataSize: usize,
    // TODO: what to do with BytesParamIndex 4?
    UncompressedBuffer: ?*anyopaque,
    UncompressedBufferSize: usize,
    UncompressedDataSize: ?*usize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn ResetDecompressor(
    DecompressorHandle: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "cabinet" fn CloseDecompressor(
    DecompressorHandle: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
    .ansi => struct {
    },
    .wide => struct {
    },
    .unspecified => if (@import("builtin").is_test) struct {
    } else struct {
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (1)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "PFN_COMPRESS_ALLOCATE")) { _ = PFN_COMPRESS_ALLOCATE; }
    if (@hasDecl(@This(), "PFN_COMPRESS_FREE")) { _ = PFN_COMPRESS_FREE; }

    @setEvalBranchQuota(
        comptime @import("std").meta.declarations(@This()).len * 3
    );

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (comptime @import("std").meta.declarations(@This())) |decl| {
        _ = @field(@This(), decl.name);
    }
}
