extern from "<complex.h>" nogil:
    # Trigonometric functions.
    fn c64 cacos(c64 z)
    fn c64 casin(c64 z)
    fn c64 catan(c64 z)
    fn c64 ccos(c64 z)
    fn c64 csin(c64 z)
    fn c64 ctan(c64 z)

    # Hyperbolic functions.
    fn c64 cacosh(c64 z)
    fn c64 casinh(c64 z)
    fn c64 catanh(c64 z)
    fn c64 ccosh(c64 z)
    fn c64 csinh(c64 z)
    fn c64 ctanh(c64 z)

    # Exponential and logarithmic functions.
    fn c64 cexp(c64 z)
    fn c64 clog(c64 z)
    fn c64 clog10(c64 z)

    # Power functions.
    fn c64 cpow(c64 x, c64 y)
    fn c64 csqrt(c64 z)

    # Absolute value, conjugates, and projection.
    fn f64 cabs(c64 z)
    fn f64 carg(c64 z)
    fn c64 conj(c64 z)
    fn c64 cproj(c64 z)

    # Decomposing complex values.
    fn f64 cimag(c64 z)
    fn f64 creal(c64 z)
