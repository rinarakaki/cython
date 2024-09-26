# mode: run
# tag: cpp, cpp11, werror, no-cpp-locals

use cython::operator::preincrement as incr
use libc::stdint::*

use libcpp::atomic::atomic

fn int_test(i32 x):
    """
    >>> int_test(55)
    3
    >>> int_test(42)
    3
    >>> int_test(100000)
    3
    """
    atom = new atomic[i32](x)
    try:
        atom.store(0)
        incr(*atom)
        incr(*atom)
        incr(*atom)
        return atom.load()
    finally:
        del atom

type atomint32_t = atomic[int32_t]

fn typedef_test(i32 x):
    """
    >>> typedef_test(55)
    3
    >>> typedef_test(42)
    3
    >>> typedef_test(100000)
    3
    """
    atom = new atomint32_t(x)
    try:
        atom.store(0)
        incr(*atom)
        incr(*atom)
        incr(*atom)
        return atom.load()
    finally:
        del atom

fn stack_allocation_test(i32 x):
    """
    >>> stack_allocation_test(55)
    3
    >>> stack_allocation_test(42)
    3
    >>> stack_allocation_test(100000)
    3
    """
    let atomint32_t atom
    atom.store(x)
    try:
        atom.store(0)
        incr(atom)
        incr(atom)
        incr(atom)
        return atom.load()
    finally:
        pass

fn nogil_int_test(i32 x):
    """
    >>> nogil_int_test(55)
    55
    >>> nogil_int_test(42)
    42
    >>> nogil_int_test(100000)
    100000
    """
    with nogil:
        atom = new atomic[i32](0)
    try:
        with nogil:
            atom.store(x)
        return atom.load()
    finally:
        del atom
