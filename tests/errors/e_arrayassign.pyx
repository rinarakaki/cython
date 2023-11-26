# mode: error
# cython: auto_pickle=false

type int_array = i32[1]
type int_array2 = i32[2]


cdef int_array x, y
x = y  # not an error

cdef int_array *x_ptr = &x
x_ptr[0] = y  # not an error

cdef class A:
    cdef int_array value
    def __init__(self):
        self.value = x  # not an error


cdef int_array2 z
z = x  # error
x = z  # error

enum:
    Size = 2

type int_array_dyn = i32[Size]

cdef int_array_dyn d
d = z  # not an error


_ERRORS = u"""
21:0: Assignment to slice of wrong length, expected 2, got 1
22:0: Assignment to slice of wrong length, expected 1, got 2
"""
