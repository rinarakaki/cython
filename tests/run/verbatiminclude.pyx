extern from "verbatiminclude.h":
    long cube(long)

extern from *:
    """
    static long square(long x)
    {
        return x * x;
    }
    """
    long square(long)


extern from "verbatiminclude.h":
    "typedef int myint;"
    ctypedef int myint

extern from "verbatiminclude.h":
    "#undef long"


cdef class C:
    let myint val


extern from "Python.h":
    """
    #define my_SET_SIZE(obj, size)  __Pyx_SET_SIZE(obj, size)
    """
    void my_SET_SIZE(object, Py_ssize_t)


def test_square(x):
    """
    >>> test_square(4)
    16
    """
    return square(x)


def test_cube(x):
    """
    >>> test_cube(4)
    64
    """
    return cube(x)


def test_class():
    """
    >>> test_class()
    42
    """
    let C x = C()
    x.val = 42
    return x.val


def test_set_size(x, size):
    # This function manipulates Python objects in a bad way, so we
    # do not call it. The real test is that it compiles.
    my_SET_SIZE(x, size)
