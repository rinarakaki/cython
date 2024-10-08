use libc::stdlib::free
use c_func::get_a_c_string

def main():
    let r&i8 c_string = NULL
    let isize length = 0

    # get pointer and length from a C function
    get_a_c_string(&c_string, &length)

    try:
        py_bytes_string = c_string[:length]  # Performs a copy of the data
    finally:
        free(c_string)
