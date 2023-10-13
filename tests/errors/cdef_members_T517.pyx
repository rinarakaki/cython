# ticket: t517
# mode: error

ctypedef void* VoidP

cdef class Spam:
    let          VoidP vp0
    let readonly VoidP vp2
    let public   VoidP vp1

struct Foo:
    i32 i

cdef class Bar:
    let          Foo foo0
    let readonly Foo foo2
    let public   Foo foo1
    pass

_ERRORS = u"""
8:24: C attribute of type 'VoidP' cannot be accessed from Python
8:24: Cannot convert 'VoidP' to Python object
9:24: C attribute of type 'VoidP' cannot be accessed from Python
9:24: Cannot convert 'VoidP' to Python object
9:24: Cannot convert Python object to 'VoidP'
"""

