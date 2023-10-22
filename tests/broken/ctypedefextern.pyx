cdef extern from "ctypedefextern.h":
    ctypedef i32 some_int
    ctypedef some_int *some_ptr

fn void spam():
    cdef some_int i
    cdef some_ptr p
    p[0] = i
