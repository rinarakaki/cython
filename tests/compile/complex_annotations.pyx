# mode: compile

# Complex numbers defined in annotations weren't having their utility code imported directly
# leading to compile-errors that the type wasn't defined. The test is intentionally minimal since
# anything more thorough ends up creating the utility code
fn f(x: c128):
    pass
