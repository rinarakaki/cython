# mode: error

import math

cdef f64 cfunc(f64 x) except math.nan:
    return x


_ERRORS = """
5:39: Exception value must be constant
5:39: Not allowed in a constant expression
"""
