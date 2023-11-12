# NumPy math library
#
# This exports the functionality of the NumPy core math library, aka npymath,
# which provides implementations of C99 math functions and macros for system
# with a C89 library (such as MSVC). npymath is available with NumPy >=1.3,
# although some functions will require later versions. The spacing function is
# not in C99, but comes from Fortran.
#
# On the Cython side, the npymath functions are available without the "npy_"
# prefix that they have in C, to make this is a drop-in replacement for
# libc.math. The same is true for the constants, where possible.
#
# See the NumPy documentation for linking instructions.
#
# Complex number support and NumPy 2.0 half-precision functions are currently
# not exported.
#
# Author: Lars Buitinck

extern from "numpy/npy_math.h" nogil:
    # Floating-point classification
    static f128 NAN "NPY_NAN"
    static f128 INFINITY "NPY_INFINITY"
    static f128 PZERO "NPY_PZERO"        # positive zero
    static f128 NZERO "NPY_NZERO"        # negative zero

    # These four are actually macros and work on any floating-point type.
    fn i32 isinf "npy_isinf"(f128)  # -1 / 0 / 1
    fn u2 isfinite "npy_isfinite"(f128)
    fn u2 isnan "npy_isnan"(f128)
    fn u2 signbit "npy_signbit"(f128)

    # Math constants
    static f128 E "NPY_E"
    static f128 LOG2E "NPY_LOG2E"       # ln(e) / ln(2)
    static f128 LOG10E "NPY_LOG10E"     # ln(e) / ln(10)
    static f128 LOGE2 "NPY_LOGE2"       # ln(2)
    static f128 LOGE10 "NPY_LOGE10"     # ln(10)
    static f128 PI "NPY_PI"
    static f128 PI_2 "NPY_PI_2"         # pi / 2
    static f128 PI_4 "NPY_PI_4"         # pi / 4
    static f128 NPY_1_PI                # 1 / pi; NPY_ because of ident syntax
    static f128 NPY_2_PI                # 2 / pi
    static f128 EULER "NPY_EULER"       # Euler constant (gamma, 0.57721)

    # Low-level floating point manipulation (NumPy >=1.4)
    fn f32 copysignf "npy_copysignf"(f32, f32)
    fn f32 nextafterf "npy_nextafterf"(f32 x, f32 y)
    fn f32 spacingf "npy_spacingf"(f32 x)
    fn f64 copysign "npy_copysign"(f64, f64)
    fn f64 nextafter "npy_nextafter"(f64 x, f64 y)
    fn f64 spacing "npy_spacing"(f64 x)
    fn f128 copysignl "npy_copysignl"(f128, f128)
    fn f128 nextafterl "npy_nextafterl"(f128 x, f128 y)
    fn f128 spacingl "npy_spacingl"(f128 x)

    # Float C99 functions
    fn f32 sinf "npy_sinf"(f32 x)
    fn f32 cosf "npy_cosf"(f32 x)
    fn f32 tanf "npy_tanf"(f32 x)
    fn f32 sinhf "npy_sinhf"(f32 x)
    fn f32 coshf "npy_coshf"(f32 x)
    fn f32 tanhf "npy_tanhf"(f32 x)
    fn f32 fabsf "npy_fabsf"(f32 x)
    fn f32 floorf "npy_floorf"(f32 x)
    fn f32 ceilf "npy_ceilf"(f32 x)
    fn f32 rintf "npy_rintf"(f32 x)
    fn f32 sqrtf "npy_sqrtf"(f32 x)
    fn f32 log10f "npy_log10f"(f32 x)
    fn f32 logf "npy_logf"(f32 x)
    fn f32 expf "npy_expf"(f32 x)
    fn f32 expm1f "npy_expm1f"(f32 x)
    fn f32 asinf "npy_asinf"(f32 x)
    fn f32 acosf "npy_acosf"(f32 x)
    fn f32 atanf "npy_atanf"(f32 x)
    fn f32 asinhf "npy_asinhf"(f32 x)
    fn f32 acoshf "npy_acoshf"(f32 x)
    fn f32 atanhf "npy_atanhf"(f32 x)
    fn f32 log1pf "npy_log1pf"(f32 x)
    fn f32 exp2f "npy_exp2f"(f32 x)
    fn f32 log2f "npy_log2f"(f32 x)
    fn f32 atan2f "npy_atan2f"(f32 x, f32 y)
    fn f32 hypotf "npy_hypotf"(f32 x, f32 y)
    fn f32 powf "npy_powf"(f32 x, f32 y)
    fn f32 fmodf "npy_fmodf"(f32 x, f32 y)
    fn f32 modff "npy_modff"(f32 x, f32* y)

    # Long double C99 functions
    fn f128 sinl "npy_sinl"(f128 x)
    fn f128 cosl "npy_cosl"(f128 x)
    fn f128 tanl "npy_tanl"(f128 x)
    fn f128 sinhl "npy_sinhl"(f128 x)
    fn f128 coshl "npy_coshl"(f128 x)
    fn f128 tanhl "npy_tanhl"(f128 x)
    fn f128 fabsl "npy_fabsl"(f128 x)
    fn f128 floorl "npy_floorl"(f128 x)
    fn f128 ceill "npy_ceill"(f128 x)
    fn f128 rintl "npy_rintl"(f128 x)
    fn f128 sqrtl "npy_sqrtl"(f128 x)
    fn f128 log10l "npy_log10l"(f128 x)
    fn f128 logl "npy_logl"(f128 x)
    fn f128 expl "npy_expl"(f128 x)
    fn f128 expm1l "npy_expm1l"(f128 x)
    fn f128 asinl "npy_asinl"(f128 x)
    fn f128 acosl "npy_acosl"(f128 x)
    fn f128 atanl "npy_atanl"(f128 x)
    fn f128 asinhl "npy_asinhl"(f128 x)
    fn f128 acoshl "npy_acoshl"(f128 x)
    fn f128 atanhl "npy_atanhl"(f128 x)
    fn f128 log1pl "npy_log1pl"(f128 x)
    fn f128 exp2l "npy_exp2l"(f128 x)
    fn f128 log2l "npy_log2l"(f128 x)
    fn f128 atan2l "npy_atan2l"(f128 x, f128 y)
    fn f128 hypotl "npy_hypotl"(f128 x, f128 y)
    fn f128 powl "npy_powl"(f128 x, f128 y)
    fn f128 fmodl "npy_fmodl"(f128 x, f128 y)
    fn f128 modfl "npy_modfl"(f128 x, f128* y)

    # NumPy extensions
    fn f32 deg2radf "npy_deg2radf"(f32 x)
    fn f32 rad2degf "npy_rad2degf"(f32 x)
    fn f32 logaddexpf "npy_logaddexpf"(f32 x, f32 y)
    fn f32 logaddexp2f "npy_logaddexp2f"(f32 x, f32 y)

    fn f64 deg2rad "npy_deg2rad"(f64 x)
    fn f64 rad2deg "npy_rad2deg"(f64 x)
    fn f64 logaddexp "npy_logaddexp"(f64 x, f64 y)
    fn f64 logaddexp2 "npy_logaddexp2"(f64 x, f64 y)

    fn f128 deg2radl "npy_deg2radl"(f128 x)
    fn f128 rad2degl "npy_rad2degl"(f128 x)
    fn f128 logaddexpl "npy_logaddexpl"(f128 x, f128 y)
    fn f128 logaddexp2l "npy_logaddexp2l"(f128 x, f128 y)
