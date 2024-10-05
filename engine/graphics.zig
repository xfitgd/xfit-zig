const std = @import("std");

const system = @import("system.zig");
const window = @import("window.zig");
const __system = @import("__system.zig");

const dbg = system.dbg;

const __vulkan_allocator = @import("__vulkan_allocator.zig");

const _allocator = __system.allocator;

const __vulkan = @import("__vulkan.zig");
const vk = __vulkan.vk;

const math = @import("math.zig");
const geometry = @import("geometry.zig");
const render_command = @import("render_command.zig");
const line = geometry.line;
const mem = @import("mem.zig");
const point = math.point;
const vector = math.vector;
const matrix = math.matrix;
const matrix_error = math.matrix_error;

const vulkan_res_node = __vulkan_allocator.vulkan_res_node;

///use make_shape2d_data fn
pub const indices16 = indices_(.U16);
pub const indices32 = indices_(.U32);
pub const indices = indices_(DEF_IDX_TYPE_);

pub const dummy_vertices = [@sizeOf(vertices(u8))]u8;
pub const dummy_indices = [@sizeOf(indices)]u8;
pub const dummy_object = [@max(@sizeOf(shape), @sizeOf(image))]u8;

pub fn take_vertices(dest_type: type, src_ptrmempool: anytype) !dest_type {
    return @as(dest_type, @alignCast(@ptrCast(try src_ptrmempool.*.create())));
}
pub const take_indices = take_vertices;
pub const take_object = take_vertices;

pub const write_flag = enum { read_gpu, readwrite_cpu };

pub const shape_color_vertex_2d = extern struct {
    pos: point align(1),
    uvw: [3]f32 align(1),

    pub inline fn get_pipeline() *__vulkan.pipeline_set {
        return &__vulkan.shape_color_2d_pipeline_set;
    }
};

pub const tex_vertex_2d = extern struct {
    pos: point align(1),
    uv: point align(1),

    pub inline fn get_pipeline() *__vulkan.pipeline_set {
        return &__vulkan.tex_2d_pipeline_set;
    }
};

pub var render_cmd: ?*render_command = null;

pub const index_type = enum { U16, U32 };
pub const DEF_IDX_TYPE_: index_type = .U32;
pub const DEF_IDX_TYPE = indices_(DEF_IDX_TYPE_).idxT;

fn find_memory_type(_type_filter: u32, _prop: vk.VkMemoryPropertyFlags) u32 {
    var mem_prop: vk.VkPhysicalDeviceMemoryProperties = undefined;
    vk.vkGetPhysicalDeviceMemoryProperties(__vulkan.vk_physical_devices[0], &mem_prop);

    var i: u32 = 0;
    while (i < mem_prop.memoryTypeCount) : (i += 1) {
        if ((_type_filter & (@as(u32, 1) << @intCast(i)) != 0) and (mem_prop.memoryTypes[i].propertyFlags & _prop == _prop)) {
            return i;
        }
    }
    system.handle_error_msg2("find_memory_type.memory_type_not_found");
}

pub const ivertices = struct {
    const Self = @This();

    get_vertices_len: *const fn (self: *Self) usize = undefined,
    deinit: *const fn (self: *Self) void = undefined,
    deinit_for_alloc: *const fn (self: *Self) void = undefined,

    node: vulkan_res_node(.buffer) = .{},
    pipeline: *__vulkan.pipeline_set = undefined,

    pub inline fn clean(self: *Self) void {
        self.*.node.clean();
    }
};
pub const iindices = struct {
    const Self = @This();

    get_indices_len: *const fn (self: *Self) usize = undefined,
    deinit: *const fn (self: *Self) void = undefined,
    deinit_for_alloc: *const fn (self: *Self) void = undefined,

    node: vulkan_res_node(.buffer) = .{},
    idx_type: index_type = undefined,

    pub inline fn clean(self: *Self) void {
        self.*.node.clean();
    }
};

