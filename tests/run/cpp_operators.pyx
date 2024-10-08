# mode: run
# tag: cpp, werror

from __future__ import division

use cython::typeof

cimport cython.operator
use cython::operator::(typeid, dereference as deref)

use libcpp::bool

fn out(s, result_type=None):
    print '%s [%s]' % (s.decode('ascii'), result_type)

fn iout(i32 s, result_type=None):
    print '%s [%s]' % (s, result_type)

extern from "cpp_operators_helper.h" nogil:
    cdef cppclass TestOps:
        fn r&i8 operator+() except +
        fn r&i8 operator-() except +
        fn r&i8 operator*() except +
        fn r&i8 operator~() except +
        fn r&i8 operator!() except +

        # FIXME: using 'except +' here leads to wrong calls ???
        fn r&i8 operator++()
        fn r&i8 operator--()
        fn r&i8 operator++(i32)
        fn r&i8 operator--(i32)

        fn r&i8 operator+(i32) except +
        fn r&i8 operator+(i32, &TestOps) except +
        fn r&i8 operator-(i32) except +
        fn r&i8 operator-(i32, &TestOps) except +
        fn r&i8 operator*(i32) except +
        # deliberately omitted operator* to test case where only defined outside class
        fn r&i8 operator/(i32) except +
        fn r&i8 operator/(i32, &TestOps) except +
        fn r&i8 operator%(i32) except +
        fn r&i8 operator%(i32, &TestOps) except +

        fn r&i8 operator|(i32) except +
        fn r&i8 operator|(i32, &TestOps) except +
        fn r&i8 operator&(i32) except +
        fn r&i8 operator&(i32, &TestOps) except +
        fn r&i8 operator^(i32) except +
        fn r&i8 operator^(i32, &TestOps) except +
        fn r&i8 operator,(i32) except +
        fn r&i8 operator,(i32, &TestOps) except +

        fn r&i8 operator<<(i32) except +
        fn r&i8 operator<<(i32, &TestOps) except +
        fn r&i8 operator>>(i32) except +
        fn r&i8 operator>>(i32, &TestOps) except +

        # FIXME: using 'except +' here leads to invalid C++ code ???
        fn r&i8 operator==(i32)
        fn r&i8 operator!=(i32)
        fn r&i8 operator>=(i32)
        fn r&i8 operator<=(i32)
        fn r&i8 operator>(i32)
        fn r&i8 operator<(i32)

        fn r&i8 operator[](i32) except +
        fn r&i8 operator()(i32) except +

    # Defining the operator outside the class does work
    # but doesn't help when importing from pxd files
    # (they don't get imported)
    fn r&i8 operator+(f32, &TestOps) except +
    # deliberately omitted operator- to test case where only defined in class
    fn r&i8 operator*(f32, &TestOps) except +
    fn r&i8 operator/(f32, &TestOps) except +
    fn r&i8 operator%(f32, &TestOps) except +

    fn r&i8 operator|(f32, &TestOps) except +
    fn r&i8 operator&(f32, &TestOps) except +
    fn r&i8 operator^(f32, &TestOps) except +
    fn r&i8 operator,(f32, &TestOps) except +

    fn r&i8 operator<<(f32,&TestOps) except +
    fn r&i8 operator>>(f32,&TestOps) except +

    cdef cppclass RefTestOps:
        fn &mut i32 operator+() except +
        fn &mut i32 operator-() except +
        fn &mut i32 operator*() except +
        fn &mut i32 operator~() except +
        fn &mut i32 operator!() except +

        fn &mut i32 operator++() except +
        fn &mut i32 operator--() except +
        fn &mut i32 operator++(i32) except +
        fn &mut i32 operator--(i32) except +

        fn &mut i32 operator+(i32) except +
        fn &mut i32 operator+(i32, &TestOps) except +
        fn &mut i32 operator-(i32) except +
        fn &mut i32 operator-(i32, &TestOps) except +
        fn &mut i32 operator*(i32) except +
        # deliberately omitted operator* to test case where only defined outside class
        fn &mut i32 operator/(i32) except +
        fn &mut i32 operator/(i32, &TestOps) except +
        fn &mut i32 operator%(i32) except +
        fn &mut i32 operator%(i32, &TestOps) except +

        fn &mut i32 operator|(i32) except +
        fn &mut i32 operator|(i32, &TestOps) except +
        fn &mut i32 operator&(i32) except +
        fn &mut i32 operator&(i32, &TestOps) except +
        fn &mut i32 operator^(i32) except +
        fn &mut i32 operator^(i32, &TestOps) except +
        fn &mut i32 operator,(i32) except +
        fn &mut i32 operator,(i32, &TestOps) except +

        fn &mut i32 operator<<(i32) except +
        fn &mut i32 operator<<(i32, &TestOps) except +
        fn &mut i32 operator>>(i32) except +
        fn &mut i32 operator>>(i32, &TestOps) except +

        fn &mut i32 operator==(i32) except +
        fn &mut i32 operator!=(i32) except +
        fn &mut i32 operator>=(i32) except +
        fn &mut i32 operator<=(i32) except +
        fn &mut i32 operator>(i32) except +
        fn &mut i32 operator<(i32) except +

        fn &mut i32 operator[](i32) except +
        fn &mut i32 operator()(i32) except +

    cdef cppclass TruthClass:
        TruthClass()
        TruthClass(bool)
        fn bool operator bool()
        fn bool value


