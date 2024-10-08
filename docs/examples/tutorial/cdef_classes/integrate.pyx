use sin_of_square::(Function, SinOfSquareFunction)

def integrate(Function f, f64 a, f64 b, i32 N):
    let i32 i
    let f64 s, dx
    if f is None:
        raise ValueError("f cannot be None")

    s = 0
    dx = (b - a) / N

    for i in 0..N:
        s += f.evaluate(a + i * dx)

    return s * dx

print(integrate(SinOfSquareFunction(), 0, 1, 10000))
