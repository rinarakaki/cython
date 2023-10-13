# ticket: t276
# mode: compile

__doc__ = u"""
"""

cdef class A:
    let __weakref__

ctypedef public class B [type B_Type, object BObject]:
    let __weakref__

cdef public class C [type C_Type, object CObject]:
    let __weakref__

