//! NOTE: this file is autogenerated, DO NOT MODIFY
pub const composition_swapchain = @import("graphics/composition_swapchain.zig");
pub const direct2d = @import("graphics/direct2d.zig");
pub const direct3d = @import("graphics/direct3d.zig");
pub const direct3d10 = @import("graphics/direct3d10.zig");
pub const direct3d11 = @import("graphics/direct3d11.zig");
pub const direct3d11on12 = @import("graphics/direct3d11on12.zig");
pub const direct3d12 = @import("graphics/direct3d12.zig");
pub const direct3d9 = @import("graphics/direct3d9.zig");
pub const direct3d9on12 = @import("graphics/direct3d9on12.zig");
pub const direct_composition = @import("graphics/direct_composition.zig");
pub const direct_draw = @import("graphics/direct_draw.zig");
pub const direct_manipulation = @import("graphics/direct_manipulation.zig");
pub const direct_write = @import("graphics/direct_write.zig");
pub const dwm = @import("graphics/dwm.zig");
pub const dxcore = @import("graphics/dxcore.zig");
pub const dxgi = @import("graphics/dxgi.zig");
pub const gdi = @import("graphics/gdi.zig");
pub const hlsl = @import("graphics/hlsl.zig");
pub const imaging = @import("graphics/imaging.zig");
pub const open_gl = @import("graphics/open_gl.zig");
pub const printing = @import("graphics/printing.zig");
test {
    @import("std").testing.refAllDecls(@This());
}