pub fn vertices(comptime vertexT: type) type {
    return struct {
        const Self = @This();

        array: ?[]vertexT = null,
        interface: ivertices = .{},
        allocator: std.mem.Allocator = undefined,

        pub fn init() Self {
            var self: Self = .{};
            self.interface.pipeline = vertexT.get_pipeline();

            self.interface.get_vertices_len = get_vertices_len;
            self.interface.deinit = _deinit;
            return self;
        }
        pub fn init_for_alloc(__allocator: std.mem.Allocator) Self {
            var self: Self = .{};
            self.interface.pipeline = vertexT.get_pipeline();

            self.interface.get_vertices_len = get_vertices_len;
            self.interface.deinit = _deinit;
            self.interface.deinit_for_alloc = _deinit_for_alloc;
            self.allocator = __allocator;
            return self;
        }
        fn get_vertices_len(_interface: *ivertices) usize {
            const self = @as(*Self, @fieldParentPtr("interface", _interface));
            return self.*.array.?.len;
        }
        fn _deinit(_interface: *ivertices) void {
            const self = @as(*Self, @fieldParentPtr("interface", _interface));
            deinit(self);
        }
        fn _deinit_for_alloc(_interface: *ivertices) void {
            const self = @as(*Self, @fieldParentPtr("interface", _interface));
            deinit_for_alloc(self);
        }
        ///완전히 정리
        pub inline fn deinit(self: *Self) void {
            clean(self);
        }
        ///완전히 정리
        pub inline fn deinit_for_alloc(self: *Self) void {
            self.allocator.free(self.array.?);
            clean(self);
        }
        ///다시 빌드할수 있게 버퍼 내용만 정리
        pub inline fn clean(self: *Self) void {
            self.*.interface.clean();
        }
        pub fn build(self: *Self, _flag: write_flag) void {
            clean(self);
            create_buffer(vk.VK_BUFFER_USAGE_VERTEX_BUFFER_BIT, _flag, @sizeOf(vertexT) * self.*.array.?.len, &self.*.interface.node, std.mem.sliceAsBytes(self.*.array.?));
        }
        ///write_flag가 readwrite_cpu만 호출
        pub fn map_update(self: *Self) void {
            var data: ?*vertexT = undefined;
            self.*.interface.node.map(@ptrCast(&data));
            mem.memcpy_nonarray(data.?, self.*.array.ptr);
            self.*.interface.node.unmap();
        }
    };
}

pub fn check_vk_allocator() void {
    if (__vulkan.vk_allocator == null) {
        __vulkan.vk_allocator_mutex.lock();
        if (__vulkan.vk_allocator_use_free) {
            for (__vulkan.vk_allocators.items) |v| {
                if (v.*.is_free) {
                    __vulkan.vk_allocator = &v.*.alloc;
                    v.*.is_free = false;
                    break;
                }
            }
            __vulkan.vk_allocator_free_count -= 1;
            if (__vulkan.vk_allocator_free_count == 0) {
                __vulkan.vk_allocator_use_free = false;
            }
        } else {
            const res = __vulkan.pvk_allocators.create() catch |e| system.handle_error3("graphics.check_vk_allocator.pvk_allocators.create()", e);
            res.*.alloc = __vulkan_allocator.init();
            res.*.is_free = false;
            __vulkan.vk_allocators.append(res) catch |e| system.handle_error3("graphics.check_vk_allocator.vk_allocators.append()", e);
            __vulkan.vk_allocator = &res.*.alloc;
        }
        __vulkan.vk_allocator_mutex.unlock();
    }
}

///다른 스레드에서 graphics 개체.build 함수를 호출해서 메모리를 할당한적이 있을때 호출합니다. -> 안했으면 null 검사로 넘어감.
pub fn deinit_vk_allocator_thread() void {
    if (__vulkan.vk_allocator != null) {
        __vulkan.vk_allocator_mutex.lock();
        defer __vulkan.vk_allocator_mutex.unlock();
        if (__vulkan.vk_allocator_is_destroyed) return;
        if (dbg) {
            if (__vulkan.vk_allocator == &__vulkan.vk_allocators.items[0].alloc) { //0번은 메인스레드라 지우면 안됩니다.
                system.print_error("WARN cant deinit main thread vk_allocators.items[0]\n", .{});
                return;
            }
            if (system.platform == .windows and __vulkan.vk_allocator == &__vulkan.vk_allocators.items[1].alloc) { //윈도우즈 환경일때 1번은 메인스레드라 지우면 안됩니다.
                system.print_error("WARN cant deinit main thread vk_allocators.items[1]\n", .{});
                return;
            }
        }

        var i: usize = 0;
        for (__vulkan.vk_allocators.items) |v| {
            if (&v.*.alloc == __vulkan.vk_allocator) {
                if (__vulkan.vk_allocators.items.len > __vulkan.vk_allocator_FREE_MAX) {
                    v.*.alloc.deinit();
                    _ = __vulkan.vk_allocators.orderedRemove(i);
                } else {
                    v.*.is_free = true;
                    __vulkan.vk_allocator_free_count += 1;

                    if (__vulkan.vk_allocator_free_count >= __vulkan.vk_allocator_FREE_MAX) __vulkan.vk_allocator_use_free = true;
                }
                break;
            }
            i += 1;
        }
        __vulkan.vk_allocator = null;
    }
}

pub fn create_buffer(usage: vk.VkBufferUsageFlags, _flag: write_flag, size: u64, _out_vulkan_buffer_node: *vulkan_res_node(.buffer), _data: ?[]const u8) void {
    const buf_info: vk.VkBufferCreateInfo = .{ .sType = vk.VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO, .size = size, .usage = usage, .sharingMode = vk.VK_SHARING_MODE_EXCLUSIVE };

    const prop: vk.VkMemoryPropertyFlags =
        switch (_flag) {
        .read_gpu => vk.VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT,
        .readwrite_cpu => vk.VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | vk.VK_MEMORY_PROPERTY_HOST_COHERENT_BIT,
    };
    check_vk_allocator();
    __vulkan.vk_allocator.?.*.create_buffer(&buf_info, prop, _out_vulkan_buffer_node, _data);
}

