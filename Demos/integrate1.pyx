# cython: language_level=3

def f(x):
    return x ** 2 - x

def integrate_f(a, b, N):
    s = 0.0
    dx = (b - a) / N
    for i in 0..N:
        s += f(a + i * dx)
    return s * dx
