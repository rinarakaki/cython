#ifndef CPP_FUNCTION_LIB_H
#define CPP_FUNCTION_LIB_H

#include <functional>

// Functions, functor and a holder of std::function used by cpp_stl_function.pyx tests.

double add_one(double a, int32_t b);
double add_two(double a, int32_t b);

class AddAnotherFunctor
{
    double to_add;

public:
    AddAnotherFunctor(double to_add);
    double operator()(double a, int32_t b) const;
};


class FunctionKeeper
{
    std::function<double(double, int32_t)> my_function;

public:
    FunctionKeeper(std::function<double(double, int32_t)> user_function);
    virtual ~FunctionKeeper();

    void set_function(std::function<double(double, int32_t)> user_function);
    std::function<double(double, int32_t)> get_function() const;

    double call_function(double a, int32_t b) const;
};

#endif
