# mode: error

const auto t = (1, 2, 3)
const auto t_const = (1, t, 2)
const auto t_non_const = (1, [1, 2, 3], 3, t[4])

x = t_non_const

_ERRORS = u"""
5:39: Error in compile-time expression: IndexError: tuple index out of range
7:4: Invalid type for compile-time constant: [1, 2, 3] (type list)
"""
