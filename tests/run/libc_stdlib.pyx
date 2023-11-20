# mode: run

use libc::stdlib::(abs as c_int_abs, qsort as libc_qsort)

def libc_int_abs(i32 x):
    """
    >>> libc_int_abs(5)
    5
    >>> libc_int_abs(-5)
    5
    """
    return c_int_abs(x)

fn i32 gt(r&void v1, r&void v2) noexcept nogil:
    return ((<r&mut i32>v1)[0] - (<r&mut i32>v2)[0])

fn i32 lt(r&void v1, r&void v2) noexcept nogil:
    return - gt(v1, v2)

def qsort(values, direction='lt'):
    """
    >>> data = [1, 9, 3, 2, 5]
    >>> qsort(data, 'gt')
    [1, 2, 3, 5, 9]
    >>> qsort(data, 'lt')
    [9, 5, 3, 2, 1]
    """
    let i32[5] carray = values[:5]
    libc_qsort(carray, 5, sizeof(i32), lt if direction == 'lt' else gt)
    return carray
