# mode: compile

cdef class Spam:
    fn __delslice__(self, isize i, isize j):
        pass
