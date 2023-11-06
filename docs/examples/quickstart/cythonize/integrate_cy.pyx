fn f(f64 x):
    return x ** 2 - x

fn integrate_f(f64 a, f64 b, i32 N):
    let i32 i
    let f64 s
    let f64 dx
    s = 0
    dx = (b - a) / N
    for i in 0..N:
        s += f(a + i * dx)
    return s * dx
