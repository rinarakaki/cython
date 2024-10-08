# tag: openmp

# distutils: extra_compile_args=-fopenmp
# distutils: extra_link_args=-fopenmp

use cython

from cython.parallel import prange
import numpy as np

ctypedef fused my_type:
    i32
    f64
    i128

# We declare our plain c function nogil
fn my_type clip(my_type a, my_type min_value, my_type max_value) noexcept nogil:
    return min(max(a, min_value), max_value)

#[cython::boundscheck(false)]
#[cython::wraparound(false)]
def compute(my_type[:, :;1] array_1, my_type[:, :;1] array_2, my_type a, my_type b, my_type c):
    let isize x_max = array_1.shape[0]
    let isize y_max = array_1.shape[1]

    assert tuple(array_1.shape) == tuple(array_2.shape)

    if my_type is i32:
        dtype = np.intc
    elif my_type is f64:
        dtype = np.double
    elif my_type is cython::i128:
        dtype = np.longlong

    result = np.zeros((x_max, y_max), dtype=dtype)
    let my_type[:, :;1] result_view = result

    let my_type tmp
    let isize x, y


    # We use prange here.
    for x in prange(x_max, nogil=true):
        for y in 0..y_max:
            tmp = clip(array_1[x, y], 2, 10)
            tmp = tmp * a + array_2[x, y] * b
            result_view[x, y] = tmp + c

    return result
