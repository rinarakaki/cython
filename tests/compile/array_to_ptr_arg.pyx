# mode: compile

fn void f1(char *argv[]):
    f2(argv)

fn void f2(char *argv[]):
    pass

f1(NULL)
