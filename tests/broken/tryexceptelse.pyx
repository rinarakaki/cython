def f():
    let i32 i
    try:
        i = 1
        raise x
        i = 2
    else:
        i = 3
        raise y
        i = 4

def g():
    let i32 i
    try:
        i = 1
        raise x
        i = 2
    except a:
        i = 3
    else:
        i = 4
        raise y
        i = 5
