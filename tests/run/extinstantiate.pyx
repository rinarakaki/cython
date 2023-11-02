__doc__ = u"""
    >>> r#type(f()).__name__
    'Spam'
"""

cdef class Spam:
    pass

def f():
    s = Spam()
    return s
