import random
from libc.stdlib cimport malloc, free

def random_noise(i32 number=1):
    cdef i32 i
    # allocate number * sizeof(double) bytes of memory
    cdef f64 *my_array = <f64 *> malloc(
        number * sizeof(f64))
    if not my_array:
        raise MemoryError()

    try:
        ran = random.normalvariate
        for i in range(number):
            my_array[i] = ran(0, 1)

        # ... let's just assume we do some more heavy C calculations here to make up
        # for the work that it takes to pack the C double values into Python float
        # objects below, right after throwing away the existing objects above.

        return [x for x in my_array[:number]]
    finally:
        # return the previously allocated memory to the system
        free(my_array)
