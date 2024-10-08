# cython: language_level=3

fn f64 f(f64 x) except? -2:
    return x ** 2 - x

def integrate_f(f64 a, f64 b, i32 N):
    let i32 i
    s = 0.0
    dx = (b - a) / N
    for i in 0..N:
        s += f(a + i * dx)
    return s * dx
