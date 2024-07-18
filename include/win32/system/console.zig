//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (49)
//--------------------------------------------------------------------------------
pub const CONSOLE_TEXTMODE_BUFFER = @as(u32, 1);
pub const ATTACH_PARENT_PROCESS = @as(u32, 4294967295);
pub const CTRL_C_EVENT = @as(u32, 0);
pub const CTRL_BREAK_EVENT = @as(u32, 1);
pub const CTRL_CLOSE_EVENT = @as(u32, 2);
pub const CTRL_LOGOFF_EVENT = @as(u32, 5);
pub const CTRL_SHUTDOWN_EVENT = @as(u32, 6);
pub const PSEUDOCONSOLE_INHERIT_CURSOR = @as(u32, 1);
pub const CONSOLE_NO_SELECTION = @as(u32, 0);
pub const CONSOLE_SELECTION_IN_PROGRESS = @as(u32, 1);
pub const CONSOLE_SELECTION_NOT_EMPTY = @as(u32, 2);
pub const CONSOLE_MOUSE_SELECTION = @as(u32, 4);
pub const CONSOLE_MOUSE_DOWN = @as(u32, 8);
pub const HISTORY_NO_DUP_FLAG = @as(u32, 1);
pub const CONSOLE_FULLSCREEN = @as(u32, 1);
pub const CONSOLE_FULLSCREEN_HARDWARE = @as(u32, 2);
pub const CONSOLE_FULLSCREEN_MODE = @as(u32, 1);
pub const CONSOLE_WINDOWED_MODE = @as(u32, 2);
pub const RIGHT_ALT_PRESSED = @as(u32, 1);
pub const LEFT_ALT_PRESSED = @as(u32, 2);
pub const RIGHT_CTRL_PRESSED = @as(u32, 4);
pub const LEFT_CTRL_PRESSED = @as(u32, 8);
pub const SHIFT_PRESSED = @as(u32, 16);
pub const NUMLOCK_ON = @as(u32, 32);
pub const SCROLLLOCK_ON = @as(u32, 64);
pub const CAPSLOCK_ON = @as(u32, 128);
pub const ENHANCED_KEY = @as(u32, 256);
pub const NLS_DBCSCHAR = @as(u32, 65536);
pub const NLS_ALPHANUMERIC = @as(u32, 0);
pub const NLS_KATAKANA = @as(u32, 131072);
pub const NLS_HIRAGANA = @as(u32, 262144);
pub const NLS_ROMAN = @as(u32, 4194304);
pub const NLS_IME_CONVERSION = @as(u32, 8388608);
pub const ALTNUMPAD_BIT = @as(u32, 67108864);
pub const NLS_IME_DISABLE = @as(u32, 536870912);
pub const FROM_LEFT_1ST_BUTTON_PRESSED = @as(u32, 1);
pub const RIGHTMOST_BUTTON_PRESSED = @as(u32, 2);
pub const FROM_LEFT_2ND_BUTTON_PRESSED = @as(u32, 4);
pub const FROM_LEFT_3RD_BUTTON_PRESSED = @as(u32, 8);
pub const FROM_LEFT_4TH_BUTTON_PRESSED = @as(u32, 16);
pub const MOUSE_MOVED = @as(u32, 1);
pub const DOUBLE_CLICK = @as(u32, 2);
pub const MOUSE_WHEELED = @as(u32, 4);
pub const MOUSE_HWHEELED = @as(u32, 8);
pub const KEY_EVENT = @as(u32, 1);
pub const MOUSE_EVENT = @as(u32, 2);
pub const WINDOW_BUFFER_SIZE_EVENT = @as(u32, 4);
pub const MENU_EVENT = @as(u32, 8);
pub const FOCUS_EVENT = @as(u32, 16);

