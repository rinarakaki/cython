cdef class Function:
    cpdef fn f64 evaluate(self, f64 x) except *

cdef class SinOfSquareFunction(Function):
    cpdef fn f64 evaluate(self, f64 x) except *
