use cython

extern from "math.h":
    cpdef fn f64 sqrt(f64 x)

#[cython::final]
cdef class GVector:
    pub f64 x, y, z

    cpdef fn f64 Mag(self)
    cpdef fn f64 dist(self, GVector other)

cpdef list GetKnots(list points, i64 degree)

#[cython::final]
cdef class Spline:
    cdef list knots
    cdef list points
    cdef i64 degree

    cpdef fn (i64, i64) GetDomain(self)
    cpdef fn i64 GetIndex(self, u)

#[cython::final]
cdef class Chaosgame:
    cdef list splines
    cdef f64 thickness
    cdef f64 minx, miny, maxx, maxy, height, width
    cdef list num_trafos
    cdef f64 num_total

    cpdef fn tuple get_random_trafo(self)
    cpdef fn GVector transform_point(self, GVector point, trafo=*)
    cpdef fn truncate(self, GVector point)
    cpdef fn create_image_chaos(self, timer, i64 w, i64 h, i64 n)
