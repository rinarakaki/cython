# ticket: t305

use cython

def test_object_conversion(o):
    """
    >>> test_object_conversion(2)
    (2+0j)
    >>> test_object_conversion(2j - 0.5)
    (-0.5+2j)
    """
    let c256 a = o
    return a
