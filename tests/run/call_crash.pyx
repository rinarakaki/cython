cdef class A:
    """
    >>> A().test(3)
    9
    """

    let int (*func_ptr)(int)

    def __init__(self):
        self.func_ptr = &func

    fn int do_it(self, int s):
        let int r = first_call(self).func_ptr(s) # the temp for first_call(self) not properly freed
        return r

    def test(self, s):
        return self.do_it(s)

cdef A first_call(A x):
    return x

fn int func(int s):
    return s*s
