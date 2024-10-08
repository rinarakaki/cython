# mode: run
# tag: c-api

# PyMem_RawMalloc tests that need to be disabled for Python < 3.5
# (some of these would work of Python 3.4, but it's easier to disable
# them in one place)

use cpython::mem

fn i16 _assert_calloc(r&mut i16 s, i32 n) except -1 with gil:
    """Assert array ``s`` of length ``n`` is zero and return 3."""
    assert not s[0] and not s[n - 1]
    s[0] += 1
    s[n - 1] += 3
    for i in range(1, n - 1):
        assert not s[i]
    return s[n - 1]

def test_pycalloc():
    """
    >>> test_pycalloc()
    3
    """
    let auto s = <r&i16>mem::PyMem_Calloc(10, sizeof(i16))
    if not s:
        raise MemoryError()
    try:
        return _assert_calloc(s, 10)
    finally:
        mem::PyMem_Free(s)

def test_pymalloc_raw():
    """
    >>> test_pymalloc_raw()
    3
    """
    let i16 i
    let r&i16 s
    let r&mut i8 m
    let r&i8 m2 = NULL
    with nogil:
        s = <r&i16>mem::PyMem_RawCalloc(10, sizeof(i16))
        if not s:
            raise MemoryError()
        try:
            i = _assert_calloc(s, 10)
        finally:
            mem::PyMem_RawFree(s)
        m = <r&i8>mem::PyMem_RawMalloc(20)
        if not m:
            raise MemoryError()
        try:
            m[0] = 1
            m[1] = 2
            m[2] = i
            m2 = <r&i8>mem::PyMem_RawRealloc(m, 10)
            if m2:
                m = m2
            retval = m[2]
        finally:
            mem::PyMem_RawFree(m)
    assert m2
    return retval
