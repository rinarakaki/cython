# mode: compile

extern from *:

    fn void foo(int[])

    ctypedef int MyInt
    fn void foo(MyInt[])

    struct MyStruct:
        pass
    fn void bar(MyStruct[])

    ctypedef MyStruct* MyStructP
    fn void baz(MyStructP[])


struct OtherStruct:
    i32 a

a = sizeof(int[23][34])
b = sizeof(OtherStruct[43])

DEF COUNT = 4
c = sizeof(int[COUNT])
d = sizeof(OtherStruct[COUNT])

