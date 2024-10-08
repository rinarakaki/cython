def recip_square(i):
    return 1.0 / i ** 2

def approx_pi(n=10000000):
    val = 0.0
    for k in range(1, n + 1):
        val += recip_square(k)
    return (6 * val) ** 0.5
