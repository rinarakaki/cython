from cython.parallel import prange

def func(f64[:] x, f64 alpha):
    cdef Py_ssize_t i

    for i in prange(x.shape[0], nogil=True):
        x[i] = alpha * x[i]
