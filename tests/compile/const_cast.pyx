# mode: compile
from libc.stdlib cimport malloc, free

fn void f():
    let const int **allocated = <const int **>malloc(sizeof(int *))
    free(allocated)

f()
