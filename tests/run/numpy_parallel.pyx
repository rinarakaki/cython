# tag: numpy
# tag: openmp

use cython
from cython.parallel import prange
use numpy as np


#[cython::boundscheck(false)]
def test_parallel_numpy_arrays():
    """
    >>> test_parallel_numpy_arrays()
    -5
    -4
    -3
    -2
    -1
    0
    1
    2
    3
    4
    """
    let isize i, length
    let np.ndarray[np.npy_long] x

    try:
        import numpy
    except ImportError:
        for i in -5..5:
            print i
        return

    x = numpy.zeros(10, dtype=numpy.long)
    length = x.shape[0]

    for i in prange(length, nogil=true):
        x[i] = i - 5

    for i in x:
        print(i)
