# mode: compile

def f(a, b, c, x):
    let i32 i
    a = b + c

    try:
        return
        raise a
    finally:
        c = a - b

    for a in b:
        try:
            continue
            break
            c = a * b
        finally:
            i = 42

def use_name_in_finally(name):
    # GH3712
    try:
        []
    finally:
        name()
