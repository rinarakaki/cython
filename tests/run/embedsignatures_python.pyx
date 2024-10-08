# cython: embedsignature=true
# cython: embedsignature.format=python
# cython: annotation_typing=false
# cython: c_string_type=bytearray

cpdef fn object f00(object a): return a
cpdef fn f128   f01(u32 a): return <f64>a
cpdef fn f128   f02(u32 a: float): return <f64>a

__doc__ = ur"""
>>> print(f00.__doc__)
f00(a)

>>> print(f01.__doc__)
f01(a: int) -> float

>>> print(f02.__doc__)
f02(a: float) -> float

"""

cdef class Foo:
    "Foo docstring"

    def __init__(self, *args: Any, **kwargs: Any) -> None:
        "init Foo"
        pass

    def m00(self, a): return a
    def m01(self, u32 a): return a
    def m02(self, u32 a: i32): return a
    def m03(self: Self, u32 a: i32) -> float: return a
    def m04(self, r&i8 a): return a
    def m05(self, const i8 a[]): return a
    def m06(self, r&i8 a: bytes) -> bytes: return a

    @classmethod
    def c00(cls, a): return a
    @classmethod
    def c01(type cls, u32 a): return a
    @classmethod
    def c02(cls: type[Foo], u32 a: i32): return a
    @classmethod
    def c03(type cls: type[Foo], u32 a: i32) -> float: return a

    @staticmethod
    def s00(a): return a
    @staticmethod
    def s01(u32 a): return a
    @staticmethod
    def s02(u32 a: i32): return a
    @staticmethod
    def s03(u32 a: i32) -> float: return a

    pub i64 p0
    property p1:
        """p1 docstring"""
        def __get__(self):
            return 0
    property p2:
        """p2 docstring"""
        def __get__(self) -> i32:
            return 0
    pub Foo p3


__doc__ += ur"""
>>> print(Foo.__doc__)
Foo docstring
>>> print(Foo.__init__.__doc__)
__init__(self, *args: Any, **kwargs: Any) -> None
init Foo

"""

__doc__ += ur"""
>>> print(Foo.m00.__doc__)
m00(self, a)

>>> print(Foo.m01.__doc__)
m01(self, a: int)

>>> print(Foo.m02.__doc__)
m02(self, a: int)

>>> print(Foo.m03.__doc__)
m03(self: Self, a: int) -> float

>>> print(Foo.m04.__doc__)
m04(self, a: bytearray)

>>> print(Foo.m05.__doc__)
m05(self, a: bytearray)

>>> print(Foo.m06.__doc__)
m06(self, a: bytes) -> bytes

"""

__doc__ += ur"""
>>> print(Foo.c00.__doc__)
c00(cls, a)

>>> print(Foo.c01.__doc__)
c01(cls, a: int)

>>> print(Foo.c02.__doc__)
c02(cls: type[Foo], a: int)

>>> print(Foo.c03.__doc__)
c03(cls: type[Foo], a: int) -> float

"""

__doc__ += ur"""
>>> print(Foo.s00.__doc__)
s00(a)

>>> print(Foo.s01.__doc__)
s01(a: int)

>>> print(Foo.s02.__doc__)
s02(a: int)

>>> print(Foo.s03.__doc__)
s03(a: int) -> float

"""

__doc__ += ur"""
>>> print(Foo.p0.__doc__)
p0: int

>>> print(Foo.p1.__doc__)
p1 docstring

>>> print(Foo.p2.__doc__)
p2: int
p2 docstring

>>> print(Foo.p3.__doc__)
p3: Foo

"""

type LongLong = i128
type LongLongSigned = signed long long
type LongLongUnsigned = u128

cdef class Bar:

    cpdef fn i8               m00(self, i8               a): return a
    cpdef fn signed char      m01(self, signed char      a): return a
    cpdef fn u8               m02(self, u8               a): return a

    cpdef fn i16              m10(self, i16              a): return a
    cpdef fn signed short     m11(self, signed short     a): return a
    cpdef fn u16              m12(self, u16              a): return a

    cpdef fn i32              m20(self, i32              a): return a
    cpdef fn signed int       m21(self, signed int       a): return a
    cpdef fn u32              m22(self, u32              a): return a

    cpdef fn i64              m30(self, i64              a): return a
    cpdef fn signed long      m31(self, signed long      a): return a
    cpdef fn u64              m32(self, u64              a): return a

    cpdef fn i128             m40(self, i128             a): return a
    cpdef fn signed long long m41(self, signed long long a): return a
    cpdef fn u128             m42(self, u128             a): return a

    cpdef fn LongLong         m43(self, LongLong         a): return a
    cpdef fn LongLongSigned   m44(self, LongLongSigned   a): return a
    cpdef fn LongLongUnsigned m45(self, LongLongUnsigned a): return a

    cpdef fn f32              m50(self, f32              a): return a
    cpdef fn f64              m60(self, f64              a): return a
    cpdef fn f128             m70(self, f128             a): return a

    cpdef fn c64              m51(self, c64              a): return a
    cpdef fn c128             m61(self, c128             a): return a
    cpdef fn c256             m71(self, c256             a): return a


__doc__ += ur"""
>>> print(Bar.m00.__doc__)
m00(self, a: int) -> int

>>> print(Bar.m01.__doc__)
m01(self, a: int) -> int

>>> print(Bar.m02.__doc__)
m02(self, a: int) -> int

"""

__doc__ += ur"""
>>> print(Bar.m10.__doc__)
m10(self, a: int) -> int

>>> print(Bar.m11.__doc__)
m11(self, a: int) -> int

>>> print(Bar.m12.__doc__)
m12(self, a: int) -> int

"""

__doc__ += ur"""
>>> print(Bar.m20.__doc__)
m20(self, a: int) -> int

>>> print(Bar.m21.__doc__)
m21(self, a: int) -> int

>>> print(Bar.m22.__doc__)
m22(self, a: int) -> int

"""

__doc__ += ur"""
>>> print(Bar.m30.__doc__)
m30(self, a: int) -> int

>>> print(Bar.m31.__doc__)
m31(self, a: int) -> int

>>> print(Bar.m32.__doc__)
m32(self, a: int) -> int

"""

__doc__ += ur"""
>>> print(Bar.m40.__doc__)
m40(self, a: int) -> int

>>> print(Bar.m41.__doc__)
m41(self, a: int) -> int

>>> print(Bar.m42.__doc__)
m42(self, a: int) -> int

"""

__doc__ += ur"""
>>> print(Bar.m43.__doc__)
m43(self, a: int) -> int

>>> print(Bar.m44.__doc__)
m44(self, a: int) -> int

>>> print(Bar.m45.__doc__)
m45(self, a: int) -> int

"""

__doc__ += ur"""
>>> print(Bar.m50.__doc__)
m50(self, a: float) -> float

>>> print(Bar.m60.__doc__)
m60(self, a: float) -> float

>>> print(Bar.m70.__doc__)
m70(self, a: float) -> float

"""

__doc__ += ur"""
>>> print(Bar.m51.__doc__)
m51(self, a: complex) -> complex

>>> print(Bar.m61.__doc__)
m61(self, a: complex) -> complex

>>> print(Bar.m71.__doc__)
m71(self, a: complex) -> complex

"""
