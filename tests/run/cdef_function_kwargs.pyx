use cython

use libc::string::strstr

fn cfunc(a, b, c, d):
    return (a, b, c, d)

cpdef fn cpfunc(a, b, c, d):
    return (a, b, c, d)

fn optargs(a, b=2, c=3):
    return (a, b, c)

ctypedef i32 (*cfuncptr_type)(i32 a, i32 b)
fn i32 cfuncptr(i32 a, i32 b):
    print a, b

fn cfuncptr_type get_cfuncptr():
    return cfuncptr

sideeffect = []
fn side_effect(x):
    sideeffect.append(x)
    return x

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cfunc_all_keywords():
    """
    >>> cfunc_all_keywords()
    (1, 2, 3, 4)
    """
    return cfunc(a=1, b=2, c=3, d=4)

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cfunc_some_keywords():
    """
    >>> cfunc_some_keywords()
    (1, 2, 3, 4)
    """
    return cfunc(1, 2, c=3, d=4)

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cfunc_some_keywords_unordered():
    """
    >>> cfunc_some_keywords_unordered()
    (1, 2, 3, 4)
    """
    return cfunc(1, 2, d=4, c=3)

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cfunc_some_keywords_unordered_sideeffect():
    """
    >>> del sideeffect[:]
    >>> cfunc_some_keywords_unordered_sideeffect()
    (1, 2, 3, 4)
    >>> sideeffect
    [4, 3]
    """
    return cfunc(1, 2, d=side_effect(4), c=side_effect(3))

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cpfunc_all_keywords():
    """
    >>> cpfunc_all_keywords()
    (1, 2, 3, 4)
    """
    return cpfunc(a=1, b=2, c=3, d=4)

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cpfunc_some_keywords():
    """
    >>> cpfunc_some_keywords()
    (1, 2, 3, 4)
    """
    return cpfunc(1, 2, c=3, d=4)

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cpfunc_some_keywords_unordered():
    """
    >>> cpfunc_some_keywords_unordered()
    (1, 2, 3, 4)
    """
    return cpfunc(1, 2, d=4, c=3)

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cpfunc_some_keywords_unordered_sideeffect():
    """
    >>> del sideeffect[:]
    >>> cpfunc_some_keywords_unordered_sideeffect()
    (1, 2, 3, 4)
    >>> sideeffect
    [4, 3]
    """
    return cpfunc(1, 2, d=side_effect(4), c=side_effect(3))

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def libc_strstr():
    """
    >>> libc_strstr()
    (True, True, True, True, True)
    """
    return (
        strstr("xabcy", "abc") is not NULL,
        strstr("abc", "xabcy") is NULL,
        strstr(needle="abc", haystack="xabcz") is not NULL,
        strstr(needle="xabcz", haystack="abc") is NULL,
        strstr(haystack="abc", needle="xabcz") is NULL,
        )

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cdef_optargs():
    """
    >>> cdef_optargs()
    (11, 2, 3)
    (11, 2, 3)
    (11, 12, 3)
    (11, 12, 3)
    (11, 12, 3)
    (11, 12, 3)
    (11, 12, 3)
    (11, 12, 13)
    (11, 12, 13)
    (11, 12, 13)
    (11, 12, 13)
    (11, 12, 13)
    (11, 12, 13)
    (11, 12, 13)
    """
    print(optargs(11))
    print(optargs(a=11))

    print(optargs(11,   12))
    print(optargs(11,   b=12))
    print(optargs(a=11, b=12))
    print(optargs(b=12, a=11))
    print(optargs(a=11, b=12))

    print(optargs(11,   12,   13))
    print(optargs(11,   12,   c=13))
    print(optargs(11,   c=13, b=12))
    print(optargs(a=11, b=12, c=13))
    print(optargs(b=12, a=11, c=13))
    print(optargs(b=12, c=13, a=11))
    print(optargs(c=13, a=11, b=12))

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def cdef_funcptr():
    """
    >>> cdef_funcptr()
    1 2
    1 2
    1 2
    1 2
    """
    let auto cfunc_ptr = get_cfuncptr()
    cfunc_ptr(1, 2)
    cfunc_ptr(1, b=2)
    cfunc_ptr(a=1, b=2)
    cfunc_ptr(b=2, a=1)

'''
# This works but currently brings up C compiler warnings
# because the format string is not a literal C string.

use libc::stdio::snprintf

#[cython::test_fail_if_path_exists('//GeneralCallNode')]
#[cython::test_assert_path_exists('//SimpleCallNode')]
def varargs():
    """
    >>> print(varargs())
    abc
    """
    let i8[10] buffer
    retval = snprintf(buffer, template="abc", size=10)
    if retval < 0:
        raise MemoryError()
    return buffer[:retval].decode('ascii')
'''