pub fn indices_(comptime _type: index_type) type {
    return struct {
        const Self = @This();
        const idxT = switch (_type) {
            .U16 => u16,
            .U32 => u32,
        };

        array: ?[]idxT = null,
        interface: iindices = .{},
        allocator: std.mem.Allocator = undefined,

        pub fn init() Self {
            var self: Self = .{};
            self.interface.get_indices_len = get_indices_len;
            self.interface.idx_type = _type;
            self.interface.deinit = _deinit;
            return self;
        }
        pub fn init_for_alloc(__allocator: std.mem.Allocator) Self {
            var self: Self = .{};
            self.interface.get_indices_len = get_indices_len;
            self.interface.idx_type = _type;
            self.interface.deinit = _deinit;
            self.interface.deinit_for_alloc = _deinit_for_alloc;
            self.allocator = __allocator;
            return self;
        }
        fn _deinit(_interface: *iindices) void {
            const self = @as(*Self, @fieldParentPtr("interface", _interface));
            deinit(self);
        }
        fn _deinit_for_alloc(_interface: *iindices) void {
            const self = @as(*Self, @fieldParentPtr("interface", _interface));
            deinit_for_alloc(self);
        }
        ///완전히 정리
        pub inline fn deinit(self: *Self) void {
            clean(self);
        }
        ///완전히 정리
        pub inline fn deinit_for_alloc(self: *Self) void {
            self.allocator.free(self.array.?);
            clean(self);
        }
        ///다시 빌드할수 있게 버퍼 내용만 정리
        pub inline fn clean(self: *Self) void {
            self.*.interface.clean();
        }
        fn get_indices_len(_interface: *iindices) usize {
            const self = @as(*Self, @fieldParentPtr("interface", _interface));
            return self.*.array.?.len;
        }
        pub fn build(self: *Self, _flag: write_flag) void {
            clean(self);

            create_buffer(vk.VK_BUFFER_USAGE_INDEX_BUFFER_BIT, _flag, @sizeOf(idxT) * self.*.array.?.len, &self.*.interface.node, std.mem.sliceAsBytes(self.*.array.?));
        }
        ///write_flag가 readwrite_cpu만 호출
        pub fn map_update(self: *Self) void {
            var data: ?*idxT = undefined;
            self.*.interface.node.map(@ptrCast(&data));
            mem.memcpy_nonarray(data.?, self.*.array.ptr);
            self.*.interface.node.unmap();
        }
    };
}

