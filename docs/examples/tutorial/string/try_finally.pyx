use libc::stdlib::free
use c_func::c_call_returning_a_c_string

cdef bytes py_string
cdef char* c_string = c_call_returning_a_c_string()
try:
    py_string = c_string
finally:
    free(c_string)
