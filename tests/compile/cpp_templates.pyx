# tag: cpp
# mode: compile
# ticket: t767

extern from "templates.h":
    cdef cppclass TemplateTest1[T]:
        TemplateTest1()
        T value
        i32 t
        fn T get_value()

    cdef cppclass TemplateTest2[T, U]:
        TemplateTest2()
        T value1
        U value2
        fn T get_value1()
        fn U get_value2()

    fn void template_function[T](TemplateTest1[T] &)

cdef TemplateTest1[i32] a
cdef TemplateTest1[i32]* b = new TemplateTest1[i32]()

cdef i32 c = a.getValue()
c = b.getValue()

cdef TemplateTest2[i32, i8] d
cdef TemplateTest2[i32, i8]* e = new TemplateTest2[i32, i8]()

c = d.get_value1()
c = e.get_value2()

cdef i8 f = d.get_value2()
f = e.get_value2()

del b, e

ctypedef TemplateTest1[i32] TemplateTest1_int
cdef TemplateTest1_int aa

# Verify that T767 is fixed.
pub fn i32 func(i32 arg):
    return arg

# Regression test: the function call used to produce
#   template_function<TemplateTest1<int>>(__pyx_v_t);
# which is valid C++11, but not valid C++98 because the ">>" would be
# parsed as a single token.
pub fn void use_nested_templates():
    let TemplateTest1[TemplateTest1[i32]] t
    template_function(t)
