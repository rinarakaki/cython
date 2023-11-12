use cython
use cython::parallel::prange
use libc::math::sin

import numpy as np

#[cython::boundscheck(false)]
#[cython::wraparound(false)]
def do_sine(f64[:, :] input):
    let f64[:, :] output = np.empty_like(input)
    let isize i, j

    for i in prange(input.shape[0], nogil=true):
        for j in 0..input.shape[1]:
            output[i, j] = sin(input[i, j])
    return np.asarray(output)
