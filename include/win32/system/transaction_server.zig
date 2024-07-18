//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (15)
//--------------------------------------------------------------------------------
const CLSID_Catalog_Value = Guid.initString("6eb22881-8a19-11d0-81b6-00a0c9231c29");
pub const CLSID_Catalog = &CLSID_Catalog_Value;

const CLSID_CatalogObject_Value = Guid.initString("6eb22882-8a19-11d0-81b6-00a0c9231c29");
pub const CLSID_CatalogObject = &CLSID_CatalogObject_Value;

const CLSID_CatalogCollection_Value = Guid.initString("6eb22883-8a19-11d0-81b6-00a0c9231c29");
pub const CLSID_CatalogCollection = &CLSID_CatalogCollection_Value;

const CLSID_ComponentUtil_Value = Guid.initString("6eb22884-8a19-11d0-81b6-00a0c9231c29");
pub const CLSID_ComponentUtil = &CLSID_ComponentUtil_Value;

const CLSID_PackageUtil_Value = Guid.initString("6eb22885-8a19-11d0-81b6-00a0c9231c29");
pub const CLSID_PackageUtil = &CLSID_PackageUtil_Value;

const CLSID_RemoteComponentUtil_Value = Guid.initString("6eb22886-8a19-11d0-81b6-00a0c9231c29");
pub const CLSID_RemoteComponentUtil = &CLSID_RemoteComponentUtil_Value;

const CLSID_RoleAssociationUtil_Value = Guid.initString("6eb22887-8a19-11d0-81b6-00a0c9231c29");
pub const CLSID_RoleAssociationUtil = &CLSID_RoleAssociationUtil_Value;

