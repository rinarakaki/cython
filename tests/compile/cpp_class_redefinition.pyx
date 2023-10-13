# mode: compile
# tag: cpp, warnings

extern from "templates.h":
    cdef cppclass TemplateTest1[T]:
        TemplateTest1()
        T value
        int t
        T getValue()

    let cppclass TemplateTest1[T]