//--------------------------------------------------------------------------------
// Section: Types (22)
//--------------------------------------------------------------------------------
pub const CONSOLE_MODE = packed struct(u32) {
    ENABLE_PROCESSED_INPUT: u1 = 0,
    ENABLE_LINE_INPUT: u1 = 0,
    ENABLE_ECHO_INPUT: u1 = 0,
    ENABLE_WINDOW_INPUT: u1 = 0,
    ENABLE_MOUSE_INPUT: u1 = 0,
    ENABLE_INSERT_MODE: u1 = 0,
    ENABLE_QUICK_EDIT_MODE: u1 = 0,
    ENABLE_EXTENDED_FLAGS: u1 = 0,
    ENABLE_AUTO_POSITION: u1 = 0,
    ENABLE_VIRTUAL_TERMINAL_INPUT: u1 = 0,
    _10: u1 = 0,
    _11: u1 = 0,
    _12: u1 = 0,
    _13: u1 = 0,
    _14: u1 = 0,
    _15: u1 = 0,
    _16: u1 = 0,
    _17: u1 = 0,
    _18: u1 = 0,
    _19: u1 = 0,
    _20: u1 = 0,
    _21: u1 = 0,
    _22: u1 = 0,
    _23: u1 = 0,
    _24: u1 = 0,
    _25: u1 = 0,
    _26: u1 = 0,
    _27: u1 = 0,
    _28: u1 = 0,
    _29: u1 = 0,
    _30: u1 = 0,
    _31: u1 = 0,
    // ENABLE_PROCESSED_OUTPUT (bit index 0) conflicts with ENABLE_PROCESSED_INPUT
    // ENABLE_WRAP_AT_EOL_OUTPUT (bit index 1) conflicts with ENABLE_LINE_INPUT
    // ENABLE_VIRTUAL_TERMINAL_PROCESSING (bit index 2) conflicts with ENABLE_ECHO_INPUT
    // DISABLE_NEWLINE_AUTO_RETURN (bit index 3) conflicts with ENABLE_WINDOW_INPUT
    // ENABLE_LVB_GRID_WORLDWIDE (bit index 4) conflicts with ENABLE_MOUSE_INPUT
};
pub const ENABLE_PROCESSED_INPUT = CONSOLE_MODE{ .ENABLE_PROCESSED_INPUT = 1 };
pub const ENABLE_LINE_INPUT = CONSOLE_MODE{ .ENABLE_LINE_INPUT = 1 };
pub const ENABLE_ECHO_INPUT = CONSOLE_MODE{ .ENABLE_ECHO_INPUT = 1 };
pub const ENABLE_WINDOW_INPUT = CONSOLE_MODE{ .ENABLE_WINDOW_INPUT = 1 };
pub const ENABLE_MOUSE_INPUT = CONSOLE_MODE{ .ENABLE_MOUSE_INPUT = 1 };
pub const ENABLE_INSERT_MODE = CONSOLE_MODE{ .ENABLE_INSERT_MODE = 1 };
pub const ENABLE_QUICK_EDIT_MODE = CONSOLE_MODE{ .ENABLE_QUICK_EDIT_MODE = 1 };
pub const ENABLE_EXTENDED_FLAGS = CONSOLE_MODE{ .ENABLE_EXTENDED_FLAGS = 1 };
pub const ENABLE_AUTO_POSITION = CONSOLE_MODE{ .ENABLE_AUTO_POSITION = 1 };
pub const ENABLE_VIRTUAL_TERMINAL_INPUT = CONSOLE_MODE{ .ENABLE_VIRTUAL_TERMINAL_INPUT = 1 };
pub const ENABLE_PROCESSED_OUTPUT = CONSOLE_MODE{ .ENABLE_PROCESSED_INPUT = 1 };
pub const ENABLE_WRAP_AT_EOL_OUTPUT = CONSOLE_MODE{ .ENABLE_LINE_INPUT = 1 };
pub const ENABLE_VIRTUAL_TERMINAL_PROCESSING = CONSOLE_MODE{ .ENABLE_ECHO_INPUT = 1 };
pub const DISABLE_NEWLINE_AUTO_RETURN = CONSOLE_MODE{ .ENABLE_WINDOW_INPUT = 1 };
pub const ENABLE_LVB_GRID_WORLDWIDE = CONSOLE_MODE{ .ENABLE_MOUSE_INPUT = 1 };

pub const STD_HANDLE = enum(u32) {
    INPUT_HANDLE = 4294967286,
    OUTPUT_HANDLE = 4294967285,
    ERROR_HANDLE = 4294967284,
};
pub const STD_INPUT_HANDLE = STD_HANDLE.INPUT_HANDLE;
pub const STD_OUTPUT_HANDLE = STD_HANDLE.OUTPUT_HANDLE;
pub const STD_ERROR_HANDLE = STD_HANDLE.ERROR_HANDLE;

