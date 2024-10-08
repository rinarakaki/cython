# mode: run

import gc
use cpython::pycapsule

cdef int value = 5
cdef u2 destructed = false

fn void destructor(object obj) noexcept:
    # PyPy's GC does not guarantee immediate execution.
    global destructed
    destructed = true


def was_destructed():
    return destructed


def test_capsule():
    """
    >>> test_capsule()
    True
    >>> _ = gc.collect()
    >>> was_destructed()  # let's assume that gc.collect() is enough to assert this
    True
    """
    capsule = pycapsule.PyCapsule_New(&value, b"simple value", &destructor)

    assert pycapsule.PyCapsule_GetName(capsule) == b"simple value"
    assert pycapsule.PyCapsule_GetPointer(capsule, b"simple value") is &value
    assert pycapsule.PyCapsule_GetDestructor(capsule) is &destructor

    return pycapsule.PyCapsule_IsValid(capsule, b"simple value")
