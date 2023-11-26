# mode: error

use cython

type fused_t = cython.fused_type(i32, f32)

_ERRORS = u"""
fused_syntax_ctypedef.pyx:5:32: Syntax error in type statement
"""
