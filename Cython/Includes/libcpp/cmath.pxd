extern from "<cmath>" namespace "std" nogil:
    # all C99 functions
    fn f32 acos(f32 x) except +
    fn f64 acos(f64 x) except +
    fn f128 acos(f128 x) except +
    fn f32 acosf(f32 x) except +
    fn f128 acosl(f128 x) except +

    fn f32 asin(f32 x) except +
    fn f64 asin(f64 x) except +
    fn f128 asin(f128 x) except +
    fn f32 asinf(f32 x) except +
    fn f128 asinl(f128 x) except +

    fn f32 atan(f32 x) except +
    fn f64 atan(f64 x) except +
    fn f128 atan(f128 x) except +
    fn f32 atanf(f32 x) except +
    fn f128 atanl(f128 x) except +

    fn f32 atan2(f32 y, f32 x) except +
    fn f64 atan2(f64 y, f64 x) except +
    fn f128 atan2(f128 y, f128 x) except +
    fn f32 atan2f(f32 y, f32 x) except +
    fn f128 atan2l(f128 y, f128 x) except +

    fn f32 cos(f32 x) except +
    fn f64 cos(f64 x) except +
    fn f128 cos(f128 x) except +
    fn f32 cosf(f32 x) except +
    fn f128 cosl(f128 x) except +

    fn f32 sin(f32 x) except +
    fn f64 sin(f64 x) except +
    fn f128 sin(f128 x) except +
    fn f32 sinf(f32 x) except +
    fn f128 sinl(f128 x) except +

    fn f32 tan(f32 x) except +
    fn f64 tan(f64 x) except +
    fn f128 tan(f128 x) except +
    fn f32 tanf(f32 x) except +
    fn f128 tanl(f128 x) except +

    fn f32 acosh(f32 x) except +
    fn f64 acosh(f64 x) except +
    fn f128 acosh(f128 x) except +
    fn f32 acoshf(f32 x) except +
    fn f128 acoshl(f128 x) except +

    fn f32 asinh(f32 x) except +
    fn f64 asinh(f64 x) except +
    fn f128 asinh(f128 x) except +
    fn f32 asinhf(f32 x) except +
    fn f128 asinhl(f128 x) except +

    fn f32 atanh(f32 x) except +
    fn f64 atanh(f64 x) except +
    fn f128 atanh(f128 x) except +
    fn f32 atanhf(f32 x) except +
    fn f128 atanhl(f128 x) except +

    fn f32 cosh(f32 x) except +
    fn f64 cosh(f64 x) except +
    fn f128 cosh(f128 x) except +
    fn f32 coshf(f32 x) except +
    fn f128 coshl(f128 x) except +

    fn f32 sinh(f32 x) except +
    fn f64 sinh(f64 x) except +
    fn f128 sinh(f128 x) except +
    fn f32 sinhf(f32 x) except +
    fn f128 sinhl(f128 x) except +

    fn f32 tanh(f32 x) except +
    fn f64 tanh(f64 x) except +
    fn f128 tanh(f128 x) except +
    fn f32 tanhf(f32 x) except +
    fn f128 tanhl(f128 x) except +

    fn f32 exp(f32 x) except +
    fn f64 exp(f64 x) except +
    fn f128 exp(f128 x) except +
    fn f32 expf(f32 x) except +
    fn f128 expl(f128 x) except +

    fn f32 exp2(f32 x) except +
    fn f64 exp2(f64 x) except +
    fn f128 exp2(f128 x) except +
    fn f32 exp2f(f32 x) except +
    fn f128 exp2l(f128 x) except +

    fn f32 expm1(f32 x) except +
    fn f64 expm1(f64 x) except +
    fn f128 expm1(f128 x) except +
    fn f32 expm1f(f32 x) except +
    fn f128 expm1l(f128 x) except +

    fn f32 frexp(f32 value, i32* exp) except +
    fn f64 frexp(f64 value, i32* exp) except +
    fn f128 frexp(f128 value, i32* exp) except +
    fn f32 frexpf(f32 value, i32* exp) except +
    fn f128 frexpl(f128 value, i32* exp) except +

    fn i32 ilogb(f32 x) except +
    fn i32 ilogb(f64 x) except +
    fn i32 ilogb(f128 x) except +
    fn i32 ilogbf(f32 x) except +
    fn i32 ilogbl(f128 x) except +

    fn f32 ldexp(f32 x, i32 exp) except +
    fn f64 ldexp(f64 x, i32 exp) except +
    fn f128 ldexp(f128 x, i32 exp) except +
    fn f32 ldexpf(f32 x, i32 exp) except +
    fn f128 ldexpl(f128 x, i32 exp) except +

    fn f32 log(f32 x) except +
    fn f64 log(f64 x) except +
    fn f128 log(f128 x) except +
    fn f32 logf(f32 x) except +
    fn f128 logl(f128 x) except +

    fn f32 log10(f32 x) except +
    fn f64 log10(f64 x) except +
    fn f128 log10(f128 x) except +
    fn f32 log10f(f32 x) except +
    fn f128 log10l(f128 x) except +

    fn f32 log1p(f32 x) except +
    fn f64 log1p(f64 x) except +
    fn f128 log1p(f128 x) except +
    fn f32 log1pf(f32 x) except +
    fn f128 log1pl(f128 x) except +

    fn f32 log2(f32 x) except +
    fn f64 log2(f64 x) except +
    fn f128 log2(f128 x) except +
    fn f32 log2f(f32 x) except +
    fn f128 log2l(f128 x) except +

    fn f32 logb(f32 x) except +
    fn f64 logb(f64 x) except +
    fn f128 logb(f128 x) except +
    fn f32 logbf(f32 x) except +
    fn f128 logbl(f128 x) except +

    fn f32 modf(f32 value, f32* iptr) except +
    fn f64 modf(f64 value, double* iptr) except +
    fn f128 modf(f128 value, f128* iptr) except +
    fn f32 modff(f32 value, f32* iptr) except +
    fn f128 modfl(f128 value, f128* iptr) except +

    fn f32 scalbn(f32 x, i32 n) except +
    fn f64 scalbn(f64 x, i32 n) except +
    fn f128 scalbn(f128 x, i32 n) except +
    fn f32 scalbnf(f32 x, i32 n) except +
    fn f128 scalbnl(f128 x, i32 n) except +

    fn f32 scalbln(f32 x, i64 n) except +
    fn f64 scalbln(f64 x, i64 n) except +
    fn f128 scalbln(f128 x, i64 n) except +
    fn f32 scalblnf(f32 x, i64 n) except +
    fn f128 scalblnl(f128 x, i64 n) except +

    fn f32 cbrt(f32 x) except +
    fn f64 cbrt(f64 x) except +
    fn f128 cbrt(f128 x) except +
    fn f32 cbrtf(f32 x) except +
    fn f128 cbrtl(f128 x) except +

    # absolute values
    fn i32 abs(i32 j) except +
    fn i64 abs(i64 j) except +
    fn i128 abs(i128 j) except +
    fn f32 abs(f32 j) except +
    fn f64 abs(f64 j) except +
    fn f128 abs(f128 j) except +

    fn f32 fabs(f32 x) except +
    fn f64 fabs(f64 x) except +
    fn f128 fabs(f128 x) except +
    fn f32 fabsf(f32 x) except +
    fn f128 fabsl(f128 x) except +

    fn f32 hypot(f32 x, f32 y) except +
    fn f64 hypot(f64 x, f64 y) except +
    fn f128 hypot(f128 x, f128 y) except +
    fn f32 hypotf(f32 x, f32 y) except +
    fn f128 hypotl(f128 x, f128 y) except +

    # C++17 three-dimensional hypotenuse
    fn f32 hypot(f32 x, f32 y, f32 z) except +
    fn f64 hypot(f64 x, f64 y, f64 z) except +
    fn f128 hypot(f128 x, f128 y, f128 z) except +

    fn f32 pow(f32 x, f32 y) except +
    fn f64 pow(f64 x, f64 y) except +
    fn f128 pow(f128 x, f128 y) except +
    fn f32 powf(f32 x, f32 y) except +
    fn f128 powl(f128 x, f128 y) except +

    fn f32 sqrt(f32 x) except +
    fn f64 sqrt(f64 x) except +
    fn f128 sqrt(f128 x) except +
    fn f32 sqrtf(f32 x) except +
    fn f128 sqrtl(f128 x) except +

    fn f32 erf(f32 x) except +
    fn f64 erf(f64 x) except +
    fn f128 erf(f128 x) except +
    fn f32 erff(f32 x) except +
    fn f128 erfl(f128 x) except +

    fn f32 erfc(f32 x) except +
    fn f64 erfc(f64 x) except +
    fn f128 erfc(f128 x) except +
    fn f32 erfcf(f32 x) except +
    fn f128 erfcl(f128 x) except +

    fn f32 lgamma(f32 x) except +
    fn f64 lgamma(f64 x) except +
    fn f128 lgamma(f128 x) except +
    fn f32 lgammaf(f32 x) except +
    fn f128 lgammal(f128 x) except +

    fn f32 tgamma(f32 x) except +
    fn f64 tgamma(f64 x) except +
    fn f128 tgamma(f128 x) except +
    fn f32 tgammaf(f32 x) except +
    fn f128 tgammal(f128 x) except +

    fn f32 ceil(f32 x) except +
    fn f64 ceil(f64 x) except +
    fn f128 ceil(f128 x) except +
    fn f32 ceilf(f32 x) except +
    fn f128 ceill(f128 x) except +

    fn f32 floor(f32 x) except +
    fn f64 floor(f64 x) except +
    fn f128 floor(f128 x) except +
    fn f32 floorf(f32 x) except +
    fn f128 floorl(f128 x) except +

    fn f32 nearbyint(f32 x) except +
    fn f64 nearbyint(f64 x) except +
    fn f128 nearbyint(f128 x) except +
    fn f32 nearbyintf(f32 x) except +
    fn f128 nearbyintl(f128 x) except +

    fn f32 rint(f32 x) except +
    fn f64 rint(f64 x) except +
    fn f128 rint(f128 x) except +
    fn f32 rintf(f32 x) except +
    fn f128 rintl(f128 x) except +

    fn i64 lrint(f32 x) except +
    fn i64 lrint(f64 x) except +
    fn i64 lrint(f128 x) except +
    fn i64 lrintf(f32 x) except +
    fn i64 lrintl(f128 x) except +

    fn i128 llrint(f32 x) except +
    fn i128 llrint(f64 x) except +
    fn i128 llrint(f128 x) except +
    fn i128 llrintf(f32 x) except +
    fn i128 llrintl(f128 x) except +

    fn f32 round(f32 x) except +
    fn f64 round(f64 x) except +
    fn f128 round(f128 x) except +
    fn f32 roundf(f32 x) except +
    fn f128 roundl(f128 x) except +

    fn i64 lround(f32 x) except +
    fn i64 lround(f64 x) except +
    fn i64 lround(f128 x) except +
    fn i64 lroundf(f32 x) except +
    fn i64 lroundl(f128 x) except +

    fn i128 llround(f32 x) except +
    fn i128 llround(f64 x) except +
    fn i128 llround(f128 x) except +
    fn i128 llroundf(f32 x) except +
    fn i128 llroundl(f128 x) except +

    fn f32 trunc(f32 x) except +
    fn f64 trunc(f64 x) except +
    fn f128 trunc(f128 x) except +
    fn f32 truncf(f32 x) except +
    fn f128 truncl(f128 x) except +

    fn f32 fmod(f32 x, f32 y) except +
    fn f64 fmod(f64 x, f64 y) except +
    fn f128 fmod(f128 x, f128 y) except +
    fn f32 fmodf(f32 x, f32 y) except +
    fn f128 fmodl(f128 x, f128 y) except +

    fn f32 remainder(f32 x, f32 y) except +
    fn f64 remainder(f64 x, f64 y) except +
    fn f128 remainder(f128 x, f128 y) except +
    fn f32 remainderf(f32 x, f32 y) except +
    fn f128 remainderl(f128 x, f128 y) except +

    fn f32 remquo(f32 x, f32 y, i32* quo) except +
    fn f64 remquo(f64 x, f64 y, i32* quo) except +
    fn f128 remquo(f128 x, f128 y, i32* quo) except +
    fn f32 remquof(f32 x, f32 y, i32* quo) except +
    fn f128 remquol(f128 x, f128 y, i32* quo) except +

    fn f32 copysign(f32 x, f32 y) except +
    fn f64 copysign(f64 x, f64 y) except +
    fn f128 copysign(f128 x, f128 y) except +
    fn f32 copysignf(f32 x, f32 y) except +
    fn f128 copysignl(f128 x, f128 y) except +

    fn f64 nan(r&char tagp) except +
    fn f32 nanf(r&char tagp) except +
    fn f128 nanl(r&char tagp) except +

    fn f32 nextafter(f32 x, f32 y) except +
    fn f64 nextafter(f64 x, f64 y) except +
    fn f128 nextafter(f128 x, f128 y) except +
    fn f32 nextafterf(f32 x, f32 y) except +
    fn f128 nextafterl(f128 x, f128 y) except +

    fn f32 nexttoward(f32 x, f128 y) except +
    fn f64 nexttoward(f64 x, f128 y) except +
    fn f128 nexttoward(f128 x, f128 y) except +
    fn f32 nexttowardf(f32 x, f128 y) except +
    fn f128 nexttowardl(f128 x, f128 y) except +

    fn f32 fdim(f32 x, f32 y) except +
    fn f64 fdim(f64 x, f64 y) except +
    fn f128 fdim(f128 x, f128 y) except +
    fn f32 fdimf(f32 x, f32 y) except +
    fn f128 fdiml(f128 x, f128 y) except +

    fn f32 fmax(f32 x, f32 y) except +
    fn f64 fmax(f64 x, f64 y) except +
    fn f128 fmax(f128 x, f128 y) except +
    fn f32 fmaxf(f32 x, f32 y) except +
    fn f128 fmaxl(f128 x, f128 y) except +

    fn f32 fmin(f32 x, f32 y) except +
    fn f64 fmin(f64 x, f64 y) except +
    fn f128 fmin(f128 x, f128 y) except +
    fn f32 fminf(f32 x, f32 y) except +
    fn f128 fminl(f128 x, f128 y) except +

    fn f32 fma(f32 x, f32 y, f32 z) except +
    fn f64 fma(f64 x, f64 y, f64 z) except +
    fn f128 fma(f128 x, f128 y, f128 z) except +
    fn f32 fmaf(f32 x, f32 y, f32 z) except +
    fn f128 fmal(f128 x, f128 y, f128 z) except +

    # C++20 linear interpolation
    fn f32 lerp(f32 a, f32 b, f32 t)
    fn f64 lerp(f64 a, f64 b, f64 t)
    fn f128 lerp(f128 a, f128 b, f128 t)

    # classification / comparison functions
    fn i32 fpclassify(f32 x) except +
    fn i32 fpclassify(f64 x) except +
    fn i32 fpclassify(f128 x) except +

    fn u2 isfinite(f32 x) except +
    fn u2 isfinite(f64 x) except +
    fn u2 isfinite(f128 x) except +

    fn u2 isinf(f32 x) except +
    fn u2 isinf(f64 x) except +
    fn u2 isinf(f128 x) except +

    fn u2 isnan(f32 x) except +
    fn u2 isnan(f64 x) except +
    fn u2 isnan(f128 x) except +

    fn u2 isnormal(f32 x) except +
    fn u2 isnormal(f64 x) except +
    fn u2 isnormal(f128 x) except +

    fn u2 signbit(f32 x) except +
    fn u2 signbit(f64 x) except +
    fn u2 signbit(f128 x) except +

    fn u2 isgreater(f32 x, f32 y) except +
    fn u2 isgreater(f64 x, f64 y) except +
    fn u2 isgreater(f128 x, f128 y) except +

    fn u2 isgreaterequal(f32 x, f32 y) except +
    fn u2 isgreaterequal(f64 x, f64 y) except +
    fn u2 isgreaterequal(f128 x, f128 y) except +

    fn u2 isless(f32 x, f32 y) except +
    fn u2 isless(f64 x, f64 y) except +
    fn u2 isless(f128 x, f128 y) except +

    fn u2 islessequal(f32 x, f32 y) except +
    fn u2 islessequal(f64 x, f64 y) except +
    fn u2 islessequal(f128 x, f128 y) except +

    fn u2 islessgreater(f32 x, f32 y) except +
    fn u2 islessgreater(f64 x, f64 y) except +
    fn u2 islessgreater(f128 x, f128 y) except +

    fn u2 isunordered(f32 x, f32 y) except +
    fn u2 isunordered(f64 x, f64 y) except +
    fn u2 isunordered(f128 x, f128 y) except +

    # C++17 mathematical special functions

    # associated Laguerre polynomials
    fn f64          assoc_laguerre(u32 n, u32 m, f64 x) except +
    fn f32          assoc_laguerref(u32 n, u32 m, f32 x) except +
    fn f128  assoc_laguerrel(u32 n, u32 m, f128 x) except +

    # associated Legendre functions
    fn f64          assoc_legendre(u32 l, u32 m, f64 x) except +
    fn f32          assoc_legendref(u32 l, u32 m, f32 x) except +
    fn f128  assoc_legendrel(u32 l, u32 m, f128 x) except +

    # beta function
    fn f64          beta(f64 x, f64 y) except +
    fn f32          betaf(f32 x, f32 y) except +
    fn f128  betal(f128 x, f128 y) except +

    # complete elliptic integral of the first kind
    fn f64          comp_ellint_1(f64 k) except +
    fn f32          comp_ellint_1f(f32 k) except +
    fn f128  comp_ellint_1l(f128 k) except +

    # complete elliptic integral of the second kind
    fn f64          comp_ellint_2(f64 k) except +
    fn f32          comp_ellint_2f(f32 k) except +
    fn f128  comp_ellint_2l(f128 k) except +

    # complete elliptic integral of the third kind
    fn f64          comp_ellint_3(f64 k, f64 nu) except +
    fn f32          comp_ellint_3f(f32 k, f32 nu) except +
    fn f128  comp_ellint_3l(f128 k, f128 nu) except +

    # regular modified cylindrical Bessel functions
    fn f64          cyl_bessel_i(f64 nu, f64 x) except +
    fn f32          cyl_bessel_if(f32 nu, f32 x) except +
    fn f128  cyl_bessel_il(f128 nu, f128 x) except +

    # cylindrical Bessel functions of the first kind
    fn f64          cyl_bessel_j(f64 nu, f64 x) except +
    fn f32          cyl_bessel_jf(f32 nu, f32 x) except +
    fn f128  cyl_bessel_jl(f128 nu, f128 x) except +

    # irregular modified cylindrical Bessel functions
    fn f64          cyl_bessel_k(f64 nu, f64 x) except +
    fn f32          cyl_bessel_kf(f32 nu, f32 x) except +
    fn f128  cyl_bessel_kl(f128 nu, f128 x) except +

    # cylindrical Neumann functions
    # cylindrical Bessel functions of the second kind
    fn f64          cyl_neumann(f64 nu, f64 x) except +
    fn f32          cyl_neumannf(f32 nu, f32 x) except +
    fn f128  cyl_neumannl(f128 nu, f128 x) except +

    # incomplete elliptic integral of the first kind
    fn f64          ellint_1(f64 k, f64 phi) except +
    fn f32          ellint_1f(f32 k, f32 phi) except +
    fn f128  ellint_1l(f128 k, f128 phi) except +

    # incomplete elliptic integral of the second kind
    fn f64          ellint_2(f64 k, f64 phi) except +
    fn f32          ellint_2f(f32 k, f32 phi) except +
    fn f128  ellint_2l(f128 k, f128 phi) except +

    # incomplete elliptic integral of the third kind
    fn f64          ellint_3(f64 k, f64 nu, f64 phi) except +
    fn f32          ellint_3f(f32 k, f32 nu, f32 phi) except +
    fn f128  ellint_3l(f128 k, f128 nu, f128 phi) except +

    # exponential integral
    fn f64          expint(f64 x) except +
    fn f32          expintf(f32 x) except +
    fn f128  expintl(f128 x) except +

    # Hermite polynomials
    fn f64          hermite(u32 n, f64 x) except +
    fn f32          hermitef(u32 n, f32 x) except +
    fn f128  hermitel(u32 n, f128 x) except +

    # Laguerre polynomials
    fn f64          laguerre(u32 n, f64 x) except +
    fn f32          laguerref(u32 n, f32 x) except +
    fn f128  laguerrel(u32 n, f128 x) except +

    # Legendre polynomials
    fn f64          legendre(u32 l, f64 x) except +
    fn f32          legendref(u32 l, f32 x) except +
    fn f128  legendrel(u32 l, f128 x) except +

    # Riemann zeta function
    fn f64          riemann_zeta(f64 x) except +
    fn f32          riemann_zetaf(f32 x) except +
    fn f128  riemann_zetal(f128 x) except +

    # spherical Bessel functions of the first kind
    fn f64          sph_bessel(u32 n, f64 x) except +
    fn f32          sph_besself(u32 n, f32 x) except +
    fn f128  sph_bessell(u32 n, f128 x) except +

    # spherical associated Legendre functions
    fn f64          sph_legendre(u32 l, u32 m, f64 theta) except +
    fn f32          sph_legendref(u32 l, u32 m, f32 theta) except +
    fn f128  sph_legendrel(u32 l, u32 m, f128 theta) except +

    # spherical Neumann functions
    # spherical Bessel functions of the second kind
    fn f64          sph_neumann(u32 n, f64 x) except +
    fn f32          sph_neumannf(u32 n, f32 x) except +
    fn f128  sph_neumannl(u32 n, f128 x) except +
