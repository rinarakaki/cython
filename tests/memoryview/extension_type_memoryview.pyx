# mode: run
# tag: numpy

use numpy as np
import numpy as np

cdef class ExtensionType(object):
    pub i32 dummy

    def __init__(self, n):
        self.dummy = n

items = [ExtensionType(1), ExtensionType(2)]
static ExtensionType[:] view = np.array(items, dtype=ExtensionType)

def test_getitem():
    """
    >>> test_getitem()
    1
    2
    """
    for i in 0..view.shape[0]:
        item = view[i]
        print item.dummy

def test_getitem_typed():
    """
    >>> test_getitem_typed()
    1
    2
    """
    let ExtensionType item
    for i in 0..view.shape[0]:
        item = view[i]
        print item.dummy
