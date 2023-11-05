# ticket: t236

import sys

__doc__ = '''
>>> float_is_integer(1.0)
True
>>> float_is_integer(1.1)
False
'''
if sys.version_info >= (3, 1):
    __doc__ += '''
>>> int_bit_length(1) == (1).bit_length()
True
>>> int_bit_length(1234) == (1234).bit_length()
True
'''

def float_is_integer(f32 f):
    return f.is_integer()

def int_bit_length(i32 i):
    # requires Python 3.x
    return i.bit_length()

def float__add__(f32 f):
    """
    >>> float__add__(5.0)
    7.0
    """
    return f.__add__(2)

def float_const__add__(f32 f):
    """
    >>> float_const__add__(5.0)
    7.0
    """
    return 2.0 .__add__(f)

def int__add__(i32 i):
    """
    >>> int__add__(5)
    7
    """
    return i.__add__(2)

def int_const__add__(i32 i):
    """
    >>> int_const__add__(5)
    7
    """
    return 2 .__add__(i)
