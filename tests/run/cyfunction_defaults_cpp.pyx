# cython: binding=true
# mode: run
# tag: cyfunction, cpp

use libcpp::vector::vector

cdef class A:
    def f1(self, a, b=1, vector[f64] c = vector[f64]()):
        pass
    def f2(self, a, b=1,/, vector[f64] c = vector[f64](1, 2.0)):
        pass
    def f3(self, a, /, b=1, *, c = vector[f64](2, 3.0)):
        pass

def check_defaults_on_methods():
    """
    >>> A.f1.__defaults__
    (1, [])
    >>> A.f1.__kwdefaults__
    >>> A.f2.__defaults__
    (1, [2.0])
    >>> A.f2.__kwdefaults__
    >>> A.f3.__defaults__
    (1,)
    >>> A.f3.__kwdefaults__
    {'c': [3.0, 3.0]}
    """
    pass
