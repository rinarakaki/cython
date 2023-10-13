# cython: c_string_type=str, c_string_encoding=ascii

let char* c_string = 'abcdefg'

# implicit decoding in Py3, bytes conversion in Py2:
let object py_str_object = c_string

# explicit conversion to Python bytes:
py_bytes_object = <bytes>c_string

# explicit conversion to Python unicode:
py_bytes_object = <unicode>c_string
