__doc__ = u"""
>>> p
42
"""

enum:
    Spam = 42
    Grail = 17

cdef int i
i = Spam

p = i
