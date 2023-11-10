# Note: add integer versions of the functions?

extern from "<complex>" namespace "std" nogil:
    cdef cppclass complex[T]:
        complex() except +
        complex(T, T) except +
        complex(complex[T]&) except +
        # How to make the converting constructor, i.e. convert complex[double]
        # to complex[float]?

        complex[T] operator+(complex[T]&)
        complex[T] operator-(complex[T]&)
        complex[T] operator+(complex[T]&, complex[T]&)
        complex[T] operator+(complex[T]&, T&)
        complex[T] operator+(T&, complex[T]&)
        complex[T] operator-(complex[T]&, complex[T]&)
        complex[T] operator-(complex[T]&, T&)
        complex[T] operator-(T&, complex[T]&)
        complex[T] operator*(complex[T]&, complex[T]&)
        complex[T] operator*(complex[T]&, T&)
        complex[T] operator*(T&, complex[T]&)
        complex[T] operator/(complex[T]&, complex[T]&)
        complex[T] operator/(complex[T]&, T&)
        complex[T] operator/(T&, complex[T]&)

        u2 operator==(complex[T]&, complex[T]&)
        u2 operator==(complex[T]&, T&)
        u2 operator==(T&, complex[T]&)
        u2 operator!=(complex[T]&, complex[T]&)
        u2 operator!=(complex[T]&, T&)
        u2 operator!=(T&, complex[T]&)

        # Access real part
        T real()
        void real(T)

        # Access imaginary part
        T imag()
        void imag(T)

    # Return real part
    fn T real[T](complex[T]&)
    fn long double real(long double)
    fn f64 real(double)
    fn f32 real(float)

    # Return imaginary part
    fn T imag[T](complex[T]&)
    fn long double imag(long double)
    fn f64 imag(double)
    fn f32 imag(float)

    fn T abs[T](complex[T]&)
    fn T arg[T](complex[T]&)
    fn long double arg(long double)
    fn f64 arg(double)
    fn f32 arg(float)

    fn T norm[T](complex[T])
    fn long double norm(long double)
    fn f64 norm(double)
    fn f32 norm(float)

    fn complex[T] conj[T](complex[T]&)
    fn complex[long double] conj(long double)
    fn complex[double] conj(double)
    fn complex[float] conj(float)

    fn complex[T] proj[T](complex[T])
    fn complex[long double] proj(long double)
    fn complex[double] proj(double)
    fn complex[float] proj(float)

    fn complex[T] polar[T](T&, T&)
    fn complex[T] ploar[T](T&)

    fn complex[T] exp[T](complex[T]&)
    fn complex[T] log[T](complex[T]&)
    fn complex[T] log10[T](complex[T]&)

    fn complex[T] pow[T](complex[T]&, complex[T]&)
    fn complex[T] pow[T](complex[T]&, T&)
    fn complex[T] pow[T](T&, complex[T]&)
    # There are some promotion versions too

    fn complex[T] sqrt[T](complex[T]&)

    fn complex[T] sin[T](complex[T]&)
    fn complex[T] cos[T](complex[T]&)
    fn complex[T] tan[T](complex[T]&)
    fn complex[T] asin[T](complex[T]&)
    fn complex[T] acos[T](complex[T]&)
    fn complex[T] atan[T](complex[T]&)

    fn complex[T] sinh[T](complex[T]&)
    fn complex[T] cosh[T](complex[T]&)
    fn complex[T] tanh[T](complex[T]&)

    fn complex[T] asinh[T](complex[T]&)
    fn complex[T] acosh[T](complex[T]&)
    fn complex[T] atanh[T](complex[T]&)
