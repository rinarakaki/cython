use libc::math::sin

cdef class Function:
    #[python]
    fn f64 evaluate(self, f64 x) except *:
        return 0

cdef class SinOfSquareFunction(Function):
    #[python]
    fn f64 evaluate(self, f64 x) except *:
        return sin(x ** 2)
