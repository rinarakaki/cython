# mode: compile

enum E:
    Spam, Eggs

fn E f() except E::Spam:
    return E::Eggs

f()
