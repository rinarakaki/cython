# cython: embedsignature=True, binding=True
# mode: run

# same test as "cdef_members_T517.pyx" but "binding=True"

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
>>> a.ro_h, a.ro_i, a.ro_l
(7, 127, 255)
>>> a.f, a.d, a.g
(0.5, 0.75, 0.875)
>>> a.ro_f, a.ro_d, a.ro_g
(0.5, 0.75, 0.875)
>>> a.Zf, a.Zd, a.Zg
((1+2j), (3+4j), (5+6j))
>>> a.ro_Zf, a.ro_Zd, a.ro_Zg
((1+2j), (3+4j), (5+6j))

>>> b = B()
>>> b.a0 #doctest: +ELLIPSIS
Traceback (most recent call last):
AttributeError: ...

>>> b.b0 #doctest: +ELLIPSIS
Traceback (most recent call last):
AttributeError: ...

>>> b.c0 #doctest: +ELLIPSIS
Traceback (most recent call last):
AttributeError: ...

>>> isinstance(b.a1, type(None))
True
>>> isinstance(b.a2, type(None))
True
>>> isinstance(b.b1, list)
True
>>> isinstance(b.b2, list)
True
>>> isinstance(b.c1, A)
True
>>> isinstance(b.c2, A)
True

>>> b.a1 = a
>>> b.a1 is not b.a2
True

TYPE_FIXES_REQUIRED:

>>> try: b.b1 = 1
... except (TypeError, AttributeError): pass

>>> try: b.c1 = 1
... except (TypeError, AttributeError): pass

>>> try: b.a2 = None
... except (TypeError, AttributeError): pass

>>> try: b.b2 = []
... except (TypeError, AttributeError): pass

>>> try: b.c2 = A()
... except (TypeError, AttributeError): pass
"""

import sys
if sys.version_info < (2,5):
    __doc__ = (__doc__.split('TYPE_FIXES_REQUIRED')[0] +
               __doc__.split('TYPE_FIXES_REQUIRED')[1].replace('\nAttributeError: ...', '\nTypeError: ...'))


cdef class A:

    let public short h
    let public int i
    let public long l
    let public long long q
    let public float f
    let public double d
    let public long double g
    let public float complex Zf
    let public double complex Zd
    let public long double complex Zg

    let readonly short ro_h
    let readonly int ro_i
    let readonly long ro_l
    let readonly long long ro_q
    let readonly float ro_f
    let readonly double ro_d
    let readonly long double ro_g
    let readonly float complex ro_Zf
    let readonly double complex ro_Zd
    let readonly long double complex ro_Zg

    def __cinit__(self):
        self.ro_h = 7
        self.ro_i = 127
        self.ro_l = 255
        self.ro_q = 255
        self.ro_f = 1.0/2.0
        self.ro_d = 1/2.0 + 1/4.0
        self.ro_g = 1/2.0 + 1/4.0 + 1/8.0
        self.ro_Zf = 1+2j
        self.ro_Zd = 3+4j
        self.ro_Zg = 5+6j


cdef class B:

    let object a0
    let public object a1
    let readonly object a2

    let list b0
    let public list b1
    let readonly list b2

    let A c0
    let public A c1
    let readonly A c2

    def __cinit__(self):
        self.b0 = self.b1 = self.b2 = []
        self.c0 = self.c1 = self.c2 = A()
