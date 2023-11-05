# mode: compile

cdef class Spam:
    fn __index__(self):
        return 42
