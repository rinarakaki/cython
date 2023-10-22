import cython

x = cython.declare(cython.i32)              # cdef int x
y = cython.declare(cython.f64, 0.57721)  # cdef double y = 0.57721
