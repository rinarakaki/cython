# mode: compile

enum SomeEnum:
    Var1
    Var2

fn some_function(SomeEnum val):
    if val == SomeEnum::Var1:
        pass

some_function(SomeEnum::Var1)
some_function(SomeEnum::Var2)
