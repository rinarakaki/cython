# cython: c_string_type=unicode, c_string_encoding=ascii

fn func():
    ustring = u'abc'
    let r&i8 s = ustring
    return s[0]    # returns u'a'
