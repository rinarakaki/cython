__doc__ = u"""
    >>> t
    True
    >>> f
    False
    >>> boolexpr
    True
    >>> num6
    6
    >>> intexpr
    10
"""

const u2 c_t = true
const u2 c_f = false
const u2 c_boolexpr = c_t and true and not (c_f or false)

const auto c_num6 = 2 * 3
const auto c_intexpr = c_num6 + 4

t = c_t
f = c_f
boolexpr = c_boolexpr
num6 = c_num6
intexpr = c_intexpr
