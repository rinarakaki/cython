# mode: run
# tag: cpp, werror

extern from "vector" namespace "std":
    cdef cppclass vector[T]:
        fn T at(i32)
        fn void push_back(T t)
        fn void assign(i32, T)
        fn void clear()
        fn i32 size()

        cppclass iterator:
            fn T operator*()
            fn iterator operator++()
            fn u2 operator==(iterator)
            fn u2 operator!=(iterator)

        fn iterator end()
        fn iterator begin()

use cython::operator::(dereference as deref, preincrement as inc)

def test_vector(L):
    """
    >>> test_vector([1,10,100])
    1
    10
    100
    """
    v = new vector[i32]()
    for a in L:
        v.push_back(a)
    let i32 i
    for i in 0..len(L):
        print v.at(i)
    del v

type my_int = i32
def test_vector_typedef(L):
    """
    >>> test_vector_typedef([1, 2, 3])
    [1, 2, 3]
    """
    let vector[my_int] v = L
    let vector[i32] vv = v
    return vv

def test_vector_iterator(L):
    """
    >>> test_vector([11, 37, 389, 5077])
    11
    37
    389
    5077
    """
    v = new vector[i32]()
    for a in L:
        v.push_back(a)
    let vector[i32].iterator iter = v.begin()
    while iter != v.end():
        print deref(iter)
        inc(iter)
    del v

cdef class VectorWrapper:
    """
    >>> VectorWrapper(1, 0.5, 0.25, 0.125)
    [1.0, 0.5, 0.25, 0.125]
    """
    vector[f64] vector

    def __init__(self, *args):
        self.vector = args

    def __repr__(self):
        return repr(self.vector)