pub const projection = struct {
    const Self = @This();
    pub const view_type = enum { orthographic, perspective };
    proj: matrix,
    __uniform: vulkan_res_node(.buffer) = .{},
    __check_alloc: if (dbg) []bool else void = if (dbg) undefined,

    ///_view_type이 orthographic경우 fov는 무시됨, 시스템 초기화 후 호출 perspective일 경우 near, far 기본값 각각 0.1, 100
    pub fn init(_view_type: view_type, fov: f32) matrix_error!Self {
        var res: Self = .{ .proj = undefined };
        try res.init_matrix(_view_type, fov);
        build(&res, .readwrite_cpu);

        if (dbg) res.__check_alloc = __system.allocator.alloc(bool, 1) catch |e| system.handle_error3("projection alloc __check_alloc", e);
        return res;
    }
    ///_view_type이 orthographic경우 fov는 무시됨, 시스템 초기화 후 호출
    pub fn init2(_view_type: view_type, fov: f32, near: f32, far: f32) matrix_error!Self {
        var res: Self = .{};
        try res.init_matrix2(_view_type, fov, near, far);
        build(&res, .readwrite_cpu);

        if (dbg) res.__check_alloc = __system.allocator.alloc(bool, 1) catch |e| system.handle_error3("projection alloc __check_alloc 2", e);
        return res;
    }
    pub fn init_matrix(self: *Self, _view_type: view_type, fov: f32) matrix_error!void {
        self.*.proj = switch (_view_type) {
            .orthographic => try matrix.orthographicLhVulkan(@floatFromInt(window.window_width()), @floatFromInt(window.window_height()), 0.1, 100),
            .perspective => try matrix.perspectiveFovLhVulkan(fov, @as(f32, @floatFromInt(window.window_width())) / @as(f32, @floatFromInt(window.window_height())), 0.1, 100),
        };
    }
    pub fn init_matrix2(self: *Self, _view_type: view_type, fov: f32, near: f32, far: f32) matrix_error!void {
        self.*.proj = switch (_view_type) {
            .orthographic => try matrix.orthographicLhVulkan(@floatFromInt(window.window_width()), @floatFromInt(window.window_height()), near, far),
            .perspective => try matrix.perspectiveFovLhVulkan(fov, @as(f32, @floatFromInt(window.window_width())) / @as(f32, @floatFromInt(window.window_height())), near, far),
        };
    }
    pub inline fn deinit(self: *Self) void {
        self.*.__uniform.clean();

        if (dbg) __system.allocator.free(self.*.__check_alloc);
    }
    fn build(self: *Self, _flag: write_flag) void {
        create_buffer(vk.VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, _flag, @sizeOf(matrix), &self.*.__uniform, std.mem.sliceAsBytes(@as([*]matrix, @ptrCast(&self.*.proj))[0..1]));
    }
    pub fn map_update(self: *Self) void {
        var data: ?*matrix = undefined;
        self.*.__uniform.map(@ptrCast(&data));
        mem.memcpy_nonarray(data.?, &self.*.proj);
        self.*.__uniform.unmap();
    }
};
pub const camera = struct {
    const Self = @This();
    view: matrix,
    __uniform: vulkan_res_node(.buffer) = .{},
    __check_alloc: if (dbg) []bool else void = if (dbg) undefined,

    /// w좌표는 신경 x, 시스템 초기화 후 호출
    pub fn init(eyepos: vector, focuspos: vector, updir: vector) Self {
        var res = Self{ .view = matrix.lookAtLh(eyepos, focuspos, updir) };
        build(&res, .readwrite_cpu);

        if (dbg) res.__check_alloc = __system.allocator.alloc(bool, 1) catch |e| system.handle_error3("camera alloc __check_alloc", e);
        return res;
    }
    pub inline fn deinit(self: *Self) void {
        self.*.__uniform.clean();

        if (dbg) __system.allocator.free(self.*.__check_alloc);
    }
    fn build(self: *Self, _flag: write_flag) void {
        create_buffer(vk.VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, _flag, @sizeOf(matrix), &self.*.__uniform, std.mem.sliceAsBytes(@as([*]matrix, @ptrCast(&self.*.view))[0..1]));
    }
    pub fn map_update(self: *Self) void {
        var data: ?*matrix = undefined;
        self.*.__uniform.map(@ptrCast(&data));
        mem.memcpy_nonarray(data, &self.*.view);
        self.*.__uniform.unmap();
    }
};
pub const color_transform = struct {
    const Self = @This();
    color_mat: matrix,
    __uniform: vulkan_res_node(.buffer) = .{},
    __check_alloc: if (dbg) []bool else void = if (dbg) undefined,

    pub fn get_no_default() *Self {
        return &__vulkan.no_color_tran;
    }

    /// w좌표는 신경 x, 시스템 초기화 후 호출
    pub fn init() Self {
        var res = Self{ .color_mat = matrix.identity() };

        if (dbg) res.__check_alloc = __system.allocator.alloc(bool, 1) catch |e| system.handle_error3("camera alloc __check_alloc", e);
        return res;
    }
    pub inline fn deinit(self: *Self) void {
        self.*.__uniform.clean();

        if (dbg) __system.allocator.free(self.*.__check_alloc);
    }
    pub fn build(self: *Self, _flag: write_flag) void {
        if (dbg) self.*.__check_alloc[0] = false;
        create_buffer(vk.VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, _flag, @sizeOf(matrix), &self.*.__uniform, std.mem.sliceAsBytes(@as([*]matrix, @ptrCast(&self.*.color_mat))[0..1]));
    }
    pub fn map_update(self: *Self) void {
        if (dbg) self.*.__check_alloc[0] = false;
        var data: ?*matrix = undefined;
        self.*.__uniform.map(@ptrCast(&data));
        mem.memcpy_nonarray(data, &self.*.color_mat);
        self.*.__uniform.unmap();
    }
};
//transform는 object와 한몸이라 따로 check_alloc 필요없음
pub const transform = struct {
    const Self = @This();

    model: matrix = matrix.identity(),
    ///이 값이 변경되면 update 필요 또는 build로 초기화하기
    camera: ?*camera = null,
    ///이 값이 변경되면 update 필요 또는 build로 초기화하기
    projection: ?*projection = null,
    __model_uniform: vulkan_res_node(.buffer) = .{},
    pub inline fn is_build(self: *Self) bool {
        return self.*.__model_uniform.is_build() and self.*.camera != null and self.*.projection != null and self.*.camera.?.*.__uniform.is_build() and self.*.projection.?.*.__uniform.is_build();
    }
    pub inline fn clean(self: *Self) void {
        self.*.__model_uniform.clean();
    }
    pub fn build(self: *Self) void {
        clean(self);
        create_buffer(vk.VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, .readwrite_cpu, @sizeOf(matrix), &self.*.__model_uniform, std.mem.sliceAsBytes(@as([*]matrix, @ptrCast(&self.*.model))[0..1]));
    }
    ///write_flag가 readwrite_cpu일때만 호출
    pub fn map_update(self: *Self) void {
        var data: ?*matrix = undefined;
        self.*.__model_uniform.map(@ptrCast(&data));
        mem.memcpy_nonarray(data.?, &self.*.model);
        self.*.__model_uniform.unmap();
    }
};

