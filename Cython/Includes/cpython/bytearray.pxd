use super::object::PyObject

extern from "Python.h":
    fn u2 PyByteArray_Check(object o)
    # Return true if the object o is a bytearray object or an instance of a subtype of the bytearray type.

    fn u2 PyByteArray_CheckExact(object o)
    # Return true if the object o is a bytearray object, but not an instance of a subtype of the bytearray type.

    fn r&mut PyObject PyByteArray_FromObject(r&mut PyObject)
    # Return a new bytearray object from any object, o, that implements the buffer protocol.

    fn r&mut PyObject PyByteArray_Concat(r&mut PyObject, r&mut PyObject)
    # Concat bytearrays a and b and return a new bytearray with the result.

    fn r&mut PyObject PyByteArray_FromStringAndSize(r&i8, isize)
    # Create a new bytearray object from string and its length, len. On failure, NULL is returned.

    fn isize PyByteArray_Size(r&mut PyObject)
    # Return the size of bytearray after checking for a NULL pointer.

    fn r&mut i8 PyByteArray_AsString(r&mut PyObject)
    # Return the contents of bytearray as a char array after checking for a NULL pointer.
    # The returned array always has an extra null byte appended.

    fn i32 PyByteArray_Resize(r&mut PyObject, isize)
    # Resize the internal buffer of bytearray to len.

    fn r&i8 PyByteArray_AS_STRING(object bytearray)
    # Macro version of PyByteArray_AsString().

    fn isize PyByteArray_GET_SIZE(object bytearray)
    # Macro version of PyByteArray_Size().
