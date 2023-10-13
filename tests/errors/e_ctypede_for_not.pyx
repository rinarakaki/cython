# mode: error

struct Foo

struct Foo:
	i32 i

struct Blarg:
	char c

struct Blarg

cdef Foo f
cdef Blarg b

_ERRORS = """
5:0: 'Foo' previously declared using 'cdef'
11:5: 'Blarg' previously declared using 'ctypedef'
"""
