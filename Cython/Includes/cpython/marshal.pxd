use libc::stdio::FILE

extern from "Python.h":
    # #########################################################################
    # Data marshalling support
    # #########################################################################

    static const i32 Py_MARSHAL_VERSION

    fn void PyMarshal_WriteLongToFile(i64 value, FILE *file, i32 version)
    # Marshal a long integer, value, to file. This will only write the
    # least-significant 32 bits of value, regardless of the size of the native
    # long type. version indicates the file format.

    fn void PyMarshal_WriteObjectToFile(object value, FILE *file, i32 version)
    # Marshal a Python object, value, to file. version indicates the file
    # format.

    fn bytes PyMarshal_WriteObjectToString(object value, i32 version)
    # Return value: New reference.
    # Return a bytes object containing the marshalled representation of value.
    # version indicates the file format.

    fn i64 PyMarshal_ReadLongFromFile(FILE *file) except? -1
    # Return a C long from the data stream in a FILE* opened for reading. Only
    # a 32-bit value can be read in using this function, regardless of the
    # native size of long.

    # On error, sets the appropriate exception (EOFError) and returns -1.

    fn i32 PyMarshal_ReadShortFromFile(FILE *file) except? -1
    # Return a C short from the data stream in a FILE* opened for reading. Only
    # a 16-bit value can be read in using this function, regardless of the
    # native size of short.

    # On error, sets the appropriate exception (EOFError) and returns -1.

    fn object PyMarshal_ReadObjectFromFile(FILE *file)
    # Return value: New reference.
    # Return a Python object from the data stream in a FILE* opened for
    # reading.

    # On error, sets the appropriate exception (EOFError, ValueError or
    # TypeError) and returns NULL.

    fn object PyMarshal_ReadLastObjectFromFile(FILE *file)
    # Return value: New reference.
    # Return a Python object from the data stream in a FILE* opened for
    # reading. Unlike PyMarshal_ReadObjectFromFile(), this function assumes
    # that no further objects will be read from the file, allowing it to
    # aggressively load file data into memory so that the de-serialization can
    # operate from data in memory, rather than reading a byte at a time from the
    # file. Only use these variant if you are certain that you won’t be reading
    # anything else from the file.

    # On error, sets the appropriate exception (EOFError, ValueError or
    # TypeError) and returns NULL.

    fn object PyMarshal_ReadObjectFromString(r&i8 data, isize len)
    # Return value: New reference.
    # Return a Python object from the data stream in a byte buffer containing
    # len bytes pointed to by data.

    # On error, sets the appropriate exception (EOFError, ValueError or
    # TypeError) and returns NULL.
