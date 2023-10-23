# mode: error

cdef object x

cdef struct spam:
    object parrot

def f():
    let spam s
    s.parrot = x

_ERRORS = u"""
6:8: C struct/union member cannot be a Python object
"""
