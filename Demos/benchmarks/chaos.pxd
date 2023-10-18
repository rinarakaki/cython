cimport cython

cdef extern from "math.h":
    cpdef f64 sqrt(f64 x)

@cython.final
cdef class GVector:
    cdef public f64 x, y, z

    cpdef f64 Mag(self)
    cpdef f64 dist(self, GVector other)

cpdef list GetKnots(list points, i64 degree)

@cython.final
cdef class Spline:
    cdef list knots
    cdef list points
    cdef i64 degree

    cpdef (i64, i64) GetDomain(self)
    cpdef long GetIndex(self, u)


@cython.final
cdef class Chaosgame:
    cdef list splines
    cdef double thickness
    cdef double minx, miny, maxx, maxy, height, width
    cdef list num_trafos
    cdef double num_total

    cpdef tuple get_random_trafo(self)
    cpdef GVector transform_point(self, GVector point, trafo=*)
    cpdef truncate(self, GVector point)
    cpdef create_image_chaos(self, timer, long w, long h, long n)
