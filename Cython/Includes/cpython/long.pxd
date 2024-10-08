extern from "Python.h":
    type PY_LONG_LONG = i128
    type uPY_LONG_LONG "unsigned PY_LONG_LONG" = u128

    # ##########################################################################
    # 7.2.3 Long Integer Objects
    # ##########################################################################

    # PyLongObject
    #
    # This subtype of PyObject represents a Python long integer object.

    # PyTypeObject PyLong_Type
    #
    # This instance of PyTypeObject represents the Python long integer
    # type. This is the same object as long and types.LongType.

    fn u2 PyLong_Check(object p)
    # Return true if its argument is a PyLongObject or a subtype of PyLongObject.

    fn u2 PyLong_CheckExact(object p)
    # Return true if its argument is a PyLongObject, but not a subtype of PyLongObject.

    fn object PyLong_FromLong(i64 v)
    # Return value: New reference.
    # Return a new PyLongObject object from v, or NULL on failure.

    fn object PyLong_FromUnsignedLong(u64 v)
    # Return value: New reference.
    # Return a new PyLongObject object from a C unsigned long, or NULL on failure.

    fn object PyLong_FromSsize_t(isize v)
    # Return value: New reference.
    # Return a new PyLongObject object from a C Py_ssize_t, or NULL on failure.)

    fn object PyLong_FromSize_t(usize v)
    # Return value: New reference.
    # Return a new PyLongObject object from a C size_t, or NULL on failure.

    fn object PyLong_FromLongLong(PY_LONG_LONG v)
    # Return value: New reference.
    # Return a new PyLongObject object from a C long long, or NULL on failure.

    fn object PyLong_FromUnsignedLongLong(uPY_LONG_LONG v)
    # Return value: New reference.
    # Return a new PyLongObject object from a C unsigned long long, or NULL on failure.

    fn object PyLong_FromDouble(f64 v)
    # Return value: New reference.
    # Return a new PyLongObject object from the integer part of v, or NULL on failure.

    fn object PyLong_FromString(r&i8 str, i8** pend, i32 base)
    # Return value: New reference.
    # Return a new PyLongObject based on the string value in str,
    # which is interpreted according to the radix in base. If pend is
    # non-NULL, *pend will point to the first character in str which
    # follows the representation of the number. If base is 0, the
    # radix will be determined based on the leading characters of str:
    # if str starts with '0x' or '0X', radix 16 will be used; if str
    # starts with '0', radix 8 will be used; otherwise radix 10 will
    # be used. If base is not 0, it must be between 2 and 36,
    # inclusive. Leading spaces are ignored. If there are no digits,
    # ValueError will be raised.

    fn object PyLong_FromUnicode(Py_UNICODE *u, isize length, i32 base)
    # Return value: New reference.
    # Convert a sequence of Unicode digits to a Python long integer
    # value. The first parameter, u, points to the first character of
    # the Unicode string, length gives the number of characters, and
    # base is the radix for the conversion. The radix must be in the
    # range [2, 36]; if it is out of range, ValueError will be
    # raised.

    # object PyLong_FromUnicodeObject(object u, i32 base)
    # Convert a sequence of Unicode digits in the string u to a Python integer
    # value. The Unicode string is first encoded to a byte string using
    # PyUnicode_EncodeDecimal() and then converted using PyLong_FromString().
    # New in version 3.3.

    fn object PyLong_FromVoidPtr(void* p)
    # Return value: New reference.
    # Create a Python integer or long integer from the pointer p. The
    # pointer value can be retrieved from the resulting value using
    # PyLong_AsVoidPtr().  If the integer is larger than LONG_MAX, a
    # positive long integer is returned.

    fn i64 PyLong_AsLong(object pylong) except? -1
    # Return a C long representation of the contents of pylong. If
    # pylong is greater than LONG_MAX, an OverflowError is raised.

    fn i64 PyLong_AsLongAndOverflow(object pylong, i32* overflow) except? -1
    # Return a C long representation of the contents of pylong. If pylong is
    # greater than LONG_MAX or less than LONG_MIN, set *overflow to 1 or -1,
    # respectively, and return -1; otherwise, set *overflow to 0. If any other
    # exception occurs (for example a TypeError or MemoryError), then -1 will
    # be returned and *overflow will be 0.
    # New in version 2.7.

    fn PY_LONG_LONG PyLong_AsLongLongAndOverflow(object pylong, i32* overflow) except? -1
    # Return a C long long representation of the contents of pylong. If pylong
    # is greater than PY_LLONG_MAX or less than PY_LLONG_MIN, set *overflow to
    # 1 or -1, respectively, and return -1; otherwise, set *overflow to 0. If
    # any other exception occurs (for example a TypeError or MemoryError), then
    # -1 will be returned and *overflow will be 0.
    # New in version 2.7.

    fn isize PyLong_AsSsize_t(object pylong) except? -1
    # Return a C Py_ssize_t representation of the contents of pylong. If pylong
    # is greater than PY_SSIZE_T_MAX, an OverflowError is raised and -1 will be
    # returned.

    fn u64 PyLong_AsUnsignedLong(object pylong) except? -1
    # Return a C unsigned long representation of the contents of
    # pylong. If pylong is greater than ULONG_MAX, an OverflowError is
    # raised.

    fn PY_LONG_LONG PyLong_AsLongLong(object pylong) except? -1
    # Return a C long long from a Python long integer. If pylong
    # cannot be represented as a long long, an OverflowError will be
    # raised.

    fn uPY_LONG_LONG PyLong_AsUnsignedLongLong(object pylong) except? -1
    # unsigned PY_LONG_LONG PyLong_AsUnsignedLongLong(object pylong)
    # Return a C unsigned long long from a Python long integer. If
    # pylong cannot be represented as an unsigned long long, an
    # OverflowError will be raised if the value is positive, or a
    # TypeError will be raised if the value is negative.

    fn u64 PyLong_AsUnsignedLongMask(object io) except? -1
    # Return a C unsigned long from a Python long integer, without
    # checking for overflow.

    fn uPY_LONG_LONG PyLong_AsUnsignedLongLongMask(object io) except? -1
    # unsigned PY_LONG_LONG PyLong_AsUnsignedLongLongMask(object io)
    # Return a C unsigned long long from a Python long integer,
    # without checking for overflow.

    fn f64 PyLong_AsDouble(object pylong) except? -1.0
    # Return a C double representation of the contents of pylong. If
    # pylong cannot be approximately represented as a double, an
    # OverflowError exception is raised and -1.0 will be returned.

    fn void* PyLong_AsVoidPtr(object pylong) except? NULL
    # Convert a Python integer or long integer pylong to a C void
    # pointer. If pylong cannot be converted, an OverflowError will be
    # raised. This is only assured to produce a usable void pointer
    # for values created with PyLong_FromVoidPtr(). For values outside
    # 0..LONG_MAX, both signed and unsigned integers are accepted.
