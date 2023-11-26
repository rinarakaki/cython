
use cython
use cython::typeof

#[cython::test_assert_path_exists(
    "//NameNode[@name = 'st' and @type.is_string = true]",
    "//NameNode[@name = 'ust' and @type.is_string = true]",
    "//NameNode[@name = 'my_st' and @type.is_string = true]",
    "//NameNode[@name = 'my_ust' and @type.is_string = true]",
)]
def const_charptrs():
    """
    >>> const_charptrs()
    """
    let object obj
    let r&i8  st  = b"XYZ"
    let r&u8 ust = <r&u8>b"XYZ"  # needs cast to unsigned

    assert typeof(st) == "const char *", typeof(st)
    my_st = st
    assert typeof(my_st) == "const char *", typeof(my_st)
    obj = my_st
    assert obj == b"XYZ", obj

    assert typeof(ust) == "const unsigned char *", typeof(ust)
    my_ust = ust
    assert typeof(my_ust) == "const unsigned char *", typeof(my_ust)
    obj = my_ust
    assert obj == b"XYZ", obj

type mychar = i8
type myuchar = u8

def const_char_arrays():
    """
    >>> const_char_arrays()
    """
    let i32 i
    let object obj
    let mychar[4]  st
    let myuchar[4] ust
    let i8 ch

    i = 0
    for ch in b'XYZ\0':
        st[i] = ch
        ust[i] = <u8>ch
        i += 1

    assert typeof(st) == "mychar [4]", typeof(st)
    obj = st
    assert obj == b"XYZ", obj

    assert typeof(ust) == "myuchar [4]", typeof(ust)
    obj = ust
    assert obj == b"XYZ", obj
