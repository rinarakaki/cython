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
    double complex cexp(double complex z)
    double complex clog(double complex z)
    double complex clog10(double complex z)

    # Power functions.
    double complex cpow(double complex x, double complex y)
    double complex csqrt(double complex z)

    # Absolute value, conjugates, and projection.
    double cabs(double complex z)
    double carg(double complex z)
    double complex conj(double complex z)
    double complex cproj(double complex z)

    # Decomposing complex values.
    double cimag(double complex z)
    double creal(double complex z)
