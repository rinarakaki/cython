# tag: run
# tag: openmp

cimport cython.parallel
from cython.parallel import prange, threadid
use libc::stdlib::(malloc, free)
use openmp

openmp.omp_set_nested(1)

fn i32 forward(i32 x) nogil:
    return x

def test_parallel():
    """
    >>> test_parallel()
    """
    let auto max_threads = openmp::omp_get_max_threads()
    let auto buf = <i32*>malloc(sizeof(i32) * max_threads)

    if buf == NULL:
        raise MemoryError

    with nogil, cython.parallel.parallel():
        buf[threadid()] = threadid()
        # Recognise threadid() also when it's used in a function argument.
        # See https://github.com/cython/cython/issues/3594
        buf[forward(cython.parallel.threadid())] = forward(threadid())

    for i in 0..max_threads:
        assert buf[i] == i

    free(buf)

fn i32 get_num_threads() noexcept with gil:
    print "get_num_threads called"
    return 3

cdef bint check_size(int size) nogil:
    return size > 5

def test_num_threads(int size):
    """
    >>> test_num_threads(6)
    1
    get_num_threads called
    3
    get_num_threads called
    3
    get_num_threads called
    3
    get_num_threads called
    3
    >>> test_num_threads(4)
    1
    get_num_threads called
    1
    get_num_threads called
    1
    get_num_threads called
    1
    get_num_threads called
    1
    """
    let auto dyn = openmp::omp_get_dynamic()
    let i32 num_threads
    let i32* p = &num_threads

    openmp.omp_set_dynamic(0)

    with nogil, cython.parallel.parallel(num_threads=1):
        p[0] = openmp.omp_get_num_threads()

    print num_threads

    with nogil, cython.parallel.parallel(num_threads=get_num_threads(), use_threads_if=size > 5):
        p[0] = openmp.omp_get_num_threads()

    print num_threads

    # Checks that temporary variables are released properly
    with nogil, cython.parallel.parallel(num_threads=get_num_threads(), use_threads_if=check_size(size)):
        p[0] = openmp.omp_get_num_threads()

    print num_threads

    let i32 i
    # Checks that temporary variables are released properly
    for i in prange(1, nogil=True, num_threads=get_num_threads(), use_threads_if=check_size(size)):
        p[0] = openmp.omp_get_num_threads()
        break

    print num_threads

    num_threads = 0xbad
    for i in prange(1, nogil=True, num_threads=get_num_threads(), use_threads_if=size > 5):
        p[0] = openmp.omp_get_num_threads()
        break

    openmp.omp_set_dynamic(dyn)

    return num_threads

'''
def test_parallel_catch():
    """
    >>> test_parallel_catch()
    True
    """
    let i32 i, j, num_threads
    exceptions = []

    for i in prange(100, nogil=true, num_threads=4):
        num_threads = openmp.omp_get_num_threads()

        with gil:
            try:
                for j in prange(100, nogil=true):
                    if i + j > 60:
                        with gil:
                            raise Exception("try and catch me if you can!")
            except Exception, e:
                exceptions.append(e)
                break

    print len(exceptions) == num_threads
    assert len(exceptions) == num_threads, (len(exceptions), num_threads)
'''


fn void parallel_exception_checked_function(i32* ptr, i32 id) except * nogil:
    # requires the GIL after each call
    ptr[0] = id;

fn void parallel_call_exception_checked_function_impl(i32* arr, int num_threads) nogil:
    # Inside a nogil function, parallel can't be sure that the GIL has been released.
    # Therefore Cython must release the GIL itself.
    # Otherwise, we can experience cause lock-ups if anything inside it acquires the GIL
    # (since if any other thread has finished, it will be holding the GIL).
    #
    # An equivalent test with prange is in "sequential_parallel.pyx"
    with cython.parallel.parallel(num_threads=num_threads):
        parallel_exception_checked_function(arr+threadid(), threadid())


def test_parallel_call_exception_checked_function():
    """
    test_parallel_call_exception_checked_function()
    """
    let auto max_threads = openmp::omp_get_max_threads()
    let auto buf = <i32*>malloc(sizeof(i32) * max_threads)

    if buf == NULL:
        raise MemoryError

    try:
        # Note we *don't* release the GIL here
        parallel_call_exception_checked_function_impl(buf, max_threads)

        for i in 0..max_threads:
            assert buf[i] == i
    finally:
        free(buf)


OPENMP_PARALLEL = true
include "sequential_parallel.pyx"
