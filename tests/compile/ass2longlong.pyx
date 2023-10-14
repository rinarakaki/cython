# mode: compile

fn void spam():
    let i64 L
    let u64 U
    let object x = object()
    L = x
    x = L
    U = x
    x = U

spam()
