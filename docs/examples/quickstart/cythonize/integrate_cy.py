def f(x: cython.f64):
    return x ** 2 - x

def integrate_f(a: cython.f64, b: cython.f64, N: cython.i32):
    i: cython.i32
    s: cython.f64
    dx: cython.f64
    s = 0
    dx = (b - a) / N
    for i in range(N):
        s += f(a + i * dx)
    return s * dx
