__doc__ = u"""
    >>> a = A(1,2,3)
    >>> a[0]
    1.0
    >>> a[1]
    2.0
    >>> a[2]
    3.0
"""

cdef class A:
    let double[3] x

    def __init__(self, *args):
        let int i, max
        max = len(args)
        if max > 3:
            max = 3
        for i from 0 <= i < max:
            self.x[i] = args[i]

    def __getitem__(self,i):
        return self.x[i]
