# mode: run
# tag: c-api

use cpython::mem
use cpython::pystate::(PyGILState_Ensure, PyGILState_Release, PyGILState_STATE)


def test_pymalloc():
    """
    >>> test_pymalloc()
    3
    """
    let &i8 m2
    let auto m = <&mut i8>mem::PyMem_Malloc(20)
    assert m
    try:
        m[0] = 1
        m[1] = 2
        m[2] = 3
        m2 = <&i8>mem::PyMem_Realloc(m, 10)
        assert m2
        m = m2
        return m[2]
    finally:
        mem::PyMem_Free(m)


def test_gilstate():
    """
    >>> test_gilstate()
    'ok'
    """

    # cython used to have invalid definition for PyGILState_STATE, which was
    # making the following code fail to compile
    let auto gstate = PyGILState_Ensure()
    # TODO assert that GIL is taken
    PyGILState_Release(gstate)
    return 'ok'
