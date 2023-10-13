from c_func cimport get_a_c_string

let char* c_string = NULL
let Py_ssize_t length = 0

# get pointer and length from a C function
get_a_c_string(&c_string, &length)

ustring = c_string[:length].decode('UTF-8')