pub const texture = struct {
    const Self = @This();
    __image: vulkan_res_node(.image) = .{},
    width: u32 = undefined,
    height: u32 = undefined,
    pixels: ?[]u8 = null,

    ///완전히 정리
    pub inline fn deinit(self: *Self) void {
        clean(self);
    }
    ///write_flag가 readwrite_cpu만 호출
    pub fn map_update(self: *Self) void {
        var data: ?*u8 = undefined;
        self.*.__model_uniform.map(@ptrCast(&data));
        mem.memcpy_nonarray(data.?, self.*.pixels.ptr);
        self.*.__model_uniform.unmap();
    }
    ///다시 빌드할수 있게 버퍼 내용만 정리
    pub inline fn clean(self: *Self) void {
        self.*.__image.clean();
    }
    pub fn build(self: *Self) void {
        clean(self);
        const img_info: vk.VkImageCreateInfo = .{
            .arrayLayers = 1,
            .extent = .{ .width = self.*.width, .height = self.*.height, .depth = 1 },
            .flags = 0,
            .format = vk.VK_FORMAT_R8G8B8A8_UNORM,
            .imageType = vk.VK_IMAGE_TYPE_2D,
            .initialLayout = vk.VK_IMAGE_LAYOUT_UNDEFINED,
            .mipLevels = 1,
            .pQueueFamilyIndices = null,
            .queueFamilyIndexCount = 0,
            .samples = vk.VK_SAMPLE_COUNT_1_BIT,
            .sharingMode = vk.VK_SHARING_MODE_EXCLUSIVE,
            .tiling = vk.VK_IMAGE_TILING_OPTIMAL,
            .usage = vk.VK_IMAGE_USAGE_SAMPLED_BIT,
        };
        check_vk_allocator();
        __vulkan.vk_allocator.?.*.create_image(&img_info, &self.*.__image, std.mem.sliceAsBytes(self.*.pixels.?), 0);
    }
};

pub const iobject = struct {
    const Self = @This();

    get_descriptor_sets: *const fn (self: *iobject, idx: usize) vk.VkDescriptorSet = undefined,
    get_source: *const fn (self: *iobject) ?*anyopaque = undefined,
    get_extra_sources: *const fn (self: *iobject) ?[]*anyopaque = undefined,
    get_ivertices: *const fn (self: *iobject, idx: usize) ?*ivertices = undefined,
    get_iindices: *const fn (self: *iobject, idx: usize) ?*iindices = undefined,
    get_texture: *const fn (self: *iobject, idx: usize) ?*texture = undefined,
    build: *const fn (self: *iobject) void = undefined,
    clean: *const fn (self: *iobject) void = undefined,
    ///transform에 포함된 버퍼 값이 변경될때마다 호출한다. 리소스만 변경시에는 대신 map_update 호출
    update: *const fn (self: *iobject) void = undefined,
    transform: transform = .{},
    __descriptor_pool: vk.VkDescriptorPool = null,
    __check_alloc: if (dbg) []bool else void = if (dbg) undefined,

    pub inline fn is_build(self: *Self) bool {
        return self.*.__descriptor_pool != null and self.*.transform.is_build();
    }

    pub fn init() Self {
        var res: Self = .{};
        if (dbg) res.__check_alloc = __system.allocator.alloc(bool, 1) catch |e| system.handle_error3("iobject alloc __check_alloc", e);
        return res;
    }
    pub fn deinit(self: *Self) void {
        self.*.clean(self);

        if (dbg) __system.allocator.free(self.*.__check_alloc);
    }
};

