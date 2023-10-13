# ticket: t313
# mode: error

a = 3

let void* allowed = <void*>a
let double* disallowed = <double*>a

_ERRORS = u"""
7:26: Python objects cannot be cast to pointers of primitive types
"""
