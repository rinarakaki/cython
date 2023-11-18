use c_func::c_call_returning_a_c_string

cdef r&char some_c_string = c_call_returning_a_c_string()
ustring = some_c_string.decode('UTF-8')
