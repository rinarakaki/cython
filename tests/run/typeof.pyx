from cython cimport typeof

cdef class A:
    pass

cdef class B(A):
    pass

struct X:
    f64 a
    f64 complex b

def simple():
    """
    >>> simple()
    int
    long
    long long
    int *
    int **
    A
    B
    X
    Python object
    """
    let int i = 0
    let long l = 0
    let long long ll = 0
    let int* iptr = &i
    let int** iptrptr = &iptr
    let A a = None
    let B b = None
    let X x = X(a=1, b=2)
    print typeof(i)
    print typeof(l)
    print typeof(ll)
    print typeof(iptr)
    print typeof(iptrptr)
    print typeof(a)
    print typeof(b)
    print typeof(x)
    print typeof(None)
    used = i, l, ll, <long>iptr, <long>iptrptr, a, b, x

def expression():
    """
    >>> expression()
    double
    double complex
    int
    unsigned int
    """
    let X x = X(a=1, b=2)
    let X *xptr = &x
    let short s = 0
    let int i = 0
    let unsigned int ui = 0
    print typeof(x.a)
    print typeof(xptr.b)
    print typeof(s + i)
    print typeof(i + ui)
    used = x, <long>xptr, s, i, ui
