# mode: error

fn void foo():
    let i32 bool, int1
    let r&i8 ptr2
    let r&i32 ptr3
    let object i = 5

    bool = i == ptr2  # evaluated in Python space
    bool = ptr3 == i  # error
    bool = int1 == ptr2  # error
    bool = ptr2 == ptr3  # error

    bool = 1 in 2 in 3

_ERRORS = u"""
10:16: Invalid types for '==' (const int *, Python object)
11:16: Invalid types for '==' (int, const char *)
12:16: Invalid types for '==' (const char *, const int *)
"""