pub const shape = struct {
    const Self = @This();

    pub const source = struct {
        vertices: vertices(shape_color_vertex_2d),
        indices: indices32,
        color: vector = .{ 1, 1, 1, 1 },
        __uniform: vulkan_res_node(.buffer) = .{},
        __descriptor_set: vk.VkDescriptorSet = undefined,
        __descriptor_pool: vk.VkDescriptorPool = undefined,

        pub fn init() source {
            return .{
                .vertices = vertices(shape_color_vertex_2d).init(),
                .indices = indices32.init(),
            };
        }
        pub fn init_for_alloc(__allocator: std.mem.Allocator) source {
            return .{
                .vertices = vertices(shape_color_vertex_2d).init_for_alloc(__allocator),
                .indices = indices32.init_for_alloc(__allocator),
            };
        }
        pub fn build(self: *source, _flag: write_flag) void {
            self.*.vertices.build(_flag);
            self.*.indices.build(_flag);

            create_buffer(vk.VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, .readwrite_cpu, @sizeOf(vector), &self.*.__uniform, std.mem.sliceAsBytes(@as([*]vector, @ptrCast(&self.*.color))[0..1]));

            const pool_size: [1]vk.VkDescriptorPoolSize = .{.{
                .descriptorCount = 1,
                .type = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
            }};
            const pool_info: vk.VkDescriptorPoolCreateInfo = .{
                .sType = vk.VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO,
                .poolSizeCount = pool_size.len,
                .pPoolSizes = &pool_size,
                .maxSets = 1,
            };
            var result = vk.vkCreateDescriptorPool(__vulkan.vkDevice, &pool_info, null, &self.*.__descriptor_pool);
            system.handle_error(result == vk.VK_SUCCESS, "shape.source.build.vkCreateDescriptorPool : {d}", .{result});

            const alloc_info: vk.VkDescriptorSetAllocateInfo = .{
                .sType = vk.VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO,
                .descriptorPool = self.*.__descriptor_pool,
                .descriptorSetCount = 1,
                .pSetLayouts = &[_]vk.VkDescriptorSetLayout{
                    __vulkan.quad_shape_2d_pipeline_set.descriptorSetLayout,
                },
            };
            result = vk.vkAllocateDescriptorSets(__vulkan.vkDevice, &alloc_info, &self.*.__descriptor_set);
            system.handle_error(result == vk.VK_SUCCESS, "shape.source.build.vkAllocateDescriptorSets : {d}", .{result});

            const buffer_info = [1]vk.VkDescriptorBufferInfo{vk.VkDescriptorBufferInfo{
                .buffer = self.*.__uniform.res,
                .offset = 0,
                .range = @sizeOf(vector),
            }};
            const descriptorWrite = [_]vk.VkWriteDescriptorSet{
                .{
                    .dstSet = self.*.__descriptor_set,
                    .dstBinding = 0,
                    .dstArrayElement = 0,
                    .descriptorCount = buffer_info.len,
                    .descriptorType = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
                    .pBufferInfo = &buffer_info,
                    .pImageInfo = null,
                    .pTexelBufferView = null,
                },
            };
            vk.vkUpdateDescriptorSets(__vulkan.vkDevice, descriptorWrite.len, &descriptorWrite, 0, null);
        }
        pub fn deinit(self: *source) void {
            self.*.vertices.deinit();
            self.*.indices.deinit();
            vk.vkDestroyDescriptorPool(__vulkan.vkDevice, self.*.__descriptor_pool, null);
            self.*.__uniform.clean();
        }
        pub fn deinit_for_alloc(self: *source) void {
            self.*.vertices.deinit_for_alloc();
            self.*.indices.deinit_for_alloc();
            vk.vkDestroyDescriptorPool(__vulkan.vkDevice, self.*.__descriptor_pool, null);
            self.*.__uniform.clean();
        }
        pub fn map_color_update(self: *source) void {
            var data: ?*vector = undefined;
            self.*.__uniform.map(@ptrCast(&data));
            mem.memcpy_nonarray(data.?, &self.*.color);
            self.*.__uniform.unmap();
        }
    };

    src: *source = undefined,
    extra_src: ?[]*source = null,
    interface: iobject,
    __descriptor_set: vk.VkDescriptorSet = undefined,

    fn get_descriptor_sets(_interface: *iobject, idx: usize) vk.VkDescriptorSet {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        if (idx > 0) return null;
        return self.*.__descriptor_set;
    }
    fn get_ivertices(_interface: *iobject, idx: usize) ?*ivertices {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        if (idx == 0) {
            return &self.*.src.vertices.interface;
        } else {
            return null;
        }
    }
    fn get_source(_interface: *iobject) *anyopaque {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        return @ptrCast(self.*.src);
    }
    fn get_extra_sources(_interface: *iobject) ?[]*anyopaque {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        return if (self.*.extra_src != null) @as([*]*anyopaque, @ptrCast(self.*.extra_src.?.ptr))[0..self.*.extra_src.?.len] else null;
    }
    fn get_iindices(_interface: *iobject, idx: usize) ?*iindices {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        if (idx == 0) {
            return &self.*.src.*.indices.interface;
        } else {
            return null;
        }
    }
    pub fn get_texture(_interface: *iobject, idx: usize) ?*texture {
        _ = _interface;
        _ = idx;
        return null;
    }

    fn clean(self: *iobject) void {
        //const self2 = @as(*Self, @fieldParentPtr("interface", self));
        if (self.*.__descriptor_pool != null) {
            vk.vkDestroyDescriptorPool(__vulkan.vkDevice, self.*.__descriptor_pool, null);
            self.*.__descriptor_pool = null;
        }
        self.*.transform.clean();
    }
    fn update(self: *iobject) void {
        if (!self.*.is_build()) {
            system.handle_error_msg2("iobject update need transform build and need transform.camera, projection build(invaild)");
        }

        const buffer_info = [3]vk.VkDescriptorBufferInfo{ vk.VkDescriptorBufferInfo{
            .buffer = self.*.transform.__model_uniform.res,
            .offset = 0,
            .range = @sizeOf(matrix),
        }, vk.VkDescriptorBufferInfo{
            .buffer = self.*.transform.camera.?.*.__uniform.res,
            .offset = 0,
            .range = @sizeOf(matrix),
        }, vk.VkDescriptorBufferInfo{
            .buffer = self.*.transform.projection.?.*.__uniform.res,
            .offset = 0,
            .range = @sizeOf(matrix),
        } };
        const descriptorWrite = [_]vk.VkWriteDescriptorSet{
            .{
                .dstSet = self.*.get_descriptor_sets(self, 0),
                .dstBinding = 0,
                .dstArrayElement = 0,
                .descriptorCount = buffer_info.len,
                .descriptorType = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
                .pBufferInfo = &buffer_info,
                .pImageInfo = null,
                .pTexelBufferView = null,
            },
        };
        vk.vkUpdateDescriptorSets(__vulkan.vkDevice, descriptorWrite.len, &descriptorWrite, 0, null);
    }

    fn build(self: *iobject) void {
        if (self.*.transform.camera == null or self.*.transform.projection == null or !self.*.transform.camera.?.*.__uniform.is_build() or !self.*.transform.projection.?.*.__uniform.is_build()) {
            system.handle_error_msg2("iobject build need transform.camera, projection build(invaild)");
        }
        if (self.*.get_ivertices(self, 0) == null) {
            system.handle_error_msg2("iobject build need vertices");
        }

        var result: vk.VkResult = undefined;
        self.*.clean(self);

        const pool_size: [1]vk.VkDescriptorPoolSize = .{.{
            .descriptorCount = 3,
            .type = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
        }};
        const pool_info: vk.VkDescriptorPoolCreateInfo = .{
            .sType = vk.VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO,
            .poolSizeCount = pool_size.len,
            .pPoolSizes = &pool_size,
            .maxSets = 1,
        };
        result = vk.vkCreateDescriptorPool(__vulkan.vkDevice, &pool_info, null, &self.*.__descriptor_pool);
        system.handle_error(result == vk.VK_SUCCESS, "iobject.build.vkCreateDescriptorPool(shape_color_2d_pipeline_set) : {d}", .{result});
        const alloc_info: vk.VkDescriptorSetAllocateInfo = .{
            .sType = vk.VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO,
            .descriptorPool = self.*.__descriptor_pool,
            .descriptorSetCount = 1,
            .pSetLayouts = &[_]vk.VkDescriptorSetLayout{
                self.*.get_ivertices(self, 0).?.*.pipeline.*.descriptorSetLayout,
            },
        };
        const parent = @as(*Self, @fieldParentPtr("interface", self));
        result = vk.vkAllocateDescriptorSets(__vulkan.vkDevice, &alloc_info, &parent.*.__descriptor_set);
        system.handle_error(result == vk.VK_SUCCESS, "iobject.build.vkAllocateDescriptorSets : {d}", .{result});

        self.*.transform.build();

        self.*.update(self);
    }

    pub fn init() Self {
        var self = Self{
            .interface = .{},
        };
        self.interface = iobject.init();
        self.interface.get_ivertices = get_ivertices;
        self.interface.get_iindices = get_iindices;
        self.interface.get_texture = get_texture;
        self.interface.get_source = get_source;
        self.interface.get_extra_sources = get_extra_sources;
        self.interface.get_descriptor_sets = get_descriptor_sets;
        self.interface.build = build;
        self.interface.update = update;
        self.interface.clean = clean;

        return self;
    }
};

