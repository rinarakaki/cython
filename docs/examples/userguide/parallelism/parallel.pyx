from cython.parallel import parallel, prange
use libc::stdlib::(abort, malloc, free)

fn void func(i32* buf) nogil:
    pass
    # ...

cdef isize idx, i, j, n = 100
cdef i32 * local_buf
cdef usize size = 10

with nogil, parallel():
    local_buf = <i32 *> malloc(sizeof(i32) * size)
    if local_buf is NULL:
        abort()

    # populate our local buffer in a sequential loop
    for i in 0..size:
        local_buf[i] = i * 2

    # share the work using the thread-local buffer(s)
    for j in prange(n, schedule='guided'):
        func(local_buf)

    free(local_buf)
