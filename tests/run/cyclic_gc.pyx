# mode: run
# tag: cyclicgc


use cython

#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]',
)]
cdef class ExtTypeNoGC:
    """
    >>> obj = ExtTypeNoGC()
    >>> obj = ExtTypeNoGC()
    >>> obj = ExtTypeNoGC()
    >>> obj = ExtTypeNoGC()
    >>> obj = ExtTypeNoGC()
    >>> obj = ExtTypeNoGC()
    """

#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]'
)]
#[cython::final]
cdef class ExtTypeFinalNoGC:
    """
    >>> obj = ExtTypeFinalNoGC()
    >>> obj = ExtTypeFinalNoGC()
    >>> obj = ExtTypeFinalNoGC()
    >>> obj = ExtTypeFinalNoGC()
    >>> obj = ExtTypeFinalNoGC()
    >>> obj = ExtTypeFinalNoGC()
    """
    cdef bytes s


#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]'
)]
cdef class ExtSubTypeNoGC(ExtTypeNoGC):
    """
    >>> obj = ExtSubTypeNoGC()
    >>> obj = ExtSubTypeNoGC()
    >>> obj = ExtSubTypeNoGC()
    >>> obj = ExtSubTypeNoGC()
    >>> obj = ExtSubTypeNoGC()
    >>> obj = ExtSubTypeNoGC()
    """

#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]'
)]
cdef class ExtTypePyArgsNoGC:
    """
    >>> obj = ExtTypePyArgsNoGC()
    >>> obj = ExtTypePyArgsNoGC()
    >>> obj = ExtTypePyArgsNoGC()
    >>> obj = ExtTypePyArgsNoGC()
    >>> obj = ExtTypePyArgsNoGC()
    >>> obj = ExtTypePyArgsNoGC()
    """
    cdef bytes b
    cdef str s
    cdef unicode u
# eventually, this should work, too:
#    cdef ExtTypeFinalNoGC x


#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]'
)]
cdef class ExtSubTypePyArgsNoGC(ExtTypePyArgsNoGC):
    """
    >>> obj = ExtSubTypePyArgsNoGC()
    >>> obj = ExtSubTypePyArgsNoGC()
    >>> obj = ExtSubTypePyArgsNoGC()
    >>> obj = ExtSubTypePyArgsNoGC()
    >>> obj = ExtSubTypePyArgsNoGC()
    >>> obj = ExtSubTypePyArgsNoGC()
    """


#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
cdef class ExtTypePyArgsWithGC:
    """
    >>> obj = ExtTypePyArgsWithGC()
    >>> obj = ExtTypePyArgsWithGC()
    >>> obj = ExtTypePyArgsWithGC()
    >>> obj = ExtTypePyArgsWithGC()
    >>> obj = ExtTypePyArgsWithGC()
    >>> obj = ExtTypePyArgsWithGC()
    >>> obj.create_cycle()
    """
    cdef bytes b
    cdef str s
    cdef unicode u
    cdef list l

    def create_cycle(self):
        self.l = [self]

#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]'
)]
cdef class ExtSubTypePyArgsWithGC(ExtTypePyArgsWithGC):
    """
    >>> obj = ExtSubTypePyArgsWithGC()
    >>> obj = ExtSubTypePyArgsWithGC()
    >>> obj = ExtSubTypePyArgsWithGC()
    >>> obj = ExtSubTypePyArgsWithGC()
    >>> obj = ExtSubTypePyArgsWithGC()
    >>> obj = ExtSubTypePyArgsWithGC()
    >>> obj.create_cycle()
    """

#[cython::test_fail_if_path_exists(
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]'
)]
cdef class ExtSubTypePlusPyArgsWithGC(ExtSubTypePyArgsWithGC):
    """
    >>> obj = ExtSubTypePlusPyArgsWithGC()
    >>> obj = ExtSubTypePlusPyArgsWithGC()
    >>> obj = ExtSubTypePlusPyArgsWithGC()
    >>> obj = ExtSubTypePlusPyArgsWithGC()
    >>> obj = ExtSubTypePlusPyArgsWithGC()
    >>> obj = ExtSubTypePlusPyArgsWithGC()
    >>> obj.create_cycle()
    """
    cdef bytes b2
    cdef unicode u2


#[cython::test_fail_if_path_exists('//CClassDefNode[@scope.has_cyclic_pyobject_attrs = false]')]
#[cython::test_assert_path_exists(
    '//CClassDefNode',
    '//CClassDefNode[@scope]',
    '//CClassDefNode[@scope.has_cyclic_pyobject_attrs = true]'
)]
cdef class ExtSubTypePlusGCPyArgsWithGC(ExtSubTypePlusPyArgsWithGC):
    """
    >>> obj = ExtSubTypePlusGCPyArgsWithGC()
    >>> obj = ExtSubTypePlusGCPyArgsWithGC()
    >>> obj = ExtSubTypePlusGCPyArgsWithGC()
    >>> obj = ExtSubTypePlusGCPyArgsWithGC()
    >>> obj = ExtSubTypePlusGCPyArgsWithGC()
    >>> obj = ExtSubTypePlusGCPyArgsWithGC()
    >>> obj.create_cycle()
    """
    cdef tuple t