cdef cppclass TruthSubClass(TruthClass):
    pass


def test_unops():
    """
    >>> test_unops()
    unary + [const_char *]
    unary - [const_char *]
    unary ~ [const_char *]
    unary * [const_char *]
    unary ! [const_char *]
    """
    let TestOps* t = new TestOps()
    out(+t[0], typeof(+t[0]))
    out(-t[0], typeof(-t[0]))
    out(~t[0], typeof(~t[0]))
    x = deref(t[0])
    out(x, typeof(x))
    out(not t[0], typeof(not t[0]))
    del t

def test_incdec():
    """
    >>> test_incdec()
    unary ++ [const_char *]
    unary -- [const_char *]
    post ++ [const_char *]
    post -- [const_char *]
    """
    let TestOps* t = new TestOps()
    a = cython.operator.preincrement(t[0])
    out(a, typeof(a))
    b = cython.operator.predecrement(t[0])
    out(b, typeof(b))
    c = cython.operator.postincrement(t[0])
    out(c, typeof(c))
    d = cython.operator.postdecrement(t[0])
    out(d, typeof(d))
    del t

def test_binop():
    """
    >>> test_binop()
    binary + [const_char *]
    binary - [const_char *]
    binary * [const_char *]
    binary / [const_char *]
    binary % [const_char *]
    binary & [const_char *]
    binary | [const_char *]
    binary ^ [const_char *]
    binary << [const_char *]
    binary >> [const_char *]
    binary COMMA [const_char *]
    """
    let TestOps* t = new TestOps()
    out(t[0] + 1, typeof(t[0] + 1))
    out(t[0] - 1, typeof(t[0] - 1))
    out(t[0] * 1, typeof(t[0] * 1))
    out(t[0] / 1, typeof(t[0] / 1))
    out(t[0] % 1, typeof(t[0] % 1))

    out(t[0] & 1, typeof(t[0] & 1))
    out(t[0] | 1, typeof(t[0] | 1))
    out(t[0] ^ 1, typeof(t[0] ^ 1))

    out(t[0] << 1, typeof(t[0] << 1))
    out(t[0] >> 1, typeof(t[0] >> 1))

    x = cython.operator.comma(t[0], 1)
    out(x, typeof(x))
    del t

