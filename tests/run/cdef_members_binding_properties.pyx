# cython: embedsignature=true, binding=true
# mode: run

# same test as "cdef_members_T517.pyx" but "binding=true"

__doc__ = u"""
>>> a = A()
>>> a.h = 7
>>> a.i = 127
>>> a.l = 255
>>> a.q = 255
>>> a.f = 1.0/2.0
>>> a.d = 1/2.0 + 1/4.0
>>> a.g = 1/2.0 + 1/4.0 + 1/8.0
>>> a.Zf = 1+2j
>>> a.Zd = 3+4j
>>> a.Zg = 5+6j

>>> a.h, a.i, a.l
(7, 127, 255)
>>> a.RO_H, a.RO_I, a.RO_L
(7, 127, 255)
>>> a.f, a.d, a.g
(0.5, 0.75, 0.875)
>>> a.RO_F, a.RO_D, a.RO_G
(0.5, 0.75, 0.875)
>>> a.Zf, a.Zd, a.Zg
((1+2j), (3+4j), (5+6j))
>>> a.RO_ZF, a.RO_ZD, a.RO_ZG
((1+2j), (3+4j), (5+6j))

>>> b = B()
>>> b.a0 # doctest: +ELLIPSIS
Traceback (most recent call last):
AttributeError: ...

>>> b.b0 # doctest: +ELLIPSIS
Traceback (most recent call last):
AttributeError: ...

>>> b.c0 # doctest: +ELLIPSIS
Traceback (most recent call last):
AttributeError: ...

>>> isinstance(b.a1, type(None))
True
>>> isinstance(b.A2, type(None))
True
>>> isinstance(b.b1, list)
True
>>> isinstance(b.B2, list)
True
>>> isinstance(b.c1, A)
True
>>> isinstance(b.C2, A)
True

>>> b.a1 = a
>>> b.a1 is not b.A2
True

>>> try: b.b1 = 1
... except (TypeError, AttributeError): pass

>>> try: b.c1 = 1
... except (TypeError, AttributeError): pass

>>> try: b.A2 = None
... except (TypeError, AttributeError): pass

>>> try: b.B2 = []
... except (TypeError, AttributeError): pass

>>> try: b.C2 = A()
... except (TypeError, AttributeError): pass
"""


cdef class A:
    pub i16 h
    pub i32 i
    pub i64 l
    pub i128 q
    pub f32 f
    pub f64 d
    pub f128 g
    pub c64 Zf
    pub c128 Zd
    pub c256 Zg

    const i16 RO_H
    const i32 RO_I
    const i64 RO_L
    const i128 RO_Q
    const f32 RO_F
    const f64 RO_D
    const f128 RO_G
    const c64 RO_ZF
    const c128 RO_ZD
    const c256 RO_ZG

    def __cinit__(self):
        self.RO_H = 7
        self.RO_I = 127
        self.RO_L = 255
        self.RO_Q = 255
        self.RO_F = 1.0/2.0
        self.RO_D = 1/2.0 + 1/4.0
        self.RO_G = 1/2.0 + 1/4.0 + 1/8.0
        self.RO_ZF = 1+2j
        self.RO_ZD = 3+4j
        self.RO_ZG = 5+6j

cdef class B:
    cdef object a0
    pub object a1
    const object A2

    cdef list b0
    pub list b1
    const list B2

    cdef A c0
    pub A c1
    const A C2

    def __cinit__(self):
        self.b0 = self.b1 = self.B2 = []
        self.c0 = self.c1 = self.C2 = A()
