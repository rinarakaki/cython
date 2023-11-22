use libc::stdlib::free

fn unicode tounicode(r&char s):
    return s.decode('UTF-8', 'strict')

fn unicode tounicode_with_length(r&char s, usize length):
    return s[:length].decode('UTF-8', 'strict')

fn unicode tounicode_with_length_and_free(r&char s, usize length):
    try:
        return s[:length].decode('UTF-8', 'strict')
    finally:
        free(s)
