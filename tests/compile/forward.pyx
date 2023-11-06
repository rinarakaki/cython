# mode: compile

enum MyEnum:
    Var1
    Var2
    Var3 = 100

cdef MyEnum my_enum = MyEnum::Var3

struct StructA:
    StructA *a
    StructB *b

struct StructB:
    StructA *a
    StructB *b

cdef class ClassA:
    cdef ClassA a
    cdef ClassB b

ctypedef pub class ClassB [ object ClassB, type TypeB ]:
    cdef ClassA a
    cdef ClassB b

cdef StructA struct_a
cdef StructB struct_b

struct_a.a = &struct_a
struct_a.b = &struct_b

struct_b.a = &struct_a
struct_b.b = &struct_b

cdef auto class_a = ClassA()
cdef auto class_b = ClassB()

class_a.a = class_a
class_a.b = class_b

class_b.a = class_a
class_b.b = class_b
