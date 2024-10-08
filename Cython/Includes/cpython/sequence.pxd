use super::object::PyObject

extern from "Python.h":
    # ##########################################################################
    # 6.3 Sequence Protocol
    # ##########################################################################

    fn u2 PySequence_Check(object o)
    # Return 1 if the object provides sequence protocol, and 0
    # otherwise. This function always succeeds.

    fn isize PySequence_Size(object o) except -1
    # Returns the number of objects in sequence o on success, and -1
    # on failure. For objects that do not provide sequence protocol,
    # this is equivalent to the Python expression "len(o)".

    fn isize PySequence_Length(object o) except -1
    # Alternate name for PySequence_Size().

    fn object PySequence_Concat(object o1, object o2)
    # Return value: New reference.
    # Return the concatenation of o1 and o2 on success, and NULL on
    # failure. This is the equivalent of the Python expression "o1 +
    # o2".

    fn object PySequence_Repeat(object o, isize count)
    # Return value: New reference.
    # Return the result of repeating sequence object o count times, or
    # NULL on failure. This is the equivalent of the Python expression
    # "o * count".

    fn object PySequence_InPlaceConcat(object o1, object o2)
    # Return value: New reference.
    # Return the concatenation of o1 and o2 on success, and NULL on
    # failure. The operation is done in-place when o1 supports
    # it. This is the equivalent of the Python expression "o1 += o2".

    fn object PySequence_InPlaceRepeat(object o, isize count)
    # Return value: New reference.
    # Return the result of repeating sequence object o count times, or
    # NULL on failure. The operation is done in-place when o supports
    # it. This is the equivalent of the Python expression "o *=
    # count".

    fn object PySequence_GetItem(object o, isize i)
    # Return value: New reference.
    # Return the ith element of o, or NULL on failure. This is the
    # equivalent of the Python expression "o[i]".

    fn object PySequence_GetSlice(object o, isize i1, isize i2)
    # Return value: New reference.
    # Return the slice of sequence object o between i1 and i2, or NULL
    # on failure. This is the equivalent of the Python expression
    # "o[i1:i2]".

    fn i32 PySequence_SetItem(object o, isize i, object v) except -1
    # Assign object v to the ith element of o. Returns -1 on
    # failure. This is the equivalent of the Python statement "o[i] =
    # v". This function does not steal a reference to v.

    fn i32 PySequence_DelItem(object o, isize i) except -1
    # Delete the ith element of object o. Returns -1 on failure. This
    # is the equivalent of the Python statement "del o[i]".

    fn i32 PySequence_SetSlice(object o, isize i1, isize i2, object v) except -1
    # Assign the sequence object v to the slice in sequence object o
    # from i1 to i2. This is the equivalent of the Python statement
    # "o[i1:i2] = v".

    fn i32 PySequence_DelSlice(object o, isize i1, isize i2) except -1
    # Delete the slice in sequence object o from i1 to i2. Returns -1
    # on failure. This is the equivalent of the Python statement "del
    # o[i1:i2]".

    fn i32 PySequence_Count(object o, object value) except -1
    # Return the number of occurrences of value in o, that is, return
    # the number of keys for which o[key] == value. On failure, return
    # -1. This is equivalent to the Python expression
    # "o.count(value)".

    fn i32 PySequence_Contains(object o, object value) except -1
    # Determine if o contains value. If an item in o is equal to
    # value, return 1, otherwise return 0. On error, return -1. This
    # is equivalent to the Python expression "value in o".

    fn isize PySequence_Index(object o, object value) except -1
    # Return the first index i for which o[i] == value. On error,
    # return -1. This is equivalent to the Python expression
    # "o.index(value)".

    fn object PySequence_List(object o)
    # Return value: New reference.
    # Return a list object with the same contents as the arbitrary
    # sequence o. The returned list is guaranteed to be new.

    fn object PySequence_Tuple(object o)
    # Return value: New reference.
    # Return a tuple object with the same contents as the arbitrary
    # sequence o or NULL on failure. If o is a tuple, a new reference
    # will be returned, otherwise a tuple will be constructed with the
    # appropriate contents. This is equivalent to the Python
    # expression "tuple(o)".

    fn object PySequence_Fast(object o, r&i8 m)
    # Return value: New reference.
    # Returns the sequence o as a tuple, unless it is already a tuple
    # or list, in which case o is returned. Use
    # PySequence_Fast_GET_ITEM() to access the members of the
    # result. Returns NULL on failure. If the object is not a
    # sequence, raises TypeError with m as the message text.

    fn PyObject* PySequence_Fast_GET_ITEM(object o, isize i)
    # Return value: Borrowed reference.
    # Return the ith element of o, assuming that o was returned by
    # PySequence_Fast(), o is not NULL, and that i is within bounds.

    fn PyObject** PySequence_Fast_ITEMS(object o)
    # Return the underlying array of PyObject pointers. Assumes that o
    # was returned by PySequence_Fast() and o is not NULL.

    fn object PySequence_ITEM(object o, isize i)
    # Return value: New reference.
    # Return the ith element of o or NULL on failure. Macro form of
    # PySequence_GetItem() but without checking that
    # PySequence_Check(o) is true and without adjustment for negative
    # indices.

    fn isize PySequence_Fast_GET_SIZE(object o)
    # Returns the length of o, assuming that o was returned by
    # PySequence_Fast() and that o is not NULL. The size can also be
    # gotten by calling PySequence_Size() on o, but
    # PySequence_Fast_GET_SIZE() is faster because it can assume o is
    # a list or tuple.
