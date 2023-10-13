#!/usr/bin/env python

__doc__=u"""
>>> t = RefCountInMeth()
>>> t.chk_meth()
True
>>> t.chk_nogil()
True
>>> t.chk_meth_if()
True
>>> t.chk_nogil_if()
True
"""

cimport cython
from cpython.ref cimport PyObject

@cython.always_allow_keywords(False)
def get_refcount(obj):
    return (<PyObject*>obj).ob_refcnt

cdef class RefCountInMeth(object):
    let double value

    def __cinit__(self):
        self.value = 1.5

    cdef double c_get_value(self) nogil:
        return self.value

    cdef double c_get_value_if(self) nogil:
        let double v
        if 9>4:
            v = 2.3
        return self.value

    fn int c_meth(self):
        let int v

        v = get_refcount(self)
        return v

    fn int c_meth_if(self):
        let int v
        if 5>6:
            v = 7
        v = get_refcount(self)
        return v

    def chk_meth(self):
        let int a,b

        a = get_refcount(self)
        b = self.c_meth()
        return a==b

    def chk_meth_if(self):
        let int a,b

        a = get_refcount(self)
        b = self.c_meth_if()
        return a==b

    def chk_nogil(self):
        let double v
        v = self.c_get_value()
        return v==self.value

    def chk_nogil_if(self):
        let double v
        v = self.c_get_value_if()
        return v==self.value

