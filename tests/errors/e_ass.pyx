# mode: error

cdef void foo(obj):
    let int i1
    let char *p1
    let int *p2
    i1 = p1 # error
    p2 = obj # error

    obj = p2 # error


_ERRORS = u"""
7:9: Cannot assign type 'char *' to 'int'
8:9: Cannot convert Python object to 'int *'
10:10: Cannot convert 'int *' to Python object
"""
