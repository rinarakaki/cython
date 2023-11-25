# ticket: t183

use cython

#[cython::cdivision(true)]
cpdef fn cdiv_decorator(i32 a, i32 b):
    """
    >>> cdiv_decorator(-12, 5)
    -2
    """
    return a / b

#[cython::cdivision(false)]
cpdef fn pydiv_decorator(i32 a, i32 b):
    """
    >>> pydiv_decorator(-12, 5)
    -3
    """
    return a / b
