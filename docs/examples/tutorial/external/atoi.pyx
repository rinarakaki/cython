use libc::stdlib::atoi

fn parse_charptr_to_py_int(r&char s):
    assert s is not NULL, "byte string value is NULL"
    return atoi(s)  # note: atoi() has no error detection!
