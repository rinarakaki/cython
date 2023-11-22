# mode: error

fn void foo(obj):
    let i32 i1
    let r&i8 p1
    let r&i32 p2
    i1 = p1  # error
    p2 = obj  # error

    obj = p2  # error


_ERRORS = u"""
7:9: Cannot assign type 'const char *' to 'int'
8:9: Cannot convert Python object to 'const int *'
10:10: Cannot convert 'const int *' to Python object
"""
