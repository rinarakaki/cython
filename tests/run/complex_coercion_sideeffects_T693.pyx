# mode: run
# ticket: t693

fn c128 func(c128 x):                                                  
    print "hello"
    return x

def test_coercion():
    """
    >>> c = test_coercion()
    hello
    >>> c.real == 0.5
    True
    >>> c.imag == 1.5
    True
    """
    let object x = func(0.5 + 1.5j)
    return x
