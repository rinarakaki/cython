# mode: error

cdef class A:
    let i32 value = 3

extern from *:
    struct B:
        i32 value = 3

_ERRORS = """
4:13: Cannot assign default value to fields in cdef classes, structs or unions
8:12: Cannot assign default value to fields in cdef classes, structs or unions
"""