pub const image = struct {
    const Self = @This();

    pub const source = struct {
        vertices: *vertices(tex_vertex_2d),
        indices: ?*indices32,
        texture: texture,
        sampler: vk.VkSampler,

        pub fn init() source {
            return .{
                .vertices = get_default_quad_image_vertices(),
                .indices = null,
                .texture = .{},
                .sampler = get_default_linear_sampler(),
            };
        }
        pub fn get_default_quad_image_vertices() *vertices(tex_vertex_2d) {
            return &__vulkan.quad_image_vertices;
        }
        pub fn get_default_linear_sampler() vk.VkSampler {
            return __vulkan.linear_sampler;
        }
        pub fn get_default_nearest_sampler() vk.VkSampler {
            return __vulkan.nearest_sampler;
        }
    };

    src: *source = undefined,
    interface: iobject,
    color_tran: *color_transform,
    __descriptor_set: vk.VkDescriptorSet = undefined,

    fn get_ivertices(_interface: *iobject, idx: usize) ?*ivertices {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        if (idx == 0) {
            return &self.*.src.*.vertices.*.interface;
        } else {
            return null;
        }
    }
    fn get_descriptor_sets(_interface: *iobject, idx: usize) vk.VkDescriptorSet {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        if (idx > 0) return null;
        return self.*.__descriptor_set;
    }
    fn get_iindices(_interface: *iobject, idx: usize) ?*iindices {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        if (idx == 0) {
            return if (self.*.src.*.indices != null) &self.*.src.*.indices.?.*.interface else null;
        } else {
            return null;
        }
    }
    pub fn get_texture(_interface: *iobject, idx: usize) ?*texture {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        if (idx == 0) {
            return &self.*.src.texture;
        } else {
            return null;
        }
    }
    fn get_source(_interface: *iobject) ?*anyopaque {
        const self = @as(*Self, @fieldParentPtr("interface", _interface));
        return @ptrCast(self.*.src);
    }
    fn get_extra_sources(_interface: *iobject) ?[]*anyopaque {
        _ = _interface;
        return null;
    }
    fn clean(self: *iobject) void {
        // const self2 = @as(*Self, @fieldParentPtr("interface", self));
        if (self.*.__descriptor_pool != null) {
            vk.vkDestroyDescriptorPool(__vulkan.vkDevice, self.*.__descriptor_pool, null);
            self.*.__descriptor_pool = null;
            //  self2.*.__descriptor_set = null;
        }
        self.*.transform.clean();
    }
    fn update(self: *iobject) void {
        if (!self.*.is_build()) {
            system.handle_error_msg2("iobject update need transform build and need transform.camera, projection build(invaild)");
        }
        const parent = @as(*Self, @fieldParentPtr("interface", self));
        const buffer_info = [4]vk.VkDescriptorBufferInfo{
            vk.VkDescriptorBufferInfo{
                .buffer = self.*.transform.__model_uniform.res,
                .offset = 0,
                .range = @sizeOf(matrix),
            },
            vk.VkDescriptorBufferInfo{
                .buffer = self.*.transform.camera.?.*.__uniform.res,
                .offset = 0,
                .range = @sizeOf(matrix),
            },
            vk.VkDescriptorBufferInfo{
                .buffer = self.*.transform.projection.?.*.__uniform.res,
                .offset = 0,
                .range = @sizeOf(matrix),
            },
            vk.VkDescriptorBufferInfo{
                .buffer = parent.*.color_tran.*.__uniform.res,
                .offset = 0,
                .range = @sizeOf(matrix),
            },
        };
        const imageInfo: vk.VkDescriptorImageInfo = .{
            .imageLayout = vk.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
            .imageView = self.*.get_texture(self, 0).?.__image.__image_view,
            .sampler = parent.*.src.sampler,
        };
        const descriptorWrite2 = [3]vk.VkWriteDescriptorSet{
            .{
                .sType = vk.VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET,
                .dstSet = self.*.get_descriptor_sets(self, 0),
                .dstBinding = 0,
                .dstArrayElement = 0,
                .descriptorCount = 3,
                .descriptorType = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
                .pBufferInfo = &buffer_info,
                .pImageInfo = null,
                .pTexelBufferView = null,
            },
            .{
                .sType = vk.VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET,
                .dstSet = self.*.get_descriptor_sets(self, 0),
                .dstBinding = 3,
                .dstArrayElement = 0,
                .descriptorCount = 1,
                .descriptorType = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
                .pBufferInfo = &buffer_info[3],
                .pImageInfo = null,
                .pTexelBufferView = null,
            },
            .{
                .sType = vk.VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET,
                .dstSet = self.*.get_descriptor_sets(self, 0),
                .dstBinding = 4,
                .dstArrayElement = 0,
                .descriptorCount = 1,
                .descriptorType = vk.VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER,
                .pBufferInfo = null,
                .pImageInfo = &imageInfo,
                .pTexelBufferView = null,
            },
        };
        vk.vkUpdateDescriptorSets(__vulkan.vkDevice, descriptorWrite2.len, &descriptorWrite2, 0, null);
    }
    fn build(self: *iobject) void {
        if (self.*.transform.camera == null or self.*.transform.projection == null or !self.*.transform.camera.?.*.__uniform.is_build() or !self.*.transform.projection.?.*.__uniform.is_build()) {
            system.handle_error_msg2("iobject build need transform.camera, projection build(invaild)");
        }
        if (self.*.get_ivertices(self, 0) == null) {
            system.handle_error_msg2("iobject build need vertices");
        }

        var result: vk.VkResult = undefined;
        if (self.*.get_texture(self, 0) == null) {
            system.handle_error_msg2("iobject build need texture");
        }
        clean(self);

        const pool_size = [3]vk.VkDescriptorPoolSize{ .{
            .descriptorCount = 3,
            .type = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
        }, .{
            .descriptorCount = 1,
            .type = vk.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
        }, .{
            .descriptorCount = 1,
            .type = vk.VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER,
        } };
        const pool_info: vk.VkDescriptorPoolCreateInfo = .{
            .sType = vk.VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO,
            .poolSizeCount = pool_size.len,
            .pPoolSizes = &pool_size,
            .maxSets = 1,
        };
        result = vk.vkCreateDescriptorPool(__vulkan.vkDevice, &pool_info, null, &self.*.__descriptor_pool);
        system.handle_error(result == vk.VK_SUCCESS, "iobject.build.vkCreateDescriptorPool(tex_2d_pipeline_set) : {d}", .{result});

        const alloc_info: vk.VkDescriptorSetAllocateInfo = .{
            .sType = vk.VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO,
            .descriptorPool = self.*.__descriptor_pool,
            .descriptorSetCount = 1,
            .pSetLayouts = &self.*.get_ivertices(self, 0).?.*.pipeline.*.descriptorSetLayout,
        };
        const parent = @as(*Self, @fieldParentPtr("interface", self));
        result = vk.vkAllocateDescriptorSets(__vulkan.vkDevice, &alloc_info, &parent.*.__descriptor_set);
        system.handle_error(result == vk.VK_SUCCESS, "iobject.build.vkAllocateDescriptorSets : {d}", .{result});

        self.*.transform.build();

        self.*.update(self);
    }

    pub fn init() Self {
        var self = Self{
            .interface = .{},
            .color_tran = color_transform.get_no_default(),
        };
        self.interface = iobject.init();
        self.interface.get_ivertices = get_ivertices;
        self.interface.get_iindices = get_iindices;
        self.interface.get_texture = get_texture;
        self.interface.get_source = get_source;
        self.interface.get_extra_sources = get_extra_sources;
        self.interface.get_descriptor_sets = get_descriptor_sets;
        self.interface.build = build;
        self.interface.update = update;
        self.interface.clean = clean;

        return self;
    }
};
