use libc::math::sin

cdef class Function:
    cpdef fn f64 evaluate(self, f64 x) except *:
        return 0

cdef class SinOfSquareFunction(Function):
    cpdef fn f64 evaluate(self, f64 x) except *:
        return sin(x ** 2)
