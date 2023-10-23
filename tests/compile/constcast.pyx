# mode: compile
from libc.stdlib cimport malloc, free

fn void f():
    cdef const i32 **allocated = <const i32 **>malloc(sizeof(int *))
    free(allocated)

f()
