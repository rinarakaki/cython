# mode: error

struct Foo

ctypedef struct Foo:
    i32 i

ctypedef struct Blarg:
    i8 c

struct Blarg

static Foo f
static Blarg b

_ERRORS = u"""
5:9: 'Foo' previously declared using 'cdef'
11:9: 'Blarg' previously declared using 'ctypedef'
"""