pub const CONSOLE_CHARACTER_ATTRIBUTES = packed struct(u16) {
    FOREGROUND_BLUE: u1 = 0,
    FOREGROUND_GREEN: u1 = 0,
    FOREGROUND_RED: u1 = 0,
    FOREGROUND_INTENSITY: u1 = 0,
    BACKGROUND_BLUE: u1 = 0,
    BACKGROUND_GREEN: u1 = 0,
    BACKGROUND_RED: u1 = 0,
    BACKGROUND_INTENSITY: u1 = 0,
    COMMON_LVB_LEADING_BYTE: u1 = 0,
    COMMON_LVB_TRAILING_BYTE: u1 = 0,
    COMMON_LVB_GRID_HORIZONTAL: u1 = 0,
    COMMON_LVB_GRID_LVERTICAL: u1 = 0,
    COMMON_LVB_GRID_RVERTICAL: u1 = 0,
    _13: u1 = 0,
    COMMON_LVB_REVERSE_VIDEO: u1 = 0,
    COMMON_LVB_UNDERSCORE: u1 = 0,
};
pub const FOREGROUND_BLUE = CONSOLE_CHARACTER_ATTRIBUTES{ .FOREGROUND_BLUE = 1 };
pub const FOREGROUND_GREEN = CONSOLE_CHARACTER_ATTRIBUTES{ .FOREGROUND_GREEN = 1 };
pub const FOREGROUND_RED = CONSOLE_CHARACTER_ATTRIBUTES{ .FOREGROUND_RED = 1 };
pub const FOREGROUND_INTENSITY = CONSOLE_CHARACTER_ATTRIBUTES{ .FOREGROUND_INTENSITY = 1 };
pub const BACKGROUND_BLUE = CONSOLE_CHARACTER_ATTRIBUTES{ .BACKGROUND_BLUE = 1 };
pub const BACKGROUND_GREEN = CONSOLE_CHARACTER_ATTRIBUTES{ .BACKGROUND_GREEN = 1 };
pub const BACKGROUND_RED = CONSOLE_CHARACTER_ATTRIBUTES{ .BACKGROUND_RED = 1 };
pub const BACKGROUND_INTENSITY = CONSOLE_CHARACTER_ATTRIBUTES{ .BACKGROUND_INTENSITY = 1 };
pub const COMMON_LVB_LEADING_BYTE = CONSOLE_CHARACTER_ATTRIBUTES{ .COMMON_LVB_LEADING_BYTE = 1 };
pub const COMMON_LVB_TRAILING_BYTE = CONSOLE_CHARACTER_ATTRIBUTES{ .COMMON_LVB_TRAILING_BYTE = 1 };
pub const COMMON_LVB_GRID_HORIZONTAL = CONSOLE_CHARACTER_ATTRIBUTES{ .COMMON_LVB_GRID_HORIZONTAL = 1 };
pub const COMMON_LVB_GRID_LVERTICAL = CONSOLE_CHARACTER_ATTRIBUTES{ .COMMON_LVB_GRID_LVERTICAL = 1 };
pub const COMMON_LVB_GRID_RVERTICAL = CONSOLE_CHARACTER_ATTRIBUTES{ .COMMON_LVB_GRID_RVERTICAL = 1 };
pub const COMMON_LVB_REVERSE_VIDEO = CONSOLE_CHARACTER_ATTRIBUTES{ .COMMON_LVB_REVERSE_VIDEO = 1 };
pub const COMMON_LVB_UNDERSCORE = CONSOLE_CHARACTER_ATTRIBUTES{ .COMMON_LVB_UNDERSCORE = 1 };
pub const COMMON_LVB_SBCSDBCS = CONSOLE_CHARACTER_ATTRIBUTES{
    .COMMON_LVB_LEADING_BYTE = 1,
    .COMMON_LVB_TRAILING_BYTE = 1,
};

// TODO: this type has a FreeFunc 'ClosePseudoConsole', what can Zig do with this information?
// TODO: this type has an InvalidHandleValue of '0', what can Zig do with this information?
pub const HPCON = *opaque{};

pub const COORD = extern struct {
    X: i16,
    Y: i16,
};

pub const SMALL_RECT = extern struct {
    Left: i16,
    Top: i16,
    Right: i16,
    Bottom: i16,
};

pub const KEY_EVENT_RECORD = extern struct {
    bKeyDown: BOOL,
    wRepeatCount: u16,
    wVirtualKeyCode: u16,
    wVirtualScanCode: u16,
    uChar: extern union {
        UnicodeChar: u16,
        AsciiChar: CHAR,
    },
    dwControlKeyState: u32,
};

pub const MOUSE_EVENT_RECORD = extern struct {
    dwMousePosition: COORD,
    dwButtonState: u32,
    dwControlKeyState: u32,
    dwEventFlags: u32,
};

pub const WINDOW_BUFFER_SIZE_RECORD = extern struct {
    dwSize: COORD,
};

pub const MENU_EVENT_RECORD = extern struct {
    dwCommandId: u32,
};

pub const FOCUS_EVENT_RECORD = extern struct {
    bSetFocus: BOOL,
};

pub const INPUT_RECORD = extern struct {
    EventType: u16,
    Event: extern union {
        KeyEvent: KEY_EVENT_RECORD,
        MouseEvent: MOUSE_EVENT_RECORD,
        WindowBufferSizeEvent: WINDOW_BUFFER_SIZE_RECORD,
        MenuEvent: MENU_EVENT_RECORD,
        FocusEvent: FOCUS_EVENT_RECORD,
    },
};

pub const CHAR_INFO = extern struct {
    Char: extern union {
        UnicodeChar: u16,
        AsciiChar: CHAR,
    },
    Attributes: u16,
};

pub const CONSOLE_FONT_INFO = extern struct {
    nFont: u32,
    dwFontSize: COORD,
};

