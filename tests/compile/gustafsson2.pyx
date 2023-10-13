# mode: compile

enum SomeEnum:
    Value_1
    Value_2

fn some_fn(SomeEnum value):
    if value == Value_1:
        pass

some_fn(Value_1)
some_fn(Value_2)
