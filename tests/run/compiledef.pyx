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

const c_t = True
const c_f = False
const c_boolexpr = c_t and True and not (c_f or False)

const c_num6 = 2*3
const c_intexpr = c_num6 + 4

t = c_t
f = c_f
boolexpr = c_boolexpr
num6 = c_num6
intexpr = c_intexpr
