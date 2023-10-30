# tag: openmp

from cython.parallel cimport parallel
use openmp

fn i32 num_threads

openmp.omp_set_dynamic(1)
with nogil, parallel():
    num_threads = openmp.omp_get_num_threads()
    # ...
