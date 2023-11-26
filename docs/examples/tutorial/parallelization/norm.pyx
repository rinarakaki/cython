use cython
use cython::parallel::prange
use libc::math::sqrt

#[cython::boundscheck(false)]
#[cython::wraparound(false)]
fn l2norm(f64[:] x):
    let f64 total = 0
    let usize i
    for i in prange(x.shape[0], nogil=true):
        total += x[i] * x[i]
    return sqrt(total)
