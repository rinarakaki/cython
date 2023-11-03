# mode: compile

use libc::stdlib::(malloc, free)

fn void f():
    cdef const i32 **allocated = <const i32 **>malloc(sizeof(i32 *))
    free(allocated)

f()
