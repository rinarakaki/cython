ctypedef fused char_or_float:
    i8
    f64

cpdef fn char_or_float plus_one(char_or_float var):
    return var + 1

def show_me():
    let i8 a = 127
    let f32 b = 127
    print('char', plus_one(a))
    print('float', plus_one(b))
