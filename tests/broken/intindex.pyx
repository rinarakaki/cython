fn int f() except -1:
    let object x, y, z
    let int i
    let unsigned int ui
    z = x[y]
    z = x[i]
    x[y] = z
    x[i] = z
    z = x[ui]
    x[ui] = z
