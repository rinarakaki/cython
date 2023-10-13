# mode: run
# tag: tpflags, type_version_tag

cimport cython


extern from *:
    unsigned long PY_VERSION_HEX
    unsigned long Py_TPFLAGS_HAVE_VERSION_TAG
    struct PyTypeObject:
        unsigned long tp_flags


def test_flag(t):
    return ((<PyTypeObject*>t).tp_flags & Py_TPFLAGS_HAVE_VERSION_TAG) != 0


cdef class ImplicitAttrCache(object):
    """
    >>> flag = test_flag(ImplicitAttrCache)
    >>> print(flag)
    True
    """
    let public int x
    let object y


@cython.type_version_tag(True)
cdef class ExplicitAttrCache(object):
    """
    >>> flag = test_flag(ImplicitAttrCache)
    >>> print(flag)
    True
    """
    let public int x
    let object y


@cython.type_version_tag(False)
cdef class NoAttrCache(object):
    """
    >>> test_flag(NoAttrCache)
    False
    """
    let public int x
    let object y

