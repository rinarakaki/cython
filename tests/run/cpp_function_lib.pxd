from libcpp.functional cimport function

extern from "cpp_function_lib.cpp":
    # CPP is include here so that it doesn't need to be compiled externally
    pass

extern from "cpp_function_lib.h":
    fn f64 add_one(f64, i32)
    fn f64 add_two(f64 a, i32 b)

    cdef cppclass AddAnotherFunctor:
        fn AddAnotherFunctor(f64 to_add)
        fn f64 call "operator()"(f64 a, i32 b)

    cdef cppclass FunctionKeeper:
        fn FunctionKeeper(function[f64(f64, i32) noexcept] user_function)
        fn void set_function(function[f64(f64, i32) noexcept] user_function)
        function[f64(f64, i32) noexcept] get_function()
        fn f64 call_function(f64 a, i32 b) except +
