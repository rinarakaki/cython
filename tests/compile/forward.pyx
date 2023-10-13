# mode: compile

enum MyEnum:
    Value1
    Value2
    Value3 = 100

let MyEnum my_enum = Value3

struct StructA:
    StructA *a
    StructB *b

struct StructB:
    StructA *a
    StructB *b

cdef class ClassA:
    let ClassA a
    let ClassB b

pub class ClassB [ object ClassB, type TypeB ]:
    let ClassA a
    let ClassB b


let StructA struct_a
let StructB struct_b

struct_a.a = &struct_a
struct_a.b = &struct_b

struct_b.a = &struct_a
struct_b.b = &struct_b

let ClassA class_a = ClassA()
let ClassB class_b = ClassB()

class_a.a = class_a
class_a.b = class_b

class_b.a = class_a
class_b.b = class_b
