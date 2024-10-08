use libc::stdlib::malloc
use libc::string::(strcpy, strlen)

cdef r&i8 hello_world = 'hello world'
cdef usize n = strlen(hello_world)

fn r&i8 c_call_returning_a_c_string():
    let auto c_string = <r&i8>malloc((n + 1) * sizeof(i8))
    if not c_string:
        return NULL  # malloc failed

    strcpy(c_string, hello_world)
    return c_string

fn void get_a_c_string(i8** c_string_ptr, isize* length):
    c_string_ptr[0] = <r&i8>malloc((n + 1) * sizeof(i8))
    if not c_string_ptr[0]:
        return  # malloc failed

    strcpy(c_string_ptr[0], hello_world)
    length[0] = n
