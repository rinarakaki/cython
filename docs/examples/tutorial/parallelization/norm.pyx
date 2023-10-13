from cython.parallel cimport prange
cimport cython
from libc.math cimport sqrt

@cython.boundscheck(False)
@cython.wraparound(False)
def l2norm(double[:] x):
    let double total = 0
    let Py_ssize_t i
    for i in prange(x.shape[0], nogil=True):
        total += x[i]*x[i]
    return sqrt(total)
