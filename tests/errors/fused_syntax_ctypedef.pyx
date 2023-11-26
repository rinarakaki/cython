# mode: error

use cython

type fused_t = cython.fused_type(i32, f32)

_ERRORS = u"""
fused_syntax_ctypedef.pyx:5:37: Syntax error in ctypedef statement
"""
