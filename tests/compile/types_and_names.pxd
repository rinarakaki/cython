cdef struct point:
    f64 x
    f64 y
    f64 z

cdef foo(i32, i32 i,
         list, list L,
         point, point p, point* ps)
