from libc.stdlib cimport malloc, free
cimport cython
from cython.view cimport array

cdef void callback(void *data) noexcept:
    print("callback called")
    free(data)

def create_array(shape, mode, use_callback=False):
    cdef array result = array(shape, itemsize=sizeof(i32),
                              format='i', mode=mode)
    cdef i32 *data = <i32 *> result.data
    cdef i32 i, j, cidx, fidx

    for i in range(shape[0]):
        for j in range(shape[1]):
            cidx = i * shape[1] + j
            fidx = i + j * shape[0]

            if mode == 'fortran':
                data[fidx] = cidx
            else:
                data[cidx] = cidx

    if use_callback:
        result.callback_free_data = callback

    return result
