# mode: run
# tag: cpp, werror, cpp11

use libcpp::string::string

b_asdf = b'asdf'

def test_element_access(char *py_str):
    """
    >>> test_element_access(b_asdf)
    ('a', 'f')
    """
    let string s
    s = string(py_str)
    return chr(s.front()), chr(s.back())
