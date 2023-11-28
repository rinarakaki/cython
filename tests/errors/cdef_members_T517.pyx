# ticket: t517
# mode: error

type VoidP = void*

cdef class Spam:
    cdef  VoidP vp0
    const VoidP vp2
    pub   VoidP vp1

struct Foo:
    i32 i

cdef class Bar:
    cdef  Foo foo0
    const Foo foo2
    pub   Foo foo1
    pass

_ERRORS = u"""
8:24: C attribute of type 'VoidP' cannot be accessed from Python
8:24: Cannot convert 'VoidP' to Python object
9:24: C attribute of type 'VoidP' cannot be accessed from Python
9:24: Cannot convert 'VoidP' to Python object
9:24: Cannot convert Python object to 'VoidP'
"""
