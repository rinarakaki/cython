# mode: error

def f():
    let r&i8 str1
    let f32 flt1, flt2, flt3
    flt1 = str1 ** flt3  # error
    flt1 = flt2 ** str1  # error

_ERRORS = u"""
6:16: Invalid operand types for '**' (const char *; float)
7:16: Invalid operand types for '**' (float; const char *)
"""
