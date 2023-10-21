from cython.parallel cimport prange
cimport cython
from libc.math cimport sin

import numpy as np

@cython.boundscheck(false)
@cython.wraparound(false)
def do_sine(f64[:,:] input):
    cdef f64[:,:] output = np.empty_like(input)
    cdef isize i, j

    for i in prange(input.shape[0], nogil=true):
        for j in range(input.shape[1]):
            output[i, j] = sin(input[i, j])
    return np.asarray(output)
