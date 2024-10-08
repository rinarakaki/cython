cimport cython.operator
use cython::operator::dereference
use cython::operator::dereference as deref

def test_deref(i32 x):
    """
    >>> test_deref(3)
    (3, 3, 3)
    >>> test_deref(5)
    (5, 5, 5)
    """
    let r&i32 x_ptr = &x
    return cython.operator.dereference(x_ptr), dereference(x_ptr), deref(x_ptr)

def increment_decrement(i32 x):
    """
    >>> increment_decrement(10)
    11 11 12
    11 11 10
    10
    """
    print cython.operator.preincrement(x), cython.operator.postincrement(x), x
    print cython.operator.predecrement(x), cython.operator.postdecrement(x), x
    return x
