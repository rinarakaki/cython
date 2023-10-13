"""
>>> sin(0)
0.0
"""

extern from "math.h":
    cpdef double sin(double x)
