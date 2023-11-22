# mode: error

def f():
    let i32 int2
    let r&mut i8 ptr1
    let r&i8 ptr2, ptr3
    ptr1 = int2 - ptr3  # error
    ptr1 = ptr2 - ptr3  # error

_ERRORS = u"""
7:16: Invalid operand types for '-' (int; coonst char *)
8:16: Cannot assign type 'ptrdiff_t' to 'char *'
"""