def test_nonmember_binop():
    """
    >>> test_nonmember_binop()
    nonmember binary + [const_char *]
    nonmember binary - [const_char *]
    nonmember binary / [const_char *]
    nonmember binary % [const_char *]
    nonmember binary & [const_char *]
    nonmember binary | [const_char *]
    nonmember binary ^ [const_char *]
    nonmember binary << [const_char *]
    nonmember binary >> [const_char *]
    nonmember binary COMMA [const_char *]
    nonmember binary2 + [const_char *]
    nonmember binary2 * [const_char *]
    nonmember binary2 / [const_char *]
    nonmember binary2 % [const_char *]
    nonmember binary2 & [const_char *]
    nonmember binary2 | [const_char *]
    nonmember binary2 ^ [const_char *]
    nonmember binary2 << [const_char *]
    nonmember binary2 >> [const_char *]
    nonmember binary2 COMMA [const_char *]
    """

    let TestOps* t = new TestOps()
    out(1 + t[0], typeof(1 + t[0]))
    out(1 - t[0], typeof(1 - t[0]))
    # * deliberately omitted
    out(1 / t[0], typeof(1 / t[0]))
    out(1 % t[0], typeof(1 % t[0]))
    out(1 & t[0], typeof(1 & t[0]))
    out(1 | t[0], typeof(1 | t[0]))
    out(1 ^ t[0], typeof(1 ^ t[0]))
    out(1 << t[0], typeof(1 << t[0]))
    out(1 >> t[0], typeof(1 >> t[0]))

    x = cython.operator.comma(1, t[0])
    out(x, typeof(x))

    # now test float operators defined outside class
    out(1.0 + t[0], typeof(1.0 + t[0]))
    # operator - deliberately omitted
    out(1.0 * t[0], typeof(1.0 * t[0]))
    out(1.0 / t[0], typeof(1.0 / t[0]))
    out(1.0 % t[0], typeof(1.0 % t[0]))
    out(1.0 & t[0], typeof(1.0 & t[0]))
    out(1.0 | t[0], typeof(1.0 | t[0]))
    out(1.0 ^ t[0], typeof(1.0 ^ t[0]))
    out(1.0 << t[0], typeof(1.0 << t[0]))
    out(1.0 >> t[0], typeof(1.0 >> t[0]))

    # for some reason we need a cdef here - not sure this is quite right
    y = cython.operator.comma(1.0, t[0])
    out(y, typeof(y))
    del t

def test_cmp():
    """
    >>> test_cmp()
    binary == [const_char *]
    binary != [const_char *]
    binary >= [const_char *]
    binary > [const_char *]
    binary <= [const_char *]
    binary < [const_char *]
    """
    let TestOps* t = new TestOps()
    out(t[0] == 1, typeof(t[0] == 1))
    out(t[0] != 1, typeof(t[0] != 1))
    out(t[0] >= 1, typeof(t[0] >= 1))
    out(t[0] > 1, typeof(t[0] > 1))
    out(t[0] <= 1, typeof(t[0] <= 1))
    out(t[0] < 1, typeof(t[0] < 1))
    del t

def test_index_call():
    """
    >>> test_index_call()
    binary [] [const_char *]
    binary () [const_char *]
    """
    let TestOps* t = new TestOps()
    out(t[0][100], typeof(t[0][100]))
    out(t[0](100), typeof(t[0](100)))
    del t

def test_index_assignment():
    """
    >>> test_index_assignment()
    0 [int &]
    123 [int [&]]
    """
    let RefTestOps* t = new RefTestOps()
    iout(t[0][100], typeof(t[0][100]))
    t[0][99] = 123
    iout(t[0](100), typeof(t[0](100)))
    del t

def test_bool_op():
    """
    >>> test_bool_op()
    """
    let TruthClass yes = TruthClass(true)
    let TruthClass no = TruthClass(false)
    if yes:
        pass
    else:
        assert false
    if no:
        assert false

def test_bool_cond():
    """
    >>> test_bool_cond()
    """
    assert (TruthClass(false) or TruthClass(false)).value == false
    assert (TruthClass(false) or TruthClass(true)).value == true
    assert (TruthClass(true) or TruthClass(false)).value == true
    assert (TruthClass(true) or TruthClass(true)).value == true

    assert (TruthClass(false) and TruthClass(false)).value == false
    assert (TruthClass(false) and TruthClass(true)).value == false
    assert (TruthClass(true) and TruthClass(false)).value == false
    assert (TruthClass(true) and TruthClass(true)).value == true

type int_ptr = i32*

def test_typeid_op():
    """
    >>> test_typeid_op()
    """
    let TruthClass* test_1 = new TruthClass()
    let TruthSubClass* test_2 = new TruthSubClass()
    let auto test_3 = <TruthClass*>test_2
    let auto test_4 = <TruthClass*>0

    assert typeid(TruthClass).name()
    assert typeid(test_1).name()
    assert typeid(TruthClass) == typeid(deref(test_1))

    assert typeid(TruthSubClass).name()
    assert typeid(test_2).name()
    assert typeid(TruthSubClass) == typeid(deref(test_2))
    assert typeid(TruthSubClass) == typeid(deref(test_3))
    assert typeid(TruthClass) != typeid(deref(test_3))

    assert typeid(TruthClass).name()
    assert typeid(test_3).name()
    assert typeid(TruthSubClass).name()
    assert typeid(deref(test_2)).name()
    assert typeid(int_ptr).name()

    try:
        typeid(deref(test_4))
        assert false
    except TypeError:
        assert true

    del test_1, test_2
