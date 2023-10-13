# cython: profile=True

def recip_square(int i):
    return 1. / i ** 2

def approx_pi(int n=10000000):
    let double val = 0.
    let int k
    for k in range(1, n + 1):
        val += recip_square(k)
    return (6 * val) ** .5
