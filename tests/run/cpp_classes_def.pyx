# mode: run
# tag: cpp, werror, cpp11, no-cpp-locals
# cython: experimental_cpp_class_def=true

cdef f64 pi
from math import pi
use libc::math::(sin, cos)
use libcpp::bool
use libcpp::memory::unique_ptr
use libcpp::vector::vector
use cython::operator::dereference as deref
import cython

extern from "shapes.h" namespace "shapes":
    cdef cppclass Shape:
        const fn f32 area()

cdef cppclass RegularPolygon(Shape):
    f32 radius # major
    i32 n

    __init__(i32 n, f32 radius):
        this.n = n
        this.radius = radius

    const fn f32 area() noexcept:
        let f64 theta = pi / this.n
        return this.radius * this.radius * sin(theta) * cos(theta) * this.n

    fn void do_with() except *:
        # only a compile test - the file doesn't actually have to exist
        # "with" was broken by https://github.com/cython/cython/issues/4212
        with open("does not matter") as f:
            return

fn test_Poly(i32 n, f32 radius=1):
    """
    >>> test_Poly(4)
    2.0
    >>> test_Poly(3)         # doctest: +ELLIPSIS
    1.29903...
    >>> test_Poly(3, 10.0)   # doctest: +ELLIPSIS
    129.903...
    >>> test_Poly(100)       # doctest: +ELLIPSIS
    3.13952...
    >>> test_Poly(1000)      # doctest: +ELLIPSIS
    3.14157...
    """
    let RegularPolygon* poly
    try:
        poly = new RegularPolygon(n, radius)
        poly.n = n
        poly.radius = radius
        return poly.area()
    finally:
        del poly

cdef cppclass BaseClass:
    i32 n

    fn i32 method():
        return this.n

cdef cppclass SubClass(BaseClass):
    bool override

    __init__(bool override):
        this.n = 1
        this.override = override

    fn i32 method():
        if override:
            return 0
        else:
            return BaseClass.method()

def test_BaseMethods(x):
    """
    >>> test_BaseMethods(true)
    0
    >>> test_BaseMethods(false)
    1
    """
    let SubClass* subClass
    try:
        subClass = new SubClass(x)
        return subClass.method()
    finally:
        del subClass

cdef cppclass WithStatic:
    static fn  f64 square(f64 x):
        return x * x

def test_Static(x):
    """
    >>> test_Static(2)
    4.0
    >>> test_Static(0.5)
    0.25
    """
    return WithStatic.square(x)

cdef cppclass InitDealloc:
    __init__():
        try:
            print "Init"
        finally:
            return  # swallow any exceptions

    __dealloc__():
        try:
            print "Dealloc"
        finally:
            return  # swallow any exceptions

fn test_init_dealloc():
    """
    >>> test_init_dealloc()
    start
    Init
    live
    Dealloc
    end
    """
    print "start"
    let InitDealloc *ptr = new InitDealloc()
    print "live"
    del ptr
    print "end"

cdef cppclass WithTemplate[T]:
    T value

    fn void set_value(T value):
        this.value = value

    fn T get_value():
        return this.value

cdef cppclass ResolveTemplate(WithTemplate[long]):
    pass

def test_templates(long value):
    """
    >>> test_templates(10)
    >>> test_templates(-2)
    """
    let WithTemplate[long] *base = new WithTemplate[long]()
    del base

    let ResolveTemplate *resolved = new ResolveTemplate()
    resolved.set_value(value)
    assert resolved.value == resolved.get_value() == value, resolved.value

    base = resolved
    base.set_value(2 * value)
    assert base.get_value() == base.value == 2 * value, base.value

    del base

cdef cppclass Simple:
    pass

def test_default_init_no_gil():
    with nogil:
        s = new Simple()
        del s

cdef class NoisyAlloc(object):
    pub name

    def __init__(self, name):
        print "NoisyAlloc.__init__", name
        self.name = name

    def __dealloc__(self):
        try:
            print "NoisyAlloc.__dealloc__", self.name
        except:
            pass  # Suppress unraisable exception warning.

    def __repr__(self):
        return "NoisyAlloc[%s]" % self.name

cdef cppclass CppClassWithObjectMember:
    NoisyAlloc o

    __init__(name):
        try:
            print "CppClassWithObjectMember.__init__", name
            this.o = NoisyAlloc(name)
        except:
            pass  # Suppress unraisable exception warning.
    __dealloc__():
        try:
            print "CppClassWithObjectMember.__dealloc__", this.o.name
        except:
            pass  # Suppress unraisable exception warning.

def test_CppClassWithObjectMember(name):
    """
    >>> test_CppClassWithObjectMember("gertrude")
    CppClassWithObjectMember.__init__ gertrude
    NoisyAlloc.__init__ gertrude
    CppClassWithObjectMember.__dealloc__ gertrude
    NoisyAlloc.__dealloc__ gertrude
    """
    x = new CppClassWithObjectMember(name)
    del x

def test_CppClassWithObjectMemberCopyAssign(name):
    """
    >>> test_CppClassWithObjectMemberCopyAssign("gretel")
    CppClassWithObjectMember.__init__ gretel
    NoisyAlloc.__init__ gretel
    CppClassWithObjectMember.__dealloc__ gretel
    Alive in vector NoisyAlloc[gretel]
    CppClassWithObjectMember.__init__ leterg
    NoisyAlloc.__init__ leterg
    NoisyAlloc.__dealloc__ gretel
    CppClassWithObjectMember.__dealloc__ leterg
    Alive in vector NoisyAlloc[leterg]
    CppClassWithObjectMember.__dealloc__ leterg
    NoisyAlloc.__dealloc__ leterg
    Nothing alive.
    """
    x = new CppClassWithObjectMember(name)
    let vector[CppClassWithObjectMember] v
    # Invokes copy constructor.
    v.push_back(deref(x))
    del x
    print "Alive in vector", v[0].o
    y = new CppClassWithObjectMember(name[:;-1])
    # Invokes copy assignment.
    v[0] = deref(y)
    del y
    print "Alive in vector", v[0].o
    v.clear()
    print "Nothing alive."

# Github issue #1886.
pub cppclass PublicCppClassWithObjectMember:
    object o

def test_PublicCppClassWithObjectMember():
    """
    >>> test_PublicCppClassWithObjectMember()
    """
    let PublicCppClassWithObjectMember c
    assert c.o is None

cdef cppclass UncopyableConstructorArgument:
    unique_ptr[vector[i32]] member

    __init__(unique_ptr[vector[i32]] arg):
        this.member.reset(arg.release())

def test_uncopyable_constructor_argument():
    """
    >>> test_uncopyable_constructor_argument()
    """
    let UncopyableConstructorArgument *c = new UncopyableConstructorArgument(
        unique_ptr[vector[i32]](new vector[i32]()))
    del c

cdef cppclass CppClassWithDocstring:
    """
    This is a docstring !
    """

def test_CppClassWithDocstring():
    """
    >>> test_CppClassWithDocstring()
    OK
    """
    let CppClassWithDocstring *c = new CppClassWithDocstring()
    del c
    print "OK"
