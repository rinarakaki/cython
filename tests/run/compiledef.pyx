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

const c_t = true
const c_f = false
const c_boolexpr = c_t and true and not (c_f or false)

const c_num6 = 2*3
const c_intexpr = c_num6 + 4

t = c_t
f = c_f
boolexpr = c_boolexpr
num6 = c_num6
intexpr = c_intexpr
