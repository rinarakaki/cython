cdef class Function:
    cpdef fn f64 evaluate(self, f64 x) except *:
        return 0