const IID_ICatalog_Value = Guid.initString("6eb22870-8a19-11d0-81b6-00a0c9231c29");
pub const IID_ICatalog = &IID_ICatalog_Value;
pub const ICatalog = extern struct {
    pub const VTable = extern struct {
        base: IDispatch.VTable,
        GetCollection: *const fn(
            self: *const ICatalog,
            bstrCollName: ?BSTR,
            ppCatalogCollection: ?*?*IDispatch,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        Connect: *const fn(
            self: *const ICatalog,
            bstrConnectString: ?BSTR,
            ppCatalogCollection: ?*?*IDispatch,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        // TODO: this function has a "SpecialName", should Zig do anything with this?
        get_MajorVersion: *const fn(
            self: *const ICatalog,
            retval: ?*i32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        // TODO: this function has a "SpecialName", should Zig do anything with this?
        get_MinorVersion: *const fn(
            self: *const ICatalog,
            retval: ?*i32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IDispatch.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICatalog_GetCollection(self: *const T, bstrCollName: ?BSTR, ppCatalogCollection: ?*?*IDispatch) callconv(.Inline) HRESULT {
            return @as(*const ICatalog.VTable, @ptrCast(self.vtable)).GetCollection(@as(*const ICatalog, @ptrCast(self)), bstrCollName, ppCatalogCollection);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICatalog_Connect(self: *const T, bstrConnectString: ?BSTR, ppCatalogCollection: ?*?*IDispatch) callconv(.Inline) HRESULT {
            return @as(*const ICatalog.VTable, @ptrCast(self.vtable)).Connect(@as(*const ICatalog, @ptrCast(self)), bstrConnectString, ppCatalogCollection);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICatalog_get_MajorVersion(self: *const T, retval: ?*i32) callconv(.Inline) HRESULT {
            return @as(*const ICatalog.VTable, @ptrCast(self.vtable)).get_MajorVersion(@as(*const ICatalog, @ptrCast(self)), retval);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn ICatalog_get_MinorVersion(self: *const T, retval: ?*i32) callconv(.Inline) HRESULT {
            return @as(*const ICatalog.VTable, @ptrCast(self.vtable)).get_MinorVersion(@as(*const ICatalog, @ptrCast(self)), retval);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IComponentUtil_Value = Guid.initString("6eb22873-8a19-11d0-81b6-00a0c9231c29");
pub const IID_IComponentUtil = &IID_IComponentUtil_Value;
pub const IComponentUtil = extern struct {
    pub const VTable = extern struct {
        base: IDispatch.VTable,
        InstallComponent: *const fn(
            self: *const IComponentUtil,
            bstrDLLFile: ?BSTR,
            bstrTypelibFile: ?BSTR,
            bstrProxyStubDLLFile: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ImportComponent: *const fn(
            self: *const IComponentUtil,
            bstrCLSID: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ImportComponentByName: *const fn(
            self: *const IComponentUtil,
            bstrProgID: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        GetCLSIDs: *const fn(
            self: *const IComponentUtil,
            bstrDLLFile: ?BSTR,
            bstrTypelibFile: ?BSTR,
            aCLSIDs: ?*?*SAFEARRAY,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IDispatch.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IComponentUtil_InstallComponent(self: *const T, bstrDLLFile: ?BSTR, bstrTypelibFile: ?BSTR, bstrProxyStubDLLFile: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IComponentUtil.VTable, @ptrCast(self.vtable)).InstallComponent(@as(*const IComponentUtil, @ptrCast(self)), bstrDLLFile, bstrTypelibFile, bstrProxyStubDLLFile);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IComponentUtil_ImportComponent(self: *const T, bstrCLSID: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IComponentUtil.VTable, @ptrCast(self.vtable)).ImportComponent(@as(*const IComponentUtil, @ptrCast(self)), bstrCLSID);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IComponentUtil_ImportComponentByName(self: *const T, bstrProgID: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IComponentUtil.VTable, @ptrCast(self.vtable)).ImportComponentByName(@as(*const IComponentUtil, @ptrCast(self)), bstrProgID);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IComponentUtil_GetCLSIDs(self: *const T, bstrDLLFile: ?BSTR, bstrTypelibFile: ?BSTR, aCLSIDs: ?*?*SAFEARRAY) callconv(.Inline) HRESULT {
            return @as(*const IComponentUtil.VTable, @ptrCast(self.vtable)).GetCLSIDs(@as(*const IComponentUtil, @ptrCast(self)), bstrDLLFile, bstrTypelibFile, aCLSIDs);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IPackageUtil_Value = Guid.initString("6eb22874-8a19-11d0-81b6-00a0c9231c29");
pub const IID_IPackageUtil = &IID_IPackageUtil_Value;
pub const IPackageUtil = extern struct {
    pub const VTable = extern struct {
        base: IDispatch.VTable,
        InstallPackage: *const fn(
            self: *const IPackageUtil,
            bstrPackageFile: ?BSTR,
            bstrInstallPath: ?BSTR,
            lOptions: i32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ExportPackage: *const fn(
            self: *const IPackageUtil,
            bstrPackageID: ?BSTR,
            bstrPackageFile: ?BSTR,
            lOptions: i32,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        ShutdownPackage: *const fn(
            self: *const IPackageUtil,
            bstrPackageID: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IDispatch.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IPackageUtil_InstallPackage(self: *const T, bstrPackageFile: ?BSTR, bstrInstallPath: ?BSTR, lOptions: i32) callconv(.Inline) HRESULT {
            return @as(*const IPackageUtil.VTable, @ptrCast(self.vtable)).InstallPackage(@as(*const IPackageUtil, @ptrCast(self)), bstrPackageFile, bstrInstallPath, lOptions);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IPackageUtil_ExportPackage(self: *const T, bstrPackageID: ?BSTR, bstrPackageFile: ?BSTR, lOptions: i32) callconv(.Inline) HRESULT {
            return @as(*const IPackageUtil.VTable, @ptrCast(self.vtable)).ExportPackage(@as(*const IPackageUtil, @ptrCast(self)), bstrPackageID, bstrPackageFile, lOptions);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IPackageUtil_ShutdownPackage(self: *const T, bstrPackageID: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IPackageUtil.VTable, @ptrCast(self.vtable)).ShutdownPackage(@as(*const IPackageUtil, @ptrCast(self)), bstrPackageID);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IRemoteComponentUtil_Value = Guid.initString("6eb22875-8a19-11d0-81b6-00a0c9231c29");
pub const IID_IRemoteComponentUtil = &IID_IRemoteComponentUtil_Value;
pub const IRemoteComponentUtil = extern struct {
    pub const VTable = extern struct {
        base: IDispatch.VTable,
        InstallRemoteComponent: *const fn(
            self: *const IRemoteComponentUtil,
            bstrServer: ?BSTR,
            bstrPackageID: ?BSTR,
            bstrCLSID: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        InstallRemoteComponentByName: *const fn(
            self: *const IRemoteComponentUtil,
            bstrServer: ?BSTR,
            bstrPackageName: ?BSTR,
            bstrProgID: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IDispatch.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRemoteComponentUtil_InstallRemoteComponent(self: *const T, bstrServer: ?BSTR, bstrPackageID: ?BSTR, bstrCLSID: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IRemoteComponentUtil.VTable, @ptrCast(self.vtable)).InstallRemoteComponent(@as(*const IRemoteComponentUtil, @ptrCast(self)), bstrServer, bstrPackageID, bstrCLSID);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRemoteComponentUtil_InstallRemoteComponentByName(self: *const T, bstrServer: ?BSTR, bstrPackageName: ?BSTR, bstrProgID: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IRemoteComponentUtil.VTable, @ptrCast(self.vtable)).InstallRemoteComponentByName(@as(*const IRemoteComponentUtil, @ptrCast(self)), bstrServer, bstrPackageName, bstrProgID);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IRoleAssociationUtil_Value = Guid.initString("6eb22876-8a19-11d0-81b6-00a0c9231c29");
pub const IID_IRoleAssociationUtil = &IID_IRoleAssociationUtil_Value;
pub const IRoleAssociationUtil = extern struct {
    pub const VTable = extern struct {
        base: IDispatch.VTable,
        AssociateRole: *const fn(
            self: *const IRoleAssociationUtil,
            bstrRoleID: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        AssociateRoleByName: *const fn(
            self: *const IRoleAssociationUtil,
            bstrRoleName: ?BSTR,
        ) callconv(@import("std").os.windows.WINAPI) HRESULT,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IDispatch.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRoleAssociationUtil_AssociateRole(self: *const T, bstrRoleID: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IRoleAssociationUtil.VTable, @ptrCast(self.vtable)).AssociateRole(@as(*const IRoleAssociationUtil, @ptrCast(self)), bstrRoleID);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRoleAssociationUtil_AssociateRoleByName(self: *const T, bstrRoleName: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IRoleAssociationUtil.VTable, @ptrCast(self.vtable)).AssociateRoleByName(@as(*const IRoleAssociationUtil, @ptrCast(self)), bstrRoleName);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

pub const MTSPackageInstallOptions = enum(i32) {
    s = 1,
};
pub const mtsInstallUsers = MTSPackageInstallOptions.s;

pub const MTSPackageExportOptions = enum(i32) {
    s = 1,
};
pub const mtsExportUsers = MTSPackageExportOptions.s;

pub const MTSAdminErrorCodes = enum(i32) {
    ObjectErrors = -2146368511,
    ObjectInvalid = -2146368510,
    KeyMissing = -2146368509,
    AlreadyInstalled = -2146368508,
    DownloadFailed = -2146368507,
    PDFWriteFail = -2146368505,
    PDFReadFail = -2146368504,
    PDFVersion = -2146368503,
    CoReqCompInstalled = -2146368496,
    BadPath = -2146368502,
    PackageExists = -2146368501,
    RoleExists = -2146368500,
    CantCopyFile = -2146368499,
    NoTypeLib = -2146368498,
    NoUser = -2146368497,
    // InvalidUserids = -2146368496, this enum value conflicts with CoReqCompInstalled
    NoRegistryCLSID = -2146368495,
    BadRegistryProgID = -2146368494,
    AuthenticationLevel = -2146368493,
    UserPasswdNotValid = -2146368492,
    NoRegistryRead = -2146368491,
    NoRegistryWrite = -2146368490,
    NoRegistryRepair = -2146368489,
    CLSIDOrIIDMismatch = -2146368488,
    RemoteInterface = -2146368487,
    DllRegisterServer = -2146368486,
    NoServerShare = -2146368485,
    NoAccessToUNC = -2146368484,
    DllLoadFailed = -2146368483,
    BadRegistryLibID = -2146368482,
    PackDirNotFound = -2146368481,
    TreatAs = -2146368480,
    BadForward = -2146368479,
    BadIID = -2146368478,
    RegistrarFailed = -2146368477,
    CompFileDoesNotExist = -2146368476,
    CompFileLoadDLLFail = -2146368475,
    CompFileGetClassObj = -2146368474,
    CompFileClassNotAvail = -2146368473,
    CompFileBadTLB = -2146368472,
    CompFileNotInstallable = -2146368471,
    NotChangeable = -2146368470,
    NotDeletable = -2146368469,
    Session = -2146368468,
    CompFileNoRegistrar = -2146368460,
};
pub const mtsErrObjectErrors = MTSAdminErrorCodes.ObjectErrors;
pub const mtsErrObjectInvalid = MTSAdminErrorCodes.ObjectInvalid;
pub const mtsErrKeyMissing = MTSAdminErrorCodes.KeyMissing;
pub const mtsErrAlreadyInstalled = MTSAdminErrorCodes.AlreadyInstalled;
pub const mtsErrDownloadFailed = MTSAdminErrorCodes.DownloadFailed;
pub const mtsErrPDFWriteFail = MTSAdminErrorCodes.PDFWriteFail;
pub const mtsErrPDFReadFail = MTSAdminErrorCodes.PDFReadFail;
pub const mtsErrPDFVersion = MTSAdminErrorCodes.PDFVersion;
pub const mtsErrCoReqCompInstalled = MTSAdminErrorCodes.CoReqCompInstalled;
pub const mtsErrBadPath = MTSAdminErrorCodes.BadPath;
pub const mtsErrPackageExists = MTSAdminErrorCodes.PackageExists;
pub const mtsErrRoleExists = MTSAdminErrorCodes.RoleExists;
pub const mtsErrCantCopyFile = MTSAdminErrorCodes.CantCopyFile;
pub const mtsErrNoTypeLib = MTSAdminErrorCodes.NoTypeLib;
pub const mtsErrNoUser = MTSAdminErrorCodes.NoUser;
pub const mtsErrInvalidUserids = MTSAdminErrorCodes.CoReqCompInstalled;
pub const mtsErrNoRegistryCLSID = MTSAdminErrorCodes.NoRegistryCLSID;
pub const mtsErrBadRegistryProgID = MTSAdminErrorCodes.BadRegistryProgID;
pub const mtsErrAuthenticationLevel = MTSAdminErrorCodes.AuthenticationLevel;
pub const mtsErrUserPasswdNotValid = MTSAdminErrorCodes.UserPasswdNotValid;
pub const mtsErrNoRegistryRead = MTSAdminErrorCodes.NoRegistryRead;
pub const mtsErrNoRegistryWrite = MTSAdminErrorCodes.NoRegistryWrite;
pub const mtsErrNoRegistryRepair = MTSAdminErrorCodes.NoRegistryRepair;
pub const mtsErrCLSIDOrIIDMismatch = MTSAdminErrorCodes.CLSIDOrIIDMismatch;
pub const mtsErrRemoteInterface = MTSAdminErrorCodes.RemoteInterface;
pub const mtsErrDllRegisterServer = MTSAdminErrorCodes.DllRegisterServer;
pub const mtsErrNoServerShare = MTSAdminErrorCodes.NoServerShare;
pub const mtsErrNoAccessToUNC = MTSAdminErrorCodes.NoAccessToUNC;
pub const mtsErrDllLoadFailed = MTSAdminErrorCodes.DllLoadFailed;
pub const mtsErrBadRegistryLibID = MTSAdminErrorCodes.BadRegistryLibID;
pub const mtsErrPackDirNotFound = MTSAdminErrorCodes.PackDirNotFound;
pub const mtsErrTreatAs = MTSAdminErrorCodes.TreatAs;
pub const mtsErrBadForward = MTSAdminErrorCodes.BadForward;
pub const mtsErrBadIID = MTSAdminErrorCodes.BadIID;
pub const mtsErrRegistrarFailed = MTSAdminErrorCodes.RegistrarFailed;
pub const mtsErrCompFileDoesNotExist = MTSAdminErrorCodes.CompFileDoesNotExist;
pub const mtsErrCompFileLoadDLLFail = MTSAdminErrorCodes.CompFileLoadDLLFail;
pub const mtsErrCompFileGetClassObj = MTSAdminErrorCodes.CompFileGetClassObj;
pub const mtsErrCompFileClassNotAvail = MTSAdminErrorCodes.CompFileClassNotAvail;
pub const mtsErrCompFileBadTLB = MTSAdminErrorCodes.CompFileBadTLB;
pub const mtsErrCompFileNotInstallable = MTSAdminErrorCodes.CompFileNotInstallable;
pub const mtsErrNotChangeable = MTSAdminErrorCodes.NotChangeable;
pub const mtsErrNotDeletable = MTSAdminErrorCodes.NotDeletable;
pub const mtsErrSession = MTSAdminErrorCodes.Session;
pub const mtsErrCompFileNoRegistrar = MTSAdminErrorCodes.CompFileNoRegistrar;


//--------------------------------------------------------------------------------
// Section: Functions (0)
//--------------------------------------------------------------------------------

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
// Section: Imports (5)
//--------------------------------------------------------------------------------
const Guid = @import("../zig.zig").Guid;
const BSTR = @import("../foundation.zig").BSTR;
const HRESULT = @import("../foundation.zig").HRESULT;
const IDispatch = @import("../system/com.zig").IDispatch;
const SAFEARRAY = @import("../system/com.zig").SAFEARRAY;

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
