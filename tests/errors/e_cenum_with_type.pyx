# mode: error

use enum Spam(i32):
    A, B

_ERRORS = u"""
3:14: Expected ':', found '('
"""
