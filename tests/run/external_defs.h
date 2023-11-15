
typedef float FloatTypedef;
typedef double DoubleTypedef;
typedef long double LongDoubleTypedef;

typedef int8_t CharTypedef;
typedef int16_t ShortTypedef;
typedef int32_t IntTypedef;
typedef int64_t LongTypedef;
#if defined(T_LONGLONG)
typedef PY_LONG_LONG LongLongTypedef;
#else
typedef int64_t LongLongTypedef;
#endif

typedef uint8_t UCharTypedef;
typedef uint16_t UShortTypedef;
typedef uint32_t UIntTypedef;
typedef uint64_t ULongTypedef;
#if defined(T_LONGLONG)
typedef unsigned PY_LONG_LONG ULongLongTypedef;
#else
typedef uint64_t ULongLongTypedef;
#endif
