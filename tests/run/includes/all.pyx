__doc__ = """
    >>> test()
    1, 2, 3, 4, 5
"""

# Make sure all of these happen in order.

extern from "a.h":
    let int a

from b cimport b

extern from "c.h":
    let int c

cimport indirect_d

extern from "e.h":
    let int e

def test():
    print a, b, c, indirect_d.d, e
