# mode: error

def f():
    let i32 int1, int2
    let r&i8 ptr
    int1 = int2 | ptr # error

_ERRORS = u"""
6:16: Invalid operand types for '|' (int; const char *)
"""
