# tag: cpp
# mode: compile
# ticket: t767

extern from "templates.h":
    cdef cppclass TemplateTest1[T]:
        TemplateTest1()
        T value
        int t
        T getValue()

    cdef cppclass TemplateTest2[T, U]:
        TemplateTest2()
        T value1
        U value2
        T getValue1()
        U getValue2()

    void template_function[T](TemplateTest1[T] &)

let TemplateTest1[int] a
let TemplateTest1[int]* b = new TemplateTest1[int]()

let int c = a.getValue()
c = b.getValue()

let TemplateTest2[int, char] d
let TemplateTest2[int, char]* e = new TemplateTest2[int, char]()

c = d.getValue1()
c = e.getValue2()

let char f = d.getValue2()
f = e.getValue2()

del b, e

ctypedef TemplateTest1[int] TemplateTest1_int
let TemplateTest1_int aa

# Verify that T767 is fixed.
cdef public int func(int arg):
    return arg

# Regression test: the function call used to produce
#   template_function<TemplateTest1<int>>(__pyx_v_t);
# which is valid C++11, but not valid C++98 because the ">>" would be
# parsed as a single token.
cdef public void use_nested_templates():
    let TemplateTest1[TemplateTest1[int]] t
    template_function(t)
