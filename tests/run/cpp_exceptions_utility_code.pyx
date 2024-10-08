# mode: run
# tag: cpp, werror, no-cpp-locals
# ticket: 3065

# This is intentionally in a file on its own. The issue was that it failed to generate utility-code
# and so putting it with the other c++ exception checks wouldn't be a useful test

extern from *:
    """
    #include <stdexcept>

    void cppf(int raiseCpp) {
        if (raiseCpp) {
            throw std::runtime_error("cpp");
        } else {
            PyErr_SetString(PyExc_RuntimeError, "py");
        }
    }
    """
    fn void cppf(i32) except+*

def callcppf(i32 raiseCpp):
    """
    >>> callcppf(0)
    py
    >>> callcppf(1)
    cpp
    """
    try:
        cppf(raiseCpp)
    except RuntimeError as e:
        print(e.args[0])
