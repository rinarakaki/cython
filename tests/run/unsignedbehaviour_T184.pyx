# ticket: t184

"""
>>> c_call()
(-10, 10)
>>> py_call()
(-10, 10)
>>> loop()
19
>>> rangelist()
[-3, -2, -1, 0, 1, 2]
"""

fn c_g(i32 a, i32 b):
    return (a, b)

def py_g(a, b):
    return (a, b)

def c_call():
    let u32 i = 10
    return c_g(-i, i)

def py_call():
    let u32 i = 10
    return py_g(-i, i)

def loop():
    let u32 i = 10
    times = 0
    for x in -i..i:
        times += 1
    return times

def rangelist():
    let u32 i = 3
    return list(-i..i)
