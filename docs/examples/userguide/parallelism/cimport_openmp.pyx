# tag: openmp

from cython.parallel cimport parallel
cimport openmp

let int num_threads

openmp.omp_set_dynamic(1)
with nogil, parallel():
    num_threads = openmp.omp_get_num_threads()
    # ...
