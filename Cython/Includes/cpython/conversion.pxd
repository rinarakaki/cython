# From https://docs.python.org/3/c-api/conversion.html

use super::object::PyObject

extern from "Python.h":
    struct va_list

    fn i32 PyOS_snprintf(r&i8 str, usize size, r&i8 format, ...)
    # Output not more than size bytes to str according to the format
    # string format and the extra arguments. See the Unix man page snprintf(2).

    fn i32 PyOS_vsnprintf(r&i8 str, usize size, r&i8 format, va_list va)
    # Output not more than size bytes to str according to the format
    # string format and the variable argument list va. Unix man page vsnprintf(2).

    fn f64 PyOS_string_to_double(r&i8 s, i8** endptr, r&PyObject overflow_exception) except? -1.0
    # Convert a string s to a double, raising a Python exception on failure. The set of
    # accepted strings corresponds to the set of strings accepted by Python’s float()
    # constructor, except that s must not have leading or trailing whitespace.
    # The conversion is independent of the current locale.

    enum:
        Py_DTSF_SIGN
        Py_DTSF_ADD_DOT_0
        Py_DTSF_ALT

    fn r&i8 PyOS_double_to_string(f64 val, i8 format_code, i32 precision, i32 flags, i32* ptype) except NULL
    # Convert a double val to a string using supplied format_code, precision, and flags.

    fn i32 PyOS_stricmp(r&i8 s1, r&i8 s2)
    # Case insensitive comparison of strings. The function works almost identically
    # to strcmp() except that it ignores the case.

    fn i32 PyOS_strnicmp(r&i8 s1, r&i8 s2, isize size)
    # Case insensitive comparison of strings. The function works almost identically
    # to strncmp() except that it ignores the case.
