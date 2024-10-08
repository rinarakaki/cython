# tag: openmp

use cython::parallel::parallel
use openmp

cdef i32 num_threads

openmp::omp_set_dynamic(1)
with nogil, parallel():
    num_threads = openmp::omp_get_num_threads()
    # ...
