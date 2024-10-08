# tag: cpp
# mode: compile

from cython.view import array

extern from "point.h" namespace "geometry":
    struct Point:
        f64 x
        f64 y
        i32 colour

cdef Point p = Point(0.0, 0.0, 0)
the_point = p

cdef Point[:;1] ps = array((10,), itemsize=sizeof(Point), format='ddi')
