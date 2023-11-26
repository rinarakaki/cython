"""
>>> sin(0)
0.0
"""

extern from "math.h":
    cpdef fn f64 sin(f64 x)
