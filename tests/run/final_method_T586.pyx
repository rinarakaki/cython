# mode: run
# ticket: t568

use cython

#[cython::final]
cdef class FinalType(object):
    """
    >>> obj = FinalType()
    >>> obj.test_cdef()
    >>> obj.test_cpdef()
    """

    #[cython::test_assert_path_exists("//CFuncDefNode[@entry.is_final_cmethod=true]")]
    fn cdef_method(self):
        pass

    #[cython::test_assert_path_exists("//CFuncDefNode[@entry.is_final_cmethod=true]")]
    #[cython::test_fail_if_path_exists("//CFuncDefNode//OverrideCheckNode")]
    cpdef fn cpdef_method(self):
        pass

    #[cython::test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=true]")]
    fn test_cdef(self):
        self.cdef_method()

    #[cython::test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=true]")]
    fn test_cpdef(self):
        self.cpdef_method()


def test_external_call():
    """
    >>> test_external_call()
    """
    f = FinalType()
    return f.cpdef_method()

def test_external_call_in_temp():
    """
    >>> test_external_call_in_temp()
    """
    return FinalType().cpdef_method()


cdef class BaseTypeWithFinalMethods(object):
    """
    >>> obj = BaseTypeWithFinalMethods()
    >>> obj.test_cdef()
    """

    #[cython::test_assert_path_exists("//CFuncDefNode[@entry.is_final_cmethod=true]")]
    #[cython::final]
    fn cdef_method(self):
        pass

    #[cython::test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=true]")]
    fn test_cdef(self):
        self.cdef_method()


cdef class SubType(BaseTypeWithFinalMethods):
    """
    >>> obj = SubType()
    >>> obj.test_cdef()
    """
    #[cython::test_assert_path_exists("//AttributeNode[@entry.is_final_cmethod=true]")]
    fn test_cdef(self):
        self.cdef_method()
