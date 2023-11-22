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
        i8 frac_digits
        i8 p_cs_precedes
        i8 n_cs_precedes
        i8 p_sep_by_space
        i8 n_sep_by_space
        i8 p_sign_posn
        i8 n_sign_posn
        r&i8 int_curr_symbol
        i8 int_frac_digits
        i8 int_p_cs_precedes
        i8 int_n_cs_precedes
        i8 int_p_sep_by_space
        i8 int_n_sep_by_space
        i8 int_p_sign_posn
        i8 int_n_sign_posn

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
