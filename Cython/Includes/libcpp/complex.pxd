# Note: add integer versions of the functions?

extern from "<complex>" namespace "std" nogil:
    cdef cppclass complex[T]:
        complex() except +
        complex(T, T) except +
        complex(complex[T]&) except +
        # How to make the converting constructor, i.e. convert complex[f64]
        # to complex[f32]?

        fn complex[T] operator+(complex[T]&)
        fn complex[T] operator-(complex[T]&)
        fn complex[T] operator+(complex[T]&, complex[T]&)
        fn complex[T] operator+(complex[T]&, &mut T)
        fn complex[T] operator+(&mut T, complex[T]&)
        fn complex[T] operator-(complex[T]&, complex[T]&)
        fn complex[T] operator-(complex[T]&, &mut T)
        fn complex[T] operator-(&mut T, complex[T]&)
        fn complex[T] operator*(complex[T]&, complex[T]&)
        fn complex[T] operator*(complex[T]&, &mut T)
        fn complex[T] operator*(&mut T, complex[T]&)
        fn complex[T] operator/(complex[T]&, complex[T]&)
        fn complex[T] operator/(complex[T]&, &mut T)
        fn complex[T] operator/(&mut T, complex[T]&)

        fn u2 operator==(complex[T]&, complex[T]&)
        fn u2 operator==(complex[T]&, &mut T)
        fn u2 operator==(&mut T, complex[T]&)
        fn u2 operator!=(complex[T]&, complex[T]&)
        fn u2 operator!=(complex[T]&, &mut T)
        fn u2 operator!=(&mut T, complex[T]&)

        # Access real part
        fn T real()
        fn void real(T)

        # Access imaginary part
        fn T imag()
        fn void imag(T)

    # Return real part
    fn T real[T](complex[T]&)
    fn f128 real(f128)
    fn f64 real(f64)
    fn f32 real(f32)

    # Return imaginary part
    fn T imag[T](complex[T]&)
    fn f128 imag(f128)
    fn f64 imag(f64)
    fn f32 imag(f32)

    fn T abs[T](complex[T]&)
    fn T arg[T](complex[T]&)
    fn f128 arg(f128)
    fn f64 arg(f64)
    fn f32 arg(f32)

    fn T norm[T](complex[T])
    fn f128 norm(f128)
    fn f64 norm(f64)
    fn f32 norm(f32)

    fn complex[T] conj[T](complex[T]&)
    fn complex[f128] conj(f128)
    fn complex[f64] conj(f64)
    fn complex[f32] conj(f32)

    fn complex[T] proj[T](complex[T])
    fn complex[f128] proj(f128)
    fn complex[f64] proj(f64)
    fn complex[f32] proj(f32)

    fn complex[T] polar[T](&mut T, &mut T)
    fn complex[T] ploar[T](&mut T)

    fn complex[T] exp[T](complex[T]&)
    fn complex[T] log[T](complex[T]&)
    fn complex[T] log10[T](complex[T]&)

    fn complex[T] pow[T](complex[T]&, complex[T]&)
    fn complex[T] pow[T](complex[T]&, &mut T)
    fn complex[T] pow[T](&mut T, complex[T]&)
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
