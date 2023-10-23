# mode: error

extern from *:
    fn void foo(void)

_ERRORS = u"""
4:15:Use spam() rather than spam(void) to declare a function with no arguments.
"""
