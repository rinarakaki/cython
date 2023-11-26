# mode: error

struct Spam

extern fn i32 spam(void)            # function argument cannot be void
extern fn i32 grail(i32 i, void v)  # function argument cannot be void
fn i32 tomato(Spam s):                # incomplete type
    pass

_ERRORS = u"""
5:19: Use spam() rather than spam(void) to declare a function with no arguments.
6:27: Use spam() rather than spam(void) to declare a function with no arguments.
7:14: Argument type 'Spam' is incomplete
"""
