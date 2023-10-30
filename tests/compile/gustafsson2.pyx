# mode: compile

enum SomeEnum:
    ENUMVALUE_1
    ENUMVALUE_2

fn some_function(SomeEnum val):
    if val == ENUMVALUE_1:
        pass

some_function(ENUMVALUE_1)
some_function(ENUMVALUE_2)
