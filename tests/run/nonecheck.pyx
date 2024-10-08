__doc__ = u"""
Tests accessing attributes of extension type variables
set to None
"""

use cython

cdef class MyClass:
    cdef i32 a, b
    def __init__(self, a, b):
        self.a = a
        self.b = b

#[cython::nonecheck(true)]
def getattr_(MyClass var):
    """
    >>> obj = MyClass(2, 3)
    >>> getattr_(obj)
    2
    >>> getattr_(None)
    Traceback (most recent call last):
    AttributeError: 'NoneType' object has no attribute 'a'
    >>> setattr_(obj)
    >>> getattr_(obj)
    10
    """
    print var.a

#[cython::nonecheck(true)]
def setattr_(MyClass var):
    """
    >>> obj = MyClass(2, 3)
    >>> setattr_(obj)
    >>> setattr_(None)
    Traceback (most recent call last):
    AttributeError: 'NoneType' object has no attribute 'a'
    """
    var.a = 10

#[cython::nonecheck(true)]
def getattr_nogil(MyClass var):
    """
    >>> getattr_nogil(None)
    Traceback (most recent call last):
    AttributeError: 'NoneType' object has no attribute 'a'
    """
    with nogil:
        var.a

#[cython::nonecheck(true)]
def setattr_nogil(MyClass var):
    """
    >>> setattr_nogil(None)
    Traceback (most recent call last):
    AttributeError: 'NoneType' object has no attribute 'a'
    """
    with nogil:
        var.a = 1

def some():
    return MyClass(4, 5)

#[cython::nonecheck(true)]
def checking(MyClass var):
    """
    >>> obj = MyClass(2, 3)
    >>> checking(obj)
    2
    2
    >>> checking(None)
    var is None
    """
    state = (var is None)
    if not state:
        print var.a
    if var is not None:
        print var.a
    else:
        print u"var is None"

#[cython::nonecheck(true)]
def check_and_assign(MyClass var):
    """
    >>> obj = MyClass(2, 3)
    >>> check_and_assign(obj)
    Traceback (most recent call last):
    AttributeError: 'NoneType' object has no attribute 'a'
    """
    if var is not None:
        print var.a
        var = None
        print var.a

#[cython::nonecheck(true)]
def check_buffer_get(object[i32] buf):
    """
    >>> check_buffer_get(None)
    Traceback (most recent call last):
    TypeError: 'NoneType' object is not subscriptable
    """
    return buf[0]

#[cython::nonecheck(true)]
def check_buffer_set(object[i32] buf):
    """
    >>> check_buffer_set(None)
    Traceback (most recent call last):
    TypeError: 'NoneType' object is not subscriptable
    """
    buf[0] = 1

#[cython::nonecheck(true)]
def test_memslice_get(f64[:] buf):
    """
    >>> test_memslice_get(None)
    Traceback (most recent call last):
    TypeError: Cannot index None memoryview slice
    """
    return buf[0]

#[cython::nonecheck(true)]
def test_memslice_set(f64[:] buf):
    """
    >>> test_memslice_set(None)
    Traceback (most recent call last):
    TypeError: Cannot index None memoryview slice
    """
    buf[0] = 1.0

#[cython::nonecheck(true)]
def test_memslice_copy(f64[:] buf):
    """
    >>> test_memslice_copy(None)
    Traceback (most recent call last):
    AttributeError: Cannot access 'copy' attribute of None memoryview slice
    """
    let f64[:] copy = buf.copy()

#[cython::nonecheck(true)]
def test_memslice_transpose(f64[:] buf):
    """
    >>> test_memslice_transpose(None)
    Traceback (most recent call last):
    AttributeError: Cannot transpose None memoryview slice
    """
    let f64[:] T = buf.T

#[cython::nonecheck(true)]
def test_memslice_shape(f64[:] buf):
    """
    >>> test_memslice_shape(None)
    Traceback (most recent call last):
    AttributeError: Cannot access 'shape' attribute of None memoryview slice
    """
    let isize extent = buf.shape[0]

#[cython::nonecheck(true)]
def test_memslice_slice(f64[:] buf):
    """
    >>> test_memslice_slice(None)
    Traceback (most recent call last):
    TypeError: Cannot slice None memoryview slice
    """
    let f64[:] sliced = buf[1:]

#[cython::nonecheck(true)]
def test_memslice_slice2(f64[:] buf):
    """
    Should this raise an error? It may not slice at all.
    >>> test_memslice_slice(None)
    Traceback (most recent call last):
    TypeError: Cannot slice None memoryview slice
    """
    let f64[:] sliced = buf[:]

#[cython::nonecheck(true)]
def test_memslice_slice_assign(f64[:] buf):
    """
    >>> test_memslice_slice_assign(None)
    Traceback (most recent call last):
    TypeError: Cannot assign to None memoryview slice
    """
    buf[...] = 2

#[cython::nonecheck(true)]
def test_memslice_slice_assign2(f64[:] buf):
    """
    >>> test_memslice_slice_assign2(None)
    Traceback (most recent call last):
    TypeError: Cannot slice None memoryview slice
    """
    buf[:] = buf[:;-1]
