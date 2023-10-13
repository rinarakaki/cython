struct Grail

struct Spam:
    i32 i
    char c
    f32 *p[42]
    Grail *g

struct Grail:
    Spam *s

cdef Spam spam, ham

fn void eggs_i(Spam s):
    cdef int j
    j = s.i
    s.i = j

fn void eggs_c(Spam s):
    cdef char c
    c = s.c
    s.c = c

fn void eggs_p(Spam s):
    cdef float *p
    p = s.p[0]
    s.p[0] = p

fn void eggs_g(Spam s):
    cdef float *p
    p = s.p[0]
    s.p[0] = p

spam = ham

def test_i():
    """
    >>> test_i()
    """
    spam.i = 1
    eggs_i(spam)

def test_c():
    """
    >>> test_c()
    """
    spam.c = c'a'
    eggs_c(spam)

def test_p():
    """
    >>> test_p()
    """
    cdef float f
    spam.p[0] = &f
    eggs_p(spam)

def test_g():
    """
    >>> test_g()
    """
    cdef Grail l
    spam.g = &l
    eggs_g(spam)


struct Ints:
    i32 a, b

def assign_fields_in_loop():
    """
    >>> assign_fields_in_loop()
    2
    """
    cdef int i = 0
    cdef Ints s
    for s.a, s.b in enumerate(range(3)):
        assert s.a == s.b
        assert s.a == i
        i += 1

    assert s.a == s.b
    return s.b
