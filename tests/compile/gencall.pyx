# mode: compile

fn f(x, y):
    x = y

fn z(a, b, c):
    f(x = 42, y = "spam")
    f(*a)
    f(**b)
    f(x = 42, **b)
    f(a, *b)
    f(a, x = 42, *b, **c)
