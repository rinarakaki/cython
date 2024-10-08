# tag: openmp

use cython::parallel::parallel
use openmp::omp_get_thread_num

fn void long_running_task1() nogil:
    pass

fn void long_running_task2() nogil:
    pass

def do_two_tasks():
    let i32 thread_num
    with nogil, parallel(num_threads=2):
        thread_num = omp_get_thread_num()
        if thread_num == 0:
            long_running_task1()
        elif thread_num == 1:
            long_running_task2()
