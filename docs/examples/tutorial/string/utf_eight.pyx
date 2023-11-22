use libc::stdlib::free

fn unicode tounicode(r&i8 s):
    return s.decode('UTF-8', 'strict')

fn unicode tounicode_with_length(r&i8 s, usize length):
    return s[:length].decode('UTF-8', 'strict')

fn unicode tounicode_with_length_and_free(r&i8 s, usize length):
    try:
        return s[:length].decode('UTF-8', 'strict')
    finally:
        free(s)