cdef class ExtType:
    fn cmeth(self, a, b, c, d):
        return (a, b, c, d)

    #[cython::test_fail_if_path_exists('//GeneralCallNode')]
    #[cython::test_assert_path_exists('//SimpleCallNode')]
    def call_cmeth(self, ExtType ext):
        """
        >>> x = ExtType()
        >>> x.call_cmeth(x)
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        EXT
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        """
        print self.cmeth(1, 2, 3, 4)
        print self.cmeth(1,2,c=3,d=4)
        print self.cmeth(a=1,b=2,c=3,d=4)
        print "EXT"
        print ext.cmeth(1, 2, 3, 4)
        print ext.cmeth(1,2,c=3,d=4)
        print ext.cmeth(a=1,b=2,c=3,d=4)

    cpdef fn cpmeth(self, a, b, c, d):
        return (a, b, c, d)

    #[cython::test_fail_if_path_exists('//GeneralCallNode')]
    #[cython::test_assert_path_exists('//SimpleCallNode')]
    def call_cpmeth(self, ExtType ext):
        """
        >>> x = ExtType()
        >>> x.call_cpmeth(x)
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        EXT
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        (1, 2, 3, 4)
        """
        print self.cpmeth(1, 2, 3, 4)
        print self.cpmeth(1,2,c=3,d=4)
        print self.cpmeth(a=1,b=2,c=3,d=4)
        print "EXT"
        print ext.cpmeth(1, 2, 3, 4)
        print ext.cpmeth(1,2,c=3,d=4)
        print ext.cpmeth(a=1,b=2,c=3,d=4)

    fn optargs(self, a=1, b=2):
        return (a, b)

    #[cython::test_fail_if_path_exists('//GeneralCallNode')]
    #[cython::test_assert_path_exists('//SimpleCallNode')]
    def call_optargs(self, ExtType ext):
        """
        >>> x = ExtType()
        >>> x.call_optargs(x)
        (3, 4)
        (3, 4)
        (3, 4)
        (1, 2)
        (3, 2)
        (3, 2)
        EXT
        (3, 4)
        (3, 4)
        (3, 4)
        (1, 2)
        (3, 2)
        (3, 2)
        """
        print self.optargs(3, 4)
        print self.optargs(3,b=4)
        print self.optargs(a=3,b=4)
        print self.optargs()
        print self.optargs(3)
        print self.optargs(a=3)
        # print self.optargs(b=4)
        print "EXT"
        print ext.optargs(3, 4)
        print ext.optargs(3,b=4)
        print ext.optargs(a=3,b=4)
        print ext.optargs()
        print ext.optargs(3)
        print ext.optargs(a=3)
        # print ext.optargs(b=4)

    cpdef fn cpmeth_optargs(self, a=1, b=2):
        return (a, b)

    #[cython::test_fail_if_path_exists('//GeneralCallNode')]
    #[cython::test_assert_path_exists('//SimpleCallNode')]
    def call_cpmeth_optargs(self, ExtType ext):
        """
        >>> x = ExtType()
        >>> x.call_cpmeth_optargs(x)
        (3, 4)
        (3, 4)
        (3, 4)
        (1, 2)
        (3, 2)
        (3, 2)
        EXT
        (3, 4)
        (3, 4)
        (3, 4)
        (1, 2)
        (3, 2)
        (3, 2)
        """
        print self.cpmeth_optargs(3, 4)
        print self.cpmeth_optargs(3,b=4)
        print self.cpmeth_optargs(a=3,b=4)
        print self.cpmeth_optargs()
        print self.cpmeth_optargs(3)
        print self.cpmeth_optargs(a=3)
        # print self.cpmeth_optargs(b=4)
        print "EXT"
        print ext.cpmeth_optargs(3, 4)
        print ext.cpmeth_optargs(3,b=4)
        print ext.cpmeth_optargs(a=3,b=4)
        print ext.cpmeth_optargs()
        print ext.cpmeth_optargs(3)
        print ext.cpmeth_optargs(a=3)
        # print ext.cpmeth_optargs(b=4)

    cpdef fn cpmeth_optargs1(self, a=1):
        return a

    #[cython::test_fail_if_path_exists('//GeneralCallNode')]
    #[cython::test_assert_path_exists('//SimpleCallNode')]
    def call_cpmeth_optargs1(self, ExtType ext):
        """
        >>> x = ExtType()
        >>> x.call_cpmeth_optargs1(x)
        1
        3
        3
        EXT
        1
        3
        3
        """
        print self.cpmeth_optargs1()
        print self.cpmeth_optargs1(3)
        print self.cpmeth_optargs1(a=3)
        print "EXT"
        print ext.cpmeth_optargs1()
        print ext.cpmeth_optargs1(3)
        print ext.cpmeth_optargs1(a=3)
