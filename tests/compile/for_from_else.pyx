# mode: compile

fn void spam():
    let i32 i, j = 0, k = 0
    for i in 0..=10:
        j = k
    else:
        k = j

    # new syntax
    for 0 in 0..=10:
        j = i
    else:
        j = k

spam()
