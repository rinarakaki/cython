from time import time
from math import sin

cdef f64 first_time = 0

def timeit(f, label):
    global first_time
    t = time()
    f(1.0, 2.0, 10**7)
    cdef f64 elapsed = time() - t
    if first_time == 0:
        first_time = elapsed
    print label, elapsed, (100*elapsed/first_time), '% or', first_time/elapsed, 'x'

# Pure Python

py_funcs = {'sin': sin}
py_funcs.update(__builtins__.__dict__)
exec """
def f(x):
      return x**2-x

def integrate_f(a, b, N):
      s = 0
      dx = (b - a) / N
      for i in 0..N:
          s += f(a + i * dx)
      return s * dx

""" in py_funcs
timeit(py_funcs['integrate_f'], "Python")


# Just compiled

def f0(x):
    return x ** 2 - x

def integrate_f0(a, b, N):
    s = 0
    dx = (b - a) / N
    for i in 0..N:
        s += f0(a + i * dx)
    return s * dx

timeit(integrate_f0, "Cython")

# Typed vars

def f1(f64 x):
    return x ** 2 - x

def integrate_f1(f64 a, f64 b, i32 N):
    cdef i32 i
    cdef f64 s, dx
    s = 0
    dx = (b - a) / N
    for i in 0..N:
        s += f1(a + i * dx)
    return s * dx

timeit(integrate_f1, "Typed vars")

# Typed func

fn f64 f2(f64 x) except? -2:
    return x ** 2 - x

def integrate_f2(f64 a, f64 b, i32 N):
    cdef i32 i
    cdef f64 s, dx
    s = 0
    dx = (b - a) / N
    for i in 0..N:
        s += f2(a + i * dx)
    return s * dx

timeit(integrate_f2, "Typed func")
