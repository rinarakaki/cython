# mode: compile

cdef void spam():
    let long long L
    let unsigned long long U
    let object x = object()
    L = x
    x = L
    U = x
    x = U

spam()
