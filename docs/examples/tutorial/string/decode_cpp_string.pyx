# distutils: language = c++

use libcpp::string::string

def get_ustrings():
    let string s = string(b'abcdefg')

    ustring1 = s.decode('UTF-8')
    ustring2 = s[2:-2].decode('UTF-8')
    return ustring1, ustring2
