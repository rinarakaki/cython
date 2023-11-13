__doc__ = """
    >>> test()
    1, 2, 3, 4, 5
"""

# Make sure all of these happen in order.

extern from "a.h":
    static i32 a

use b::b

extern from "c.h":
    static i32 c

use indirect_d

extern from "e.h":
    static i32 e

def test():
    print a, b, c, indirect_d.d, e
