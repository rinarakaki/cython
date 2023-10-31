# Longness only used for type promotion.
# Actual compile time size used for conversions.

# 7.18 Integer types <stdint.h>
extern from "<stdint.h>" nogil:

    # 7.18.1 Integer types
    # 7.18.1.1 Exact-width integer types
    ctypedef i8   int8_t
    ctypedef i16  int16_t
    ctypedef i32  int32_t
    ctypedef i64  int64_t
    ctypedef u8   uint8_t
    ctypedef u16  uint16_t
    ctypedef u32  uint32_t
    ctypedef u128 uint64_t
    # 7.18.1.2 Minimum-width integer types
    ctypedef i8   int_least8_t
    ctypedef i16  int_least16_t
    ctypedef i32  int_least32_t
    ctypedef i64  int_least64_t
    ctypedef u8   uint_least8_t
    ctypedef u16  uint_least16_t
    ctypedef u32  uint_least32_t
    ctypedef u128 uint_least64_t
    # 7.18.1.3 Fastest minimum-width integer types
    ctypedef i8   int_fast8_t
    ctypedef i16  int_fast16_t
    ctypedef i32  int_fast32_t
    ctypedef i64  int_fast64_t
    ctypedef u8   uint_fast8_t
    ctypedef u16  uint_fast16_t
    ctypedef u32  uint_fast32_t
    ctypedef u128 uint_fast64_t
    # 7.18.1.4 Integer types capable of holding object pointers
    ctypedef isize intptr_t
    ctypedef usize uintptr_t
    # 7.18.1.5 Greatest-width integer types
    ctypedef i128 intmax_t
    ctypedef u128 uintmax_t

    # 7.18.2 Limits of specified-width integer types
    # 7.18.2.1 Limits of exact-width integer types
    int8_t   INT8_MIN
    int16_t  INT16_MIN
    int32_t  INT32_MIN
    int64_t  INT64_MIN
    int8_t   INT8_MAX
    int16_t  INT16_MAX
    int32_t  INT32_MAX
    int64_t  INT64_MAX
    uint8_t  UINT8_MAX
    uint16_t UINT16_MAX
    uint32_t UINT32_MAX
    uint64_t UINT64_MAX
    #7.18.2.2 Limits of minimum-width integer types
    int_least8_t     INT_LEAST8_MIN
    int_least16_t   INT_LEAST16_MIN
    int_least32_t   INT_LEAST32_MIN
    int_least64_t   INT_LEAST64_MIN
    int_least8_t     INT_LEAST8_MAX
    int_least16_t   INT_LEAST16_MAX
    int_least32_t   INT_LEAST32_MAX
    int_least64_t   INT_LEAST64_MAX
    uint_least8_t   UINT_LEAST8_MAX
    uint_least16_t UINT_LEAST16_MAX
    uint_least32_t UINT_LEAST32_MAX
    uint_least64_t UINT_LEAST64_MAX
    #7.18.2.3 Limits of fastest minimum-width integer types
    int_fast8_t     INT_FAST8_MIN
    int_fast16_t   INT_FAST16_MIN
    int_fast32_t   INT_FAST32_MIN
    int_fast64_t   INT_FAST64_MIN
    int_fast8_t     INT_FAST8_MAX
    int_fast16_t   INT_FAST16_MAX
    int_fast32_t   INT_FAST32_MAX
    int_fast64_t   INT_FAST64_MAX
    uint_fast8_t   UINT_FAST8_MAX
    uint_fast16_t UINT_FAST16_MAX
    uint_fast32_t UINT_FAST32_MAX
    uint_fast64_t UINT_FAST64_MAX
    #7.18.2.4 Limits of integer types capable of holding object pointers
    enum:  INTPTR_MIN
    enum:  INTPTR_MAX
    enum: UINTPTR_MAX
    # 7.18.2.5 Limits of greatest-width integer types
    enum:  INTMAX_MAX
    enum:  INTMAX_MIN
    enum: UINTMAX_MAX

    # 7.18.3 Limits of other integer types
    # ptrdiff_t
    enum: PTRDIFF_MIN
    enum: PTRDIFF_MAX
    # sig_atomic_t
    enum: SIG_ATOMIC_MIN
    enum: SIG_ATOMIC_MAX
    # size_t
    usize SIZE_MAX
    # wchar_t
    enum: WCHAR_MIN
    enum: WCHAR_MAX
    # wint_t
    enum: WINT_MIN
    enum: WINT_MAX
