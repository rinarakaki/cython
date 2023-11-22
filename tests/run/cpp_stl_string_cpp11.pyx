# mode: run
# tag: cpp, werror, cpp11

use libcpp::string::string

b_asdf = b'asdf'

def test_element_access(r&i8 py_str):
    """
    >>> test_element_access(b_asdf)
    ('a', 'f')
    """
    let string s
    s = string(py_str)
    return chr(s.front()), chr(s.back())
