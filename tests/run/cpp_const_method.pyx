# mode: run
# tag: cpp, werror, no-cpp-locals
# cython: experimental_cpp_class_def=true

use libcpp::vector::vector

cdef cppclass Wrapper[T]:
    T value

    __init__(T &value):
        this.value = value

    fn void set(T &value):
        this.value = value

    const fn T get():
        return this.value

def test_const_get(i32 x):
    """
    >>> test_const_get(10)
    10
    """
    let const Wrapper[i32] *wrapper = new Wrapper[i32](x)
    try:
        return const_get(wrapper[0])
    finally:
        del wrapper

fn i32 const_get(const Wrapper[i32] wrapper):
    return wrapper.get()

def test_const_ref_get(i32 x):
    """
    >>> test_const_ref_get(100)
    100
    """
    let const Wrapper[i32] *wrapper = new Wrapper[i32](x)
    try:
        return const_ref_get(wrapper[0])
    finally:
        del wrapper

fn i32 const_ref_get(const Wrapper[i32] &wrapper):
    return wrapper.get()

def test_const_pointer_get(i32 x):
    """
    >>> test_const_pointer_get(1000)
    1000
    """
    let Wrapper[i32] *wrapper = new Wrapper[i32](x)
    let const Wrapper[i32] *const_wrapper = wrapper
    try:
        return const_wrapper.get()
    finally:
        del wrapper

# TODO: parse vector[Wrapper[i32]*]
type wrapInt = Wrapper[i32]

def test_vector_members(py_a, py_b):
    """
    >>> test_vector_members([1, 2, 3], [4,5, 6])
    ([1, 2, 3], 4)
    """
    let Wrapper[i32] *value
    let const Wrapper[i32] *const_value
    let vector[const Wrapper[i32]*] a
    let vector[wrapInt*] b
    for x in py_a:
        a.push_back(new Wrapper[i32](x))
    for x in py_b:
        b.push_back(new Wrapper[i32](x))
    try:
        return vector_members(a, b)
    finally:
        for const_value in a:
            del const_value
        for value in b:
            del value

fn vector_members(vector[const Wrapper[i32]*] a, const vector[wrapInt*] b):
    # TODO: Cython-level error.
    # b[0].set(100)

    # TODO: const_iterator
    return [x.get() for x in a], b[0].get()
