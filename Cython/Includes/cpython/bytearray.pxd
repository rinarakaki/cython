from .object cimport PyObject

extern from "Python.h":
    fn bint PyByteArray_Check(object o)
    # Return true if the object o is a bytearray object or an instance of a subtype of the bytearray type.

    fn bint PyByteArray_CheckExact(object o)
    # Return true if the object o is a bytearray object, but not an instance of a subtype of the bytearray type.

    fn bytearray PyByteArray_FromObject(object o)
    # Return a new bytearray object from any object, o, that implements the buffer protocol.

    fn bytearray PyByteArray_FromStringAndSize(char *string, isize len)
    # Create a new bytearray object from string and its length, len. On failure, NULL is returned.

    fn bytearray PyByteArray_Concat(object a, object b)
    # Concat bytearrays a and b and return a new bytearray with the result.

    fn isize PyByteArray_Size(object bytearray)
    # Return the size of bytearray after checking for a NULL pointer.

    fn char* PyByteArray_AsString(object bytearray)
    # Return the contents of bytearray as a char array after checking for a NULL pointer.
    # The returned array always has an extra null byte appended.

    fn i32 PyByteArray_Resize(object bytearray, isize len)
    # Resize the internal buffer of bytearray to len.

    fn char* PyByteArray_AS_STRING(object bytearray)
    # Macro version of PyByteArray_AsString().

    fn isize PyByteArray_GET_SIZE(object bytearray)
    # Macro version of PyByteArray_Size().
