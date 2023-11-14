extern from "<complex.h>" nogil:
    # Trigonometric functions.
    fn c128 cacos(c128 z)
    fn c128 casin(c128 z)
    fn c128 catan(c128 z)
    fn c128 ccos(c128 z)
    fn c128 csin(c128 z)
    fn c128 ctan(c128 z)

    # Hyperbolic functions.
    fn c128 cacosh(c128 z)
    fn c128 casinh(c128 z)
    fn c128 catanh(c128 z)
    fn c128 ccosh(c128 z)
    fn c128 csinh(c128 z)
    fn c128 ctanh(c128 z)

    # Exponential and logarithmic functions.
    fn c128 cexp(c128 z)
    fn c128 clog(c128 z)
    fn c128 clog10(c128 z)

    # Power functions.
    fn c128 cpow(c128 x, c128 y)
    fn c128 csqrt(c128 z)

    # Absolute value, conjugates, and projection.
    fn f64 cabs(c128 z)
    fn f64 carg(c128 z)
    fn c128 conj(c128 z)
    fn c128 cproj(c128 z)

    # Decomposing complex values.
    fn f64 cimag(c128 z)
    fn f64 creal(c128 z)
