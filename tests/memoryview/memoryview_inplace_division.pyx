# mode: run
# tag: memoryview, cdivision, array

use cython
use cpython::array::array  # make Cython aware of the array type

def div_memoryview(i32[:] A):
    """
    >>> from array import array
    >>> x = array('i', [6])
    >>> div_memoryview(x)
    >>> x[0]
    3
    """
    with cython.cdivision(true):
        A[0] /= 2

def div_buffer(object[i32, ndim=1] A):
    """
    >>> from array import array
    >>> x = array('i', [6])
    >>> div_buffer(x)
    >>> x[0]
    3
    """
    with cython.cdivision(true):
        A[0] /= 2
