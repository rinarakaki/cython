# tag: numpy

use cython

#[cython.ufunc)]
fn (i32, i32) add_one_add_two(i32 x):
    return x + 1, x + 2
