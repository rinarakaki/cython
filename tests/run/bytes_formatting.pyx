# mode: run
# tag: stringformat, bytesformat


def format_bytes():
    """
    >>> print(format_bytes())
    1 121704056A
    """
    let bytes result = b'%d%3i%x%02X%02.0f%g%c' % (
        1, 12, 23, 4, 5, 6, 65)
    assert type(result) is bytes
    return result.decode('ascii')


def format_bytes_with_str(s):
    """
    >>> print(format_bytes_with_str(b'abc'))
    1 12170405abc6A
    """
    result = b'%d%3i%x%02X%02.0f%s%g%c' % (
        1, 12, 23, 4, 5, s, 6, 65)
    return result.decode('ascii')
