# ticket: t608

# see "builtin_type_inheritance_T608_py2only.pyx" for inheritance from int

cdef class MyFloat(float):
    """
    >>> MyFloat(1.0)== 1.0
    True
    >>> MyFloat(1.0).ATTR is None
    True
    """
    const object ATTR

ustring = u'abc'

cdef class MyUnicode(unicode):
    """
    >>> MyUnicode(ustring) == ustring
    True
    >>> MyUnicode(ustring + ustring) == ustring
    False
    >>> MyUnicode(ustring).ATTR is None
    True
    """
    const object ATTR

cdef class MyList(list):
    """
    >>> MyList([1, 2, 3]) == [1, 2, 3]
    True
    >>> MyList([1, 2, 3]).ATTR is None
    True
    """
    const object ATTR

cdef class MyListOverride(list):
    """
    >>> MyListOverride([1, 2, 3]) == [1, 2, 3]
    True
    >>> l = MyListOverride([1, 2, 3])
    >>> l.reverse()
    >>> l
    [1, 2, 3, 5]
    >>> l._reverse()
    >>> l
    [1, 2, 3, 5, 5]
    """
    # not doctested:
    """
    >>> l = MyListOverride([1, 2, 3])
    >>> l.append(8)
    >>> l
    [1, 2, 3, 0, 8]
    >>> l._append(9)
    >>> l
    [1, 2, 3, 0, 8, 0, 9]
    """
    def reverse(self):
        self[:] = self + [5]

    def _reverse(self):
        self.reverse()

    # FIXME: this doesn't currently work:

    # fn i32 append(self, value) except -1:
    #     self[:] = self + [0] + [value]
    #     return 0

    # def _append(self, value):
    #     self.append(value)

cdef class MyDict(dict):
    """
    >>> MyDict({1:2, 3:4}) == {1:2, 3:4}
    True
    >>> MyDict({1:2, 3:4}).ATTR is None
    True
    """
    const object ATTR

cdef class MyException(Exception):
    """
    >>> raise MyException(3) # doctest: +IGNORE_EXCEPTION_DETAIL
    Traceback (most recent call last):
    ...
    MyException: 3
    """
    const i32 VALUE

    def __cinit__(self, VALUE):
        self.VALUE = VALUE

def test_exception_isinstance(maybe_exn):
    """
    >>> test_exception_isinstance(Exception())
    True
    >>> test_exception_isinstance(MyException(3))
    True
    >>> test_exception_isinstance(3)
    False
    """
    return isinstance(maybe_exn, Exception)

def test_exception_type_cast(Exception maybe_exn):
    """
    >>> test_exception_type_cast(Exception())
    >>> test_exception_type_cast(MyException(3))
    >>> test_exception_type_cast(3)   # doctest: +ELLIPSIS
    Traceback (most recent call last):
    ...
    TypeError: Argument 'maybe_exn' has incorrect type (expected ...Exception, got int)
    """
    let object o = maybe_exn
    let Exception e = o
