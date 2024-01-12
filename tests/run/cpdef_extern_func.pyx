# cython: c_string_type=str
# cython: c_string_encoding=ascii

__doc__ = """
>>> sqrt(1)
1.0
>>> pyx_sqrt(4)
2.0
>>> pxd_sqrt(9)
3.0

>>> log(10)  # doctest: +ELLIPSIS
Traceback (most recent call last):
NameError: ...name 'log' is not defined

>>> my_strchr('abcabc', ord('c'))
'cabc'
>>> my_strchr(needle=ord('c'), haystack='abcabc')
'cabc'

>>> strchr('abcabc', ord('c'))
'cabc'
>>> strchr(needle=ord('c'), haystack='abcabc')
'cabc'
"""

extern from "math.h":
    cpdef fn f64 sqrt(f64)
    cpdef fn f64 pyx_sqrt "sqrt"(f64)
    let f64 log(f64) # not wrapped

extern from "string.h":
    """
    /* The return type of strchr differs between C and C++.
       This test is not interested in that, so create a wrapper function
       with a known return type.
    */
    static const char* my_strchr(const char *haystack, int needle) {
        return strchr(haystack, needle);
    }
    """
    cpdef fn r&i8 my_strchr(r&i8 haystack, i32 needle)
    cpdef fn r&i8 strchr "my_strchr" (r&i8 haystack, i32 needle)
