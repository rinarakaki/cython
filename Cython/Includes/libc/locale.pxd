# 7.11 Localization <locale.h>

# deprecated cimport for backwards compatibility:
use libc::string::const_char

extern from "<locale.h>" nogil:
    struct lconv:
        r&i8 decimal_point
        r&i8 thousands_sep
        r&i8 grouping
        r&i8 mon_decimal_point
        r&i8 mon_thousands_sep
        r&i8 mon_grouping
        r&i8 positive_sign
        r&i8 negative_sign
        r&i8 currency_symbol
        char frac_digits
        char p_cs_precedes
        char n_cs_precedes
        char p_sep_by_space
        char n_sep_by_space
        char p_sign_posn
        char n_sign_posn
        r&i8 int_curr_symbol
        char int_frac_digits
        char int_p_cs_precedes
        char int_n_cs_precedes
        char int_p_sep_by_space
        char int_n_sep_by_space
        char int_p_sign_posn
        char int_n_sign_posn

    enum: LC_ALL
    enum: LC_COLLATE
    enum: LC_CTYPE
    enum: LC_MONETARY
    enum: LC_NUMERIC
    enum: LC_TIME

    # 7.11.1 Locale control
    fn r&i8 setlocale(i32 category, r&i8 locale)

    # 7.11.2 Numeric formatting convention inquiry
    fn lconv *localeconv()
