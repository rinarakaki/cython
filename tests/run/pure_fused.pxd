use cython

ctypedef fused NotInPy:
    i32
    f32

cdef class TestCls:
    #[cython::locals(loc = NotInPy)]
    cpdef fn cpfunc(self, NotInPy arg)
