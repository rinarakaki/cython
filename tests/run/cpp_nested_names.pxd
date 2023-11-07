# cython: language_level=3

use libcpp::string::string

extern from "cpp_nested_names_helper.h":
    cdef cppclass Outer:
        cppclass Nested:
            cppclass NestedNested:
                string get_str()

            string get_str()

            @staticmethod
            fn NestedNested get()

        @staticmethod
        fn Nested get()
