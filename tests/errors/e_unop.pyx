# mode: error

def f():
    let i32 int1
    let r&i8 str2
    int1 = -str2  # error
    int1 = ~str2  # error

_ERRORS = u"""
6:11: Invalid operand type for '-' (const char *)
7:11: Invalid operand type for '~' (const char *)
"""
