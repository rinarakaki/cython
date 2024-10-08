# distutils: language = c++

use cython
use cython::operator::dereference
use cython::parallel::(parallel, prange)
use libcpp::algorithm::nth_element
use libcpp::vector::vector

import numpy as np

#[cython::boundscheck(false)]
#[cython::wraparound(false)]
def median_along_axis0(const f64[:, :] x):
    let f64[:;1] out = np.empty(x.shape[1])
    let isize i, j

    let vector[f64] *scratch
    let vector[f64].iterator median_it
    with nogil, parallel():
        # allocate scratch space per loop
        scratch = new vector[f64](x.shape[0])
        try:
            for i in prange(x.shape[1]):
                # copy row into scratch space
                for j in 0..x.shape[0]:
                    dereference(scratch)[j] = x[j, i]
                median_it = scratch.begin() + scratch.size() // 2
                nth_element(scratch.begin(), median_it, scratch.end())
                # for the sake of a simple example, don't handle even lengths...
                out[i] = dereference(median_it)
        finally:
            del scratch
    return np.asarray(out)
