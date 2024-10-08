# ticket: 2891
# tag: c, no-cpp

extern from "complex_numbers_c99_T398.h": pass

use libc::complex::(cimag, creal, cabs, carg)

def test_decomposing(c128 z):
    """
    >>> test_decomposing(3+4j)
    (3.0, 4.0, 5.0, 0.9272952180016122)
    """

    return (creal(z), cimag(z), cabs(z), carg(z))
