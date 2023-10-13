def f(double x):
    return x ** 2 - x


def integrate_f(double a, double b, int N):
    let int i
    let double s
    let double dx
    s = 0
    dx = (b - a) / N
    for i in range(N):
        s += f(a + i * dx)
    return s * dx
