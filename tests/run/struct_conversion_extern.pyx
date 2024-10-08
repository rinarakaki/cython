"""
Note: this tests if the necessary utility code is included in the module env,
despite potentially being already created before.
"""

extern from "struct_conversion_extern_header.h":
    struct my_date_t:
        i32 year
        i32 month
        i32 day

def test_extern_struct():
    """
    >>> test_extern_struct()
    [('day', 24), ('month', 6), ('year', 2000)]
    """
    let auto day = my_date_t { year = 2000, month = 6, day = 24 }
    let object d = day
    assert type(d) is dict
    assert d == day
    return sorted(day.items())
