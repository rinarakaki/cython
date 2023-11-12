extern from "<complex.h>" nogil:
    # Trigonometric functions.
    fn double complex cacos(double complex z)
    fn double complex casin(double complex z)
    fn double complex catan(double complex z)
    fn double complex ccos(double complex z)
    fn double complex csin(double complex z)
    fn double complex ctan(double complex z)

    # Hyperbolic functions.
    fn double complex cacosh(double complex z)
    fn double complex casinh(double complex z)
    fn double complex catanh(double complex z)
    fn double complex ccosh(double complex z)
    fn double complex csinh(double complex z)
    fn double complex ctanh(double complex z)

    # Exponential and logarithmic functions.
    fn double complex cexp(double complex z)
    fn double complex clog(double complex z)
    fn double complex clog10(double complex z)

    # Power functions.
    fn double complex cpow(double complex x, double complex y)
    fn double complex csqrt(double complex z)

    # Absolute value, conjugates, and projection.
    fn f64 cabs(double complex z)
    fn f64 carg(double complex z)
    fn double complex conj(double complex z)
    fn double complex cproj(double complex z)

    # Decomposing complex values.
    fn f64 cimag(double complex z)
    fn f64 creal(double complex z)
