struct Grail

struct Spam:
    i32 i
    i8 c
    f32 *p[42]
    r&Grail g

struct Grail:
    Spam *s

cdef Spam spam, ham

fn void eggs_i(Spam s):
    let i32 j
    j = s.i
    s.i = j

fn void eggs_c(Spam s):
    let i8 c
    c = s.c
    s.c = c

fn void eggs_p(Spam s):
    let f32* p
    p = s.p[0]
    s.p[0] = p

fn void eggs_g(Spam s):
    let f32* p
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
    let f32 f
    spam.p[0] = &f
    eggs_p(spam)

def test_g():
    """
    >>> test_g()
    """
    let Grail l
    spam.g = &l
    eggs_g(spam)

struct Ints:
    i32 a, b

def assign_fields_in_loop():
    """
    >>> assign_fields_in_loop()
    2
    """
    let i32 i = 0
    let Ints s
    for s.a, s.b in enumerate(0..3):
        assert s.a == s.b
        assert s.a == i
        i += 1

    assert s.a == s.b
    return s.b