pub const CONSOLE_READCONSOLE_CONTROL = extern struct {
    nLength: u32,
    nInitialChars: u32,
    dwCtrlWakeupMask: u32,
    dwControlKeyState: u32,
};

pub const PHANDLER_ROUTINE = *const fn(
    CtrlType: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub const CONSOLE_CURSOR_INFO = extern struct {
    dwSize: u32,
    bVisible: BOOL,
};

pub const CONSOLE_SCREEN_BUFFER_INFO = extern struct {
    dwSize: COORD,
    dwCursorPosition: COORD,
    wAttributes: CONSOLE_CHARACTER_ATTRIBUTES,
    srWindow: SMALL_RECT,
    dwMaximumWindowSize: COORD,
};

pub const CONSOLE_SCREEN_BUFFER_INFOEX = extern struct {
    cbSize: u32,
    dwSize: COORD,
    dwCursorPosition: COORD,
    wAttributes: CONSOLE_CHARACTER_ATTRIBUTES,
    srWindow: SMALL_RECT,
    dwMaximumWindowSize: COORD,
    wPopupAttributes: u16,
    bFullscreenSupported: BOOL,
    ColorTable: [16]u32,
};

pub const CONSOLE_FONT_INFOEX = extern struct {
    cbSize: u32,
    nFont: u32,
    dwFontSize: COORD,
    FontFamily: u32,
    FontWeight: u32,
    FaceName: [32]u16,
};

pub const CONSOLE_SELECTION_INFO = extern struct {
    dwFlags: u32,
    dwSelectionAnchor: COORD,
    srSelection: SMALL_RECT,
};

pub const CONSOLE_HISTORY_INFO = extern struct {
    cbSize: u32,
    HistoryBufferSize: u32,
    NumberOfHistoryBuffers: u32,
    dwFlags: u32,
};


//--------------------------------------------------------------------------------
// Section: Functions (94)
//--------------------------------------------------------------------------------
pub extern "kernel32" fn AllocConsole(
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn FreeConsole(
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn AttachConsole(
    dwProcessId: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleCP(
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleOutputCP(
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleMode(
    hConsoleHandle: ?HANDLE,
    lpMode: ?*CONSOLE_MODE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleMode(
    hConsoleHandle: ?HANDLE,
    dwMode: CONSOLE_MODE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetNumberOfConsoleInputEvents(
    hConsoleInput: ?HANDLE,
    lpNumberOfEvents: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleInputA(
    hConsoleInput: ?HANDLE,
    lpBuffer: [*]INPUT_RECORD,
    nLength: u32,
    lpNumberOfEventsRead: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleInputW(
    hConsoleInput: ?HANDLE,
    lpBuffer: [*]INPUT_RECORD,
    nLength: u32,
    lpNumberOfEventsRead: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn PeekConsoleInputA(
    hConsoleInput: ?HANDLE,
    lpBuffer: [*]INPUT_RECORD,
    nLength: u32,
    lpNumberOfEventsRead: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn PeekConsoleInputW(
    hConsoleInput: ?HANDLE,
    lpBuffer: [*]INPUT_RECORD,
    nLength: u32,
    lpNumberOfEventsRead: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleA(
    hConsoleInput: ?HANDLE,
    lpBuffer: ?*anyopaque,
    nNumberOfCharsToRead: u32,
    lpNumberOfCharsRead: ?*u32,
    pInputControl: ?*CONSOLE_READCONSOLE_CONTROL,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleW(
    hConsoleInput: ?HANDLE,
    lpBuffer: ?*anyopaque,
    nNumberOfCharsToRead: u32,
    lpNumberOfCharsRead: ?*u32,
    pInputControl: ?*CONSOLE_READCONSOLE_CONTROL,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleA(
    hConsoleOutput: ?HANDLE,
    lpBuffer: [*]const u8,
    nNumberOfCharsToWrite: u32,
    lpNumberOfCharsWritten: ?*u32,
    lpReserved: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleW(
    hConsoleOutput: ?HANDLE,
    lpBuffer: [*]const u8,
    nNumberOfCharsToWrite: u32,
    lpNumberOfCharsWritten: ?*u32,
    lpReserved: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleCtrlHandler(
    HandlerRoutine: ?PHANDLER_ROUTINE,
    Add: BOOL,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn CreatePseudoConsole(
    size: COORD,
    hInput: ?HANDLE,
    hOutput: ?HANDLE,
    dwFlags: u32,
    phPC: ?*?HPCON,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "kernel32" fn ResizePseudoConsole(
    hPC: ?HPCON,
    size: COORD,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "kernel32" fn ClosePseudoConsole(
    hPC: ?HPCON,
) callconv(@import("std").os.windows.WINAPI) void;

pub extern "kernel32" fn FillConsoleOutputCharacterA(
    hConsoleOutput: ?HANDLE,
    cCharacter: CHAR,
    nLength: u32,
    dwWriteCoord: COORD,
    lpNumberOfCharsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn FillConsoleOutputCharacterW(
    hConsoleOutput: ?HANDLE,
    cCharacter: u16,
    nLength: u32,
    dwWriteCoord: COORD,
    lpNumberOfCharsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn FillConsoleOutputAttribute(
    hConsoleOutput: ?HANDLE,
    wAttribute: u16,
    nLength: u32,
    dwWriteCoord: COORD,
    lpNumberOfAttrsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GenerateConsoleCtrlEvent(
    dwCtrlEvent: u32,
    dwProcessGroupId: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn CreateConsoleScreenBuffer(
    dwDesiredAccess: u32,
    dwShareMode: u32,
    lpSecurityAttributes: ?*const SECURITY_ATTRIBUTES,
    dwFlags: u32,
    lpScreenBufferData: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) ?HANDLE;

pub extern "kernel32" fn SetConsoleActiveScreenBuffer(
    hConsoleOutput: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn FlushConsoleInputBuffer(
    hConsoleInput: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleCP(
    wCodePageID: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleOutputCP(
    wCodePageID: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleCursorInfo(
    hConsoleOutput: ?HANDLE,
    lpConsoleCursorInfo: ?*CONSOLE_CURSOR_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleCursorInfo(
    hConsoleOutput: ?HANDLE,
    lpConsoleCursorInfo: ?*const CONSOLE_CURSOR_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleScreenBufferInfo(
    hConsoleOutput: ?HANDLE,
    lpConsoleScreenBufferInfo: ?*CONSOLE_SCREEN_BUFFER_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleScreenBufferInfoEx(
    hConsoleOutput: ?HANDLE,
    lpConsoleScreenBufferInfoEx: ?*CONSOLE_SCREEN_BUFFER_INFOEX,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleScreenBufferInfoEx(
    hConsoleOutput: ?HANDLE,
    lpConsoleScreenBufferInfoEx: ?*CONSOLE_SCREEN_BUFFER_INFOEX,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleScreenBufferSize(
    hConsoleOutput: ?HANDLE,
    dwSize: COORD,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleCursorPosition(
    hConsoleOutput: ?HANDLE,
    dwCursorPosition: COORD,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetLargestConsoleWindowSize(
    hConsoleOutput: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) COORD;

pub extern "kernel32" fn SetConsoleTextAttribute(
    hConsoleOutput: ?HANDLE,
    wAttributes: CONSOLE_CHARACTER_ATTRIBUTES,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleWindowInfo(
    hConsoleOutput: ?HANDLE,
    bAbsolute: BOOL,
    lpConsoleWindow: ?*const SMALL_RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleOutputCharacterA(
    hConsoleOutput: ?HANDLE,
    lpCharacter: [*:0]const u8,
    nLength: u32,
    dwWriteCoord: COORD,
    lpNumberOfCharsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleOutputCharacterW(
    hConsoleOutput: ?HANDLE,
    lpCharacter: [*:0]const u16,
    nLength: u32,
    dwWriteCoord: COORD,
    lpNumberOfCharsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleOutputAttribute(
    hConsoleOutput: ?HANDLE,
    lpAttribute: [*:0]const u16,
    nLength: u32,
    dwWriteCoord: COORD,
    lpNumberOfAttrsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleOutputCharacterA(
    hConsoleOutput: ?HANDLE,
    lpCharacter: [*:0]u8,
    nLength: u32,
    dwReadCoord: COORD,
    lpNumberOfCharsRead: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleOutputCharacterW(
    hConsoleOutput: ?HANDLE,
    lpCharacter: [*:0]u16,
    nLength: u32,
    dwReadCoord: COORD,
    lpNumberOfCharsRead: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleOutputAttribute(
    hConsoleOutput: ?HANDLE,
    lpAttribute: [*:0]u16,
    nLength: u32,
    dwReadCoord: COORD,
    lpNumberOfAttrsRead: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleInputA(
    hConsoleInput: ?HANDLE,
    lpBuffer: [*]const INPUT_RECORD,
    nLength: u32,
    lpNumberOfEventsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleInputW(
    hConsoleInput: ?HANDLE,
    lpBuffer: [*]const INPUT_RECORD,
    nLength: u32,
    lpNumberOfEventsWritten: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ScrollConsoleScreenBufferA(
    hConsoleOutput: ?HANDLE,
    lpScrollRectangle: ?*const SMALL_RECT,
    lpClipRectangle: ?*const SMALL_RECT,
    dwDestinationOrigin: COORD,
    lpFill: ?*const CHAR_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ScrollConsoleScreenBufferW(
    hConsoleOutput: ?HANDLE,
    lpScrollRectangle: ?*const SMALL_RECT,
    lpClipRectangle: ?*const SMALL_RECT,
    dwDestinationOrigin: COORD,
    lpFill: ?*const CHAR_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleOutputA(
    hConsoleOutput: ?HANDLE,
    lpBuffer: ?*const CHAR_INFO,
    dwBufferSize: COORD,
    dwBufferCoord: COORD,
    lpWriteRegion: ?*SMALL_RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn WriteConsoleOutputW(
    hConsoleOutput: ?HANDLE,
    lpBuffer: ?*const CHAR_INFO,
    dwBufferSize: COORD,
    dwBufferCoord: COORD,
    lpWriteRegion: ?*SMALL_RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleOutputA(
    hConsoleOutput: ?HANDLE,
    lpBuffer: ?*CHAR_INFO,
    dwBufferSize: COORD,
    dwBufferCoord: COORD,
    lpReadRegion: ?*SMALL_RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn ReadConsoleOutputW(
    hConsoleOutput: ?HANDLE,
    lpBuffer: ?*CHAR_INFO,
    dwBufferSize: COORD,
    dwBufferCoord: COORD,
    lpReadRegion: ?*SMALL_RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleTitleA(
    lpConsoleTitle: [*:0]u8,
    nSize: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleTitleW(
    lpConsoleTitle: [*:0]u16,
    nSize: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleOriginalTitleA(
    lpConsoleTitle: [*:0]u8,
    nSize: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleOriginalTitleW(
    lpConsoleTitle: [*:0]u16,
    nSize: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn SetConsoleTitleA(
    lpConsoleTitle: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleTitleW(
    lpConsoleTitle: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetNumberOfConsoleMouseButtons(
    lpNumberOfMouseButtons: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleFontSize(
    hConsoleOutput: ?HANDLE,
    nFont: u32,
) callconv(@import("std").os.windows.WINAPI) COORD;

pub extern "kernel32" fn GetCurrentConsoleFont(
    hConsoleOutput: ?HANDLE,
    bMaximumWindow: BOOL,
    lpConsoleCurrentFont: ?*CONSOLE_FONT_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetCurrentConsoleFontEx(
    hConsoleOutput: ?HANDLE,
    bMaximumWindow: BOOL,
    lpConsoleCurrentFontEx: ?*CONSOLE_FONT_INFOEX,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetCurrentConsoleFontEx(
    hConsoleOutput: ?HANDLE,
    bMaximumWindow: BOOL,
    lpConsoleCurrentFontEx: ?*CONSOLE_FONT_INFOEX,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleSelectionInfo(
    lpConsoleSelectionInfo: ?*CONSOLE_SELECTION_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleHistoryInfo(
    lpConsoleHistoryInfo: ?*CONSOLE_HISTORY_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleHistoryInfo(
    lpConsoleHistoryInfo: ?*CONSOLE_HISTORY_INFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleDisplayMode(
    lpModeFlags: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleDisplayMode(
    hConsoleOutput: ?HANDLE,
    dwFlags: u32,
    lpNewScreenBufferDimensions: ?*COORD,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleWindow(
) callconv(@import("std").os.windows.WINAPI) ?HWND;

pub extern "kernel32" fn AddConsoleAliasA(
    Source: ?PSTR,
    Target: ?PSTR,
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn AddConsoleAliasW(
    Source: ?PWSTR,
    Target: ?PWSTR,
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleAliasA(
    Source: ?PSTR,
    TargetBuffer: [*:0]u8,
    TargetBufferLength: u32,
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasW(
    Source: ?PWSTR,
    TargetBuffer: [*:0]u16,
    TargetBufferLength: u32,
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasesLengthA(
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasesLengthW(
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasExesLengthA(
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasExesLengthW(
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasesA(
    AliasBuffer: [*:0]u8,
    AliasBufferLength: u32,
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasesW(
    AliasBuffer: [*:0]u16,
    AliasBufferLength: u32,
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasExesA(
    ExeNameBuffer: [*:0]u8,
    ExeNameBufferLength: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleAliasExesW(
    ExeNameBuffer: [*:0]u16,
    ExeNameBufferLength: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn ExpungeConsoleCommandHistoryA(
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) void;

pub extern "kernel32" fn ExpungeConsoleCommandHistoryW(
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) void;

pub extern "kernel32" fn SetConsoleNumberOfCommandsA(
    Number: u32,
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetConsoleNumberOfCommandsW(
    Number: u32,
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn GetConsoleCommandHistoryLengthA(
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleCommandHistoryLengthW(
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleCommandHistoryA(
    // TODO: what to do with BytesParamIndex 1?
    Commands: ?PSTR,
    CommandBufferLength: u32,
    ExeName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleCommandHistoryW(
    // TODO: what to do with BytesParamIndex 1?
    Commands: ?PWSTR,
    CommandBufferLength: u32,
    ExeName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetConsoleProcessList(
    lpdwProcessList: [*]u32,
    dwProcessCount: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "kernel32" fn GetStdHandle(
    nStdHandle: STD_HANDLE,
) callconv(@import("std").os.windows.WINAPI) HANDLE;

pub extern "kernel32" fn SetStdHandle(
    nStdHandle: STD_HANDLE,
    hHandle: ?HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn SetStdHandleEx(
    nStdHandle: STD_HANDLE,
    hHandle: ?HANDLE,
    phPrevValue: ?*?HANDLE,
) callconv(@import("std").os.windows.WINAPI) BOOL;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (24)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
    .ansi => struct {
        pub const ReadConsoleInput = thismodule.ReadConsoleInputA;
        pub const PeekConsoleInput = thismodule.PeekConsoleInputA;
        pub const ReadConsole = thismodule.ReadConsoleA;
        pub const WriteConsole = thismodule.WriteConsoleA;
        pub const FillConsoleOutputCharacter = thismodule.FillConsoleOutputCharacterA;
        pub const WriteConsoleOutputCharacter = thismodule.WriteConsoleOutputCharacterA;
        pub const ReadConsoleOutputCharacter = thismodule.ReadConsoleOutputCharacterA;
        pub const WriteConsoleInput = thismodule.WriteConsoleInputA;
        pub const ScrollConsoleScreenBuffer = thismodule.ScrollConsoleScreenBufferA;
        pub const WriteConsoleOutput = thismodule.WriteConsoleOutputA;
        pub const ReadConsoleOutput = thismodule.ReadConsoleOutputA;
        pub const GetConsoleTitle = thismodule.GetConsoleTitleA;
        pub const GetConsoleOriginalTitle = thismodule.GetConsoleOriginalTitleA;
        pub const SetConsoleTitle = thismodule.SetConsoleTitleA;
        pub const AddConsoleAlias = thismodule.AddConsoleAliasA;
        pub const GetConsoleAlias = thismodule.GetConsoleAliasA;
        pub const GetConsoleAliasesLength = thismodule.GetConsoleAliasesLengthA;
        pub const GetConsoleAliasExesLength = thismodule.GetConsoleAliasExesLengthA;
        pub const GetConsoleAliases = thismodule.GetConsoleAliasesA;
        pub const GetConsoleAliasExes = thismodule.GetConsoleAliasExesA;
        pub const ExpungeConsoleCommandHistory = thismodule.ExpungeConsoleCommandHistoryA;
        pub const SetConsoleNumberOfCommands = thismodule.SetConsoleNumberOfCommandsA;
        pub const GetConsoleCommandHistoryLength = thismodule.GetConsoleCommandHistoryLengthA;
        pub const GetConsoleCommandHistory = thismodule.GetConsoleCommandHistoryA;
    },
    .wide => struct {
        pub const ReadConsoleInput = thismodule.ReadConsoleInputW;
        pub const PeekConsoleInput = thismodule.PeekConsoleInputW;
        pub const ReadConsole = thismodule.ReadConsoleW;
        pub const WriteConsole = thismodule.WriteConsoleW;
        pub const FillConsoleOutputCharacter = thismodule.FillConsoleOutputCharacterW;
        pub const WriteConsoleOutputCharacter = thismodule.WriteConsoleOutputCharacterW;
        pub const ReadConsoleOutputCharacter = thismodule.ReadConsoleOutputCharacterW;
        pub const WriteConsoleInput = thismodule.WriteConsoleInputW;
        pub const ScrollConsoleScreenBuffer = thismodule.ScrollConsoleScreenBufferW;
        pub const WriteConsoleOutput = thismodule.WriteConsoleOutputW;
        pub const ReadConsoleOutput = thismodule.ReadConsoleOutputW;
        pub const GetConsoleTitle = thismodule.GetConsoleTitleW;
        pub const GetConsoleOriginalTitle = thismodule.GetConsoleOriginalTitleW;
        pub const SetConsoleTitle = thismodule.SetConsoleTitleW;
        pub const AddConsoleAlias = thismodule.AddConsoleAliasW;
        pub const GetConsoleAlias = thismodule.GetConsoleAliasW;
        pub const GetConsoleAliasesLength = thismodule.GetConsoleAliasesLengthW;
        pub const GetConsoleAliasExesLength = thismodule.GetConsoleAliasExesLengthW;
        pub const GetConsoleAliases = thismodule.GetConsoleAliasesW;
        pub const GetConsoleAliasExes = thismodule.GetConsoleAliasExesW;
        pub const ExpungeConsoleCommandHistory = thismodule.ExpungeConsoleCommandHistoryW;
        pub const SetConsoleNumberOfCommands = thismodule.SetConsoleNumberOfCommandsW;
        pub const GetConsoleCommandHistoryLength = thismodule.GetConsoleCommandHistoryLengthW;
        pub const GetConsoleCommandHistory = thismodule.GetConsoleCommandHistoryW;
    },
    .unspecified => if (@import("builtin").is_test) struct {
        pub const ReadConsoleInput = *opaque{};
        pub const PeekConsoleInput = *opaque{};
        pub const ReadConsole = *opaque{};
        pub const WriteConsole = *opaque{};
        pub const FillConsoleOutputCharacter = *opaque{};
        pub const WriteConsoleOutputCharacter = *opaque{};
        pub const ReadConsoleOutputCharacter = *opaque{};
        pub const WriteConsoleInput = *opaque{};
        pub const ScrollConsoleScreenBuffer = *opaque{};
        pub const WriteConsoleOutput = *opaque{};
        pub const ReadConsoleOutput = *opaque{};
        pub const GetConsoleTitle = *opaque{};
        pub const GetConsoleOriginalTitle = *opaque{};
        pub const SetConsoleTitle = *opaque{};
        pub const AddConsoleAlias = *opaque{};
        pub const GetConsoleAlias = *opaque{};
        pub const GetConsoleAliasesLength = *opaque{};
        pub const GetConsoleAliasExesLength = *opaque{};
        pub const GetConsoleAliases = *opaque{};
        pub const GetConsoleAliasExes = *opaque{};
        pub const ExpungeConsoleCommandHistory = *opaque{};
        pub const SetConsoleNumberOfCommands = *opaque{};
        pub const GetConsoleCommandHistoryLength = *opaque{};
        pub const GetConsoleCommandHistory = *opaque{};
    } else struct {
        pub const ReadConsoleInput = @compileError("'ReadConsoleInput' requires that UNICODE be set to true or false in the root module");
        pub const PeekConsoleInput = @compileError("'PeekConsoleInput' requires that UNICODE be set to true or false in the root module");
        pub const ReadConsole = @compileError("'ReadConsole' requires that UNICODE be set to true or false in the root module");
        pub const WriteConsole = @compileError("'WriteConsole' requires that UNICODE be set to true or false in the root module");
        pub const FillConsoleOutputCharacter = @compileError("'FillConsoleOutputCharacter' requires that UNICODE be set to true or false in the root module");
        pub const WriteConsoleOutputCharacter = @compileError("'WriteConsoleOutputCharacter' requires that UNICODE be set to true or false in the root module");
        pub const ReadConsoleOutputCharacter = @compileError("'ReadConsoleOutputCharacter' requires that UNICODE be set to true or false in the root module");
        pub const WriteConsoleInput = @compileError("'WriteConsoleInput' requires that UNICODE be set to true or false in the root module");
        pub const ScrollConsoleScreenBuffer = @compileError("'ScrollConsoleScreenBuffer' requires that UNICODE be set to true or false in the root module");
        pub const WriteConsoleOutput = @compileError("'WriteConsoleOutput' requires that UNICODE be set to true or false in the root module");
        pub const ReadConsoleOutput = @compileError("'ReadConsoleOutput' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleTitle = @compileError("'GetConsoleTitle' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleOriginalTitle = @compileError("'GetConsoleOriginalTitle' requires that UNICODE be set to true or false in the root module");
        pub const SetConsoleTitle = @compileError("'SetConsoleTitle' requires that UNICODE be set to true or false in the root module");
        pub const AddConsoleAlias = @compileError("'AddConsoleAlias' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleAlias = @compileError("'GetConsoleAlias' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleAliasesLength = @compileError("'GetConsoleAliasesLength' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleAliasExesLength = @compileError("'GetConsoleAliasExesLength' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleAliases = @compileError("'GetConsoleAliases' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleAliasExes = @compileError("'GetConsoleAliasExes' requires that UNICODE be set to true or false in the root module");
        pub const ExpungeConsoleCommandHistory = @compileError("'ExpungeConsoleCommandHistory' requires that UNICODE be set to true or false in the root module");
        pub const SetConsoleNumberOfCommands = @compileError("'SetConsoleNumberOfCommands' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleCommandHistoryLength = @compileError("'GetConsoleCommandHistoryLength' requires that UNICODE be set to true or false in the root module");
        pub const GetConsoleCommandHistory = @compileError("'GetConsoleCommandHistory' requires that UNICODE be set to true or false in the root module");
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (8)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;
const CHAR = @import("../foundation.zig").CHAR;
const HANDLE = @import("../foundation.zig").HANDLE;
const HRESULT = @import("../foundation.zig").HRESULT;
const HWND = @import("../foundation.zig").HWND;
const PSTR = @import("../foundation.zig").PSTR;
const PWSTR = @import("../foundation.zig").PWSTR;
const SECURITY_ATTRIBUTES = @import("../security.zig").SECURITY_ATTRIBUTES;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "PHANDLER_ROUTINE")) { _ = PHANDLER_ROUTINE; }

    @setEvalBranchQuota(
        comptime @import("std").meta.declarations(@This()).len * 3
    );

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (comptime @import("std").meta.declarations(@This())) |decl| {
        _ = @field(@This(), decl.name);
    }
}
