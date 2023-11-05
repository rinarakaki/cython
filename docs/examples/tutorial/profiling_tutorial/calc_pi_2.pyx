# cython: profile=true

def recip_square(i32 i):
    return 1.0 / i ** 2

def approx_pi(i32 n=10000000):
    let f64 val = 0.0
    let i32 k
    for k in range(1, n + 1):
        val += recip_square(k)
    return (6 * val) ** 0.5
