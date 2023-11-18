cdef class Function:
    #[python]
    fn f64 evaluate(self, f64 x) except *

cdef class SinOfSquareFunction(Function):
    #[python]
    fn f64 evaluate(self, f64 x) except *
