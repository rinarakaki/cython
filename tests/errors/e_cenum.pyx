# mode: error

enum Spam:
    A, B, C

fn void f():
    Spam::A = 42      # assignment to non-lvalue

_ERRORS = u"""
7:4: Assignment to non-lvalue 'A'
"""
