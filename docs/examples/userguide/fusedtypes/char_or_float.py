char_or_float = cython.fused_type(cython.i8, cython.f64)


@cython.ccall
def plus_one(var: char_or_float) -> char_or_float:
    return var + 1

def show_me():
    a: cython.i8 = 127
    b: cython.f64 = 127
    print('char', plus_one(a))
    print('float', plus_one(b))
