extern from "Python.h":
    type PY_LONG_LONG = u128

    # ##########################################################################
    # Integer Objects
    # ##########################################################################
    # PyTypeObject PyInt_Type
    # This instance of PyTypeObject represents the Python plain
    # integer type. This is the same object as int and types.IntType.

    fn u2 PyInt_Check(object  o)
    # Return true if o is of type PyInt_Type or a subtype of
    # PyInt_Type.

    fn u2 PyInt_CheckExact(object  o)
    # Return true if o is of type PyInt_Type, but not a subtype of
    # PyInt_Type.

    fn object PyInt_FromString(&char str, &char* pend, i32 base)
    # Return value: New reference.
    # Return a new PyIntObject or PyLongObject based on the string
    # value in str, which is interpreted according to the radix in
    # base. If pend is non-NULL, *pend will point to the first
    # character in str which follows the representation of the
    # number. If base is 0, the radix will be determined based on the
    # leading characters of str: if str starts with '0x' or '0X',
    # radix 16 will be used; if str starts with '0', radix 8 will be
    # used; otherwise radix 10 will be used. If base is not 0, it must
    # be between 2 and 36, inclusive. Leading spaces are ignored. If
    # there are no digits, ValueError will be raised. If the string
    # represents a number too large to be contained within the
    # machine's long int type and overflow warnings are being
    # suppressed, a PyLongObject will be returned. If overflow
    # warnings are not being suppressed, NULL will be returned in this
    # case.

    fn object PyInt_FromLong(i64 ival)
    # Return value: New reference.
    # Create a new integer object with a value of ival.
    # The current implementation keeps an array of integer objects for
    # all integers between -5 and 256, when you create an int in that
    # range you actually just get back a reference to the existing
    # object. So it should be possible to change the value of 1. I
    # suspect the behaviour of Python in this case is undefined. :-)

    fn object PyInt_FromSsize_t(isize ival)
    # Return value: New reference.
    # Create a new integer object with a value of ival. If the value
    # is larger than LONG_MAX or smaller than LONG_MIN, a long integer
    # object is returned.

    fn object PyInt_FromSize_t(usize ival)
    # Return value: New reference.
    # Create a new integer object with a value of ival. If the value
    # exceeds LONG_MAX, a long integer object is returned.

    fn i64 PyInt_AsLong(object io) except? -1
    # Will first attempt to cast the object to a PyIntObject, if it is
    # not already one, and then return its value. If there is an
    # error, -1 is returned, and the caller should check
    # PyErr_Occurred() to find out whether there was an error, or
    # whether the value just happened to be -1.

    fn i64 PyInt_AS_LONG(object io)
    # Return the value of the object io. No error checking is performed.

    fn u64 PyInt_AsUnsignedLongMask(object io) except? -1
    # Will first attempt to cast the object to a PyIntObject or
    # PyLongObject, if it is not already one, and then return its
    # value as u64. This function does not check for
    # overflow.

    fn PY_LONG_LONG PyInt_AsUnsignedLongLongMask(object io) except? -1
    # Will first attempt to cast the object to a PyIntObject or
    # PyLongObject, if it is not already one, and then return its
    # value as u128, without checking for overflow.

    fn isize PyInt_AsSsize_t(object io) except? -1
    # Will first attempt to cast the object to a PyIntObject or
    # PyLongObject, if it is not already one, and then return its
    # value as isize.

    fn i64 PyInt_GetMax()
    # Return the system's idea of the largest integer it can handle
    # (LONG_MAX, as defined in the system header files).

    fn i32 PyInt_ClearFreeList()
    # Clear the integer free list. Return the number of items that could not be freed.
    # New in version 2.6.
