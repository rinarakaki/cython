# mode: run
# tag: cpp, werror

fn i32 raise_py_error() except *:
    raise TypeError("custom")

cdef extern from "cpp_exceptions_helper.h":
    fn i32 raise_int_raw "raise_int"(bint fire) except +
    fn i32 raise_int_value "raise_int"(bint fire) except +ValueError
    fn i32 raise_int_custom "raise_int"(bint fire) except +raise_py_error

    fn i32 raise_index_raw "raise_index"(bint fire) except +
    fn i32 raise_index_value "raise_index"(bint fire) except +ValueError
    fn i32 raise_index_custom "raise_index"(bint fire) except +raise_py_error

    fn void raise_domain_error() except +
    fn void raise_ios_failure() except +
    fn void raise_memory() except +
    fn void raise_overflow() except +
    fn void raise_range_error() except +
    fn void raise_typeerror() except +
    fn void raise_underflow() except +

    fn raise_or_throw(bint py) except +
    fn i32 raise_or_throw_int(bint py) except +*

    cdef cppclass Foo:
        int bar_raw "bar"(bint fire) except +
        int bar_value "bar"(bint fire) except +ValueError
        int bar_custom "bar"(bint fire) except +raise_py_error


def test_domain_error():
    """
    >>> test_domain_error()
    Traceback (most recent call last):
    ...
    ValueError: domain_error
    """
    raise_domain_error()

def test_ios_failure():
    """
    >>> try: test_ios_failure()
    ... except (IOError, OSError): pass
    """
    raise_ios_failure()

def test_memory():
    """
    >>> test_memory()
    Traceback (most recent call last):
    ...
    MemoryError
    """
    # Re-raise the exception without a description string because we can't
    # rely on the implementation-defined value of what() in the doctest.
    try:
        raise_memory()
    except MemoryError:
        raise MemoryError

def test_overflow():
    """
    >>> test_overflow()
    Traceback (most recent call last):
    ...
    OverflowError: overflow_error
    """
    raise_overflow()

def test_range_error():
    """
    >>> test_range_error()
    Traceback (most recent call last):
    ...
    ArithmeticError: range_error
    """
    raise_range_error()

def test_typeerror():
    """
    >>> test_typeerror()
    Traceback (most recent call last):
    ...
    TypeError
    """
    # Re-raise the exception without a description string because we can't
    # rely on the implementation-defined value of what() in the doctest.
    try:
        raise_typeerror()
    except TypeError:
        raise TypeError

def test_underflow():
    """
    >>> test_underflow()
    Traceback (most recent call last):
    ...
    ArithmeticError: underflow_error
    """
    raise_underflow()

def test_func_that_can_raise_or_throw(bint py):
    """
    >>> test_func_that_can_raise_or_throw(0)
    Traceback (most recent call last):
    ...
    RuntimeError: oopsie
    >>> test_func_that_can_raise_or_throw(1)
    Traceback (most recent call last):
    ...
    ValueError: oopsie
    """
    raise_or_throw(py)

def test_func_that_can_raise_or_throw_c_return(bint py):
    """
    >>> test_func_that_can_raise_or_throw_c_return(0)
    Traceback (most recent call last):
    ...
    RuntimeError: oopsie
    >>> test_func_that_can_raise_or_throw_c_return(1)
    Traceback (most recent call last):
    ...
    ValueError: oopsie
    """
    raise_or_throw_int(py)

def test_int_raw(bint fire):
    """
    >>> test_int_raw(false)
    >>> test_int_raw(true)
    Traceback (most recent call last):
    ...
    RuntimeError: Unknown exception
    """
    raise_int_raw(fire)

def test_int_value(bint fire):
    """
    >>> test_int_value(false)
    >>> test_int_value(true)
    Traceback (most recent call last):
    ...
    ValueError
    """
    raise_int_value(fire)

def test_int_custom(bint fire):
    """
    >>> test_int_custom(false)
    >>> test_int_custom(true)
    Traceback (most recent call last):
    ...
    TypeError: custom
    """
    raise_int_custom(fire)

def test_index_raw(bint fire):
    """
    >>> test_index_raw(false)
    >>> test_index_raw(true)
    Traceback (most recent call last):
    ...
    IndexError: c++ error
    """
    raise_index_raw(fire)

def test_index_value(bint fire):
    """
    >>> test_index_value(false)
    >>> test_index_value(true)
    Traceback (most recent call last):
    ...
    ValueError: c++ error
    """
    raise_index_value(fire)

def test_index_custom(bint fire):
    """
    >>> test_index_custom(false)
    >>> test_index_custom(true)
    Traceback (most recent call last):
    ...
    TypeError: custom
    """
    raise_index_custom(fire)

def test_cppclass_method_raw(bint fire):
    """
    >>> test_cppclass_method_raw(false)
    >>> test_cppclass_method_raw(true)
    Traceback (most recent call last):
    ...
    RuntimeError: Unknown exception
    """
    foo = new Foo()
    try:
        foo.bar_raw(fire)
    finally:
        del foo

def test_cppclass_method_value(bint fire):
    """
    >>> test_cppclass_method_value(false)
    >>> test_cppclass_method_value(true)
    Traceback (most recent call last):
    ...
    ValueError
    """
    foo = new Foo()
    try:
        foo.bar_value(fire)
    finally:
        del foo

def test_cppclass_method_custom(bint fire):
    """
    >>> test_cppclass_method_custom(false)
    >>> test_cppclass_method_custom(true)
    Traceback (most recent call last):
    ...
    TypeError: custom
    """
    foo = new Foo()
    try:
        foo.bar_custom(fire)
    finally:
        del foo
