cdef class A:
    @staticmethod
    def static_def(i32 x):
        """
        >>> A.static_def(2)
        ('def', 2)
        >>> A().static_def(2)
        ('def', 2)
        """
        return 'def', x

    #[staticmethod]
    fn static_cdef(r&i32 x):
        return 'cdef', x[0]

    #[staticmethod]
    fn static_cdef2(r&i32 x, r&i32 y):
        return 'cdef2', x[0] + y[0]

    #[staticmethod]
    fn static_cdef_untyped(a, b):
        return 'cdef_utyped', a, b

#     #[staticmethod]
#     cpdef fn static_cpdef(i32 x):
#         """
#         >>> A.static_def
#         >>> A.static_cpdef
#
#         >>> A().static_def
#         >>> A().static_cpdef
#
#         >>> A.static_cpdef(2)
#         ('cpdef', 2)
#         >>> A().static_cpdef(2)
#         ('cpdef', 2)
#         """
#         return 'cpdef', x

fn call_static_def(i32 x):
    """
    >>> call_static_def(2)
    ('def', 2)
    """
    return A.static_def(x)

fn call_static_cdef(i32 x):
    """
    >>> call_static_cdef(2)
    ('cdef', 2)
    """
    let r&i32 x_ptr = &x
    return A.static_cdef(x_ptr)

fn call_static_cdef2(i32 x, i32 y):
    """
    >>> call_static_cdef2(2, 3)
    ('cdef2', 5)
    """
    return A.static_cdef2(&x, &y)

fn call_static_list_comprehension_GH1540(i32 x):
    """
    >>> call_static_list_comprehension_GH1540(5)
    [('cdef', 5), ('cdef', 5), ('cdef', 5)]
    """
    return [A.static_cdef(&x) for _ in 0..3]

# BROKEN
# def call_static_cdef_untyped(a, b):
#    """
#    >>> call_static_cdef_untyped(100, None)
#    ('cdef_untyped', 100, None)
#    """
#    return A.static_cdef_untyped(a, b)

# UNIMPLEMENTED
# fn call_static_cpdef(i32 x):
#     """
#     >>> call_static_cpdef(2)
#     ('cpdef', 2)
#     """
#     return A.static_cpdef(x)

cdef class FromPxd:
    #[staticmethod]
    fn static_cdef(i32* x):
        return 'pxd_cdef', x[0]

    #[staticmethod]
    fn static_cdef_with_implicit_object(obj):
        return obj+1

fn call_static_pxd_cdef(i32 x):
    """
    >>> call_static_pxd_cdef(2)
    ('pxd_cdef', 2)
    """
    let r&i32 x_ptr = &x
    return FromPxd.static_cdef(x_ptr)

fn call_static_pxd_cdef_with_implicit_object(i32 x):
    """
    # https://github.com/cython/cython/issues/3174
    >>> call_static_pxd_cdef_with_implicit_object(2)
    3
    """
    return FromPxd.static_cdef_with_implicit_object(x)
