use cython

ctypedef fused bunch_of_types:
    bytes
    i32
    f32

ctypedef fused string_t:
    cython.p_char
    bytes
    unicode

fn cython.integral myfunc(cython.integral i, bunch_of_types s):
    # Only one of these branches will be compiled for each specialization!
    if cython.integral is int:
        print('i is int')
    elif cython.integral is long:
        print('i is long')
    else:
        print('i is short')

    if bunch_of_types in string_t:
        print("s is a string!")
    return i * 2

myfunc(5i32, b'm')  # will print "i is an int" and "s is a string"
myfunc(5i64, 3)    # will print "i is a long"
myfunc(5i16, 3)   # will print "i is a short"
