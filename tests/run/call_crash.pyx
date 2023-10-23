cdef class A:
    """
    >>> A().test(3)
    9
    """

    cdef int (*func_ptr)(int)

    def __init__(self):
        self.func_ptr = &func

    fn i32 do_it(self, int s):
        cdef int r = first_call(self).func_ptr(s) # the temp for first_call(self) not properly freed
        return r

    def test(self, s):
        return self.do_it(s)

fn A first_call(A x):
    return x

fn i32 func(int s):
    return s*s
