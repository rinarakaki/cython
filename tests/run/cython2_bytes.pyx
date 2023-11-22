# -*- coding: utf-8 -*-
# cython: language_level=2

b = b'abcüöä \x12'

cdef r&i8 cs = 'abcüöä \x12'

def compare_cs():
    """
    >>> b == compare_cs()
    True
    """
    return cs
