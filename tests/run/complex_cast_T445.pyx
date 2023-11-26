# ticket: t445

def complex_double_cast(f64 x, c128 z):
    """
    >>> complex_double_cast(1, 4-3j)
    ((1+0j), (4-3j))
    """
    let auto xx = <c128>x
    let auto zz = <c128>z
    xx = x
    return xx, zz

def complex_double_int_cast(i32 x, int complex z):
    """
    >>> complex_double_int_cast(2, 2 + 3j)
    ((2+0j), (3+3j))
    """
    let auto xx = <c128>x
    let auto zz = <c128>(z + 1)
    return xx, zz

def complex_int_double_cast(f64 x, c128 z):
    """
    >>> complex_int_double_cast(2.5, 2.5 + 3.5j)
    ((2+0j), (2+3j))
    """
    let auto xx = <int complex>x
    let auto zz = <int complex>z
    return xx, zz

cdef i32 side_effect_counter = 0

fn c128 side_effect(c128 z):
    global side_effect_counter
    side_effect_counter += 1
    print "side effect", side_effect_counter, z
    return z

def test_side_effect(int complex z):
    """
    >>> test_side_effect(5)
    side effect 1 (5+0j)
    (5+0j)
    >>> test_side_effect(3-4j)
    side effect 2 (3-4j)
    (3-4j)
    """
    let auto zz = <int complex>side_effect(z)
    return zz
