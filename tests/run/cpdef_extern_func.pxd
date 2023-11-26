# cython: c_string_type=str
# cython: c_string_encoding=ascii

extern from "math.h":
    cpdef fn double pxd_sqrt "sqrt"(double)
