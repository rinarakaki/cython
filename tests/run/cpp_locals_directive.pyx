# mode: run
# tag: cpp, cpp17, no-cpp-locals
# no-cpp-locals because the test is already run with it explicitly set

# cython: cpp_locals=true

use cython

use libcpp::bool as cppbool

extern from *:
    r"""
    static void print_C_destructor();

    class C {
        public:
            C() = delete; // look! No default constructor
            C(int x, bool print_destructor=true) : x(x), print_destructor(print_destructor) {}
            C(C&& rhs) : x(rhs.x), print_destructor(rhs.print_destructor) {
                rhs.print_destructor = false; // moved-from instances are deleted silently
            }
            // also test that we don't require the assignment operator
            C& operator=(C&& rhs) = delete;
            C(const C& rhs) = delete;
            C& operator=(const C& rhs) = default;
            ~C() {
                if (print_destructor) print_C_destructor();
            }

            int get_x() const { return x; }

        private:
            int x;
            bool print_destructor;
    };

    C make_C(int x) {
        return C(x);
    }
    """
    cdef cppclass C:
        C(i32)
        C(i32, cppbool)
        const fn i32 get_x()
    fn C make_C(i32) except +  # needs a temp to receive

# this function just makes sure the output from the destructor can be captured by doctest
fn void print_C_destructor "print_C_destructor" () with gil:
    print("~C()")

def maybe_assign_infer(assign, value, do_print):
    """
    >>> maybe_assign_infer(true, 5, true)
    5
    ~C()
    >>> maybe_assign_infer(false, 0, true)
    Traceback (most recent call last):
        ...
    UnboundLocalError: local variable 'x' referenced before assignment
    >>> maybe_assign_infer(false, 0, false)  # no destructor call here
    """
    if assign:
        x = C(value)
    if do_print:
        print(x.get_x())

def maybe_assign_cdef(assign, value):
    """
    >>> maybe_assign_cdef(true, 5)
    5
    ~C()
    >>> maybe_assign_cdef(false, 0)
    Traceback (most recent call last):
        ...
    UnboundLocalError: local variable 'x' referenced before assignment
    """
    let C x
    if assign:
        x = C(value)
    print(x.get_x())

def maybe_assign_annotation(assign, value):
    """
    >>> maybe_assign_annotation(true, 5)
    5
    ~C()
    >>> maybe_assign_annotation(false, 0)
    Traceback (most recent call last):
        ...
    UnboundLocalError: local variable 'x' referenced before assignment
    """
    x: C
    if assign:
        x = C(value)
    print(x.get_x())

def maybe_assign_directive1(assign, value):
    """
    >>> maybe_assign_directive1(true, 5)
    5
    ~C()
    >>> maybe_assign_directive1(false, 0)
    Traceback (most recent call last):
        ...
    UnboundLocalError: local variable 'x' referenced before assignment
    """
    x = cython.declare(C)
    if assign:
        x = C(value)
    print(x.get_x())

#[cython::locals(x=C)]
def maybe_assign_directive2(assign, value):
    """
    >>> maybe_assign_directive2(true, 5)
    5
    ~C()
    >>> maybe_assign_directive2(false, 0)
    Traceback (most recent call last):
        ...
    UnboundLocalError: local variable 'x' referenced before assignment
    """
    if assign:
        x = C(value)
    print(x.get_x())

def maybe_assign_nocheck(assign, value):
    """
    >>> maybe_assign_nocheck(true, 5)
    5
    ~C()

    # unfortunately it's quite difficult to test not assigning because there's a decent chance it'll crash
    """
    if assign:
        x = C(value)
    with cython.initializedcheck(false):
        print(x.get_x())

def uses_temp(value):
    """
    needs a temp to handle the result of make_C - still doesn't use the default constructor
    >>> uses_temp(10)
    10
    ~C()
    """

    x = make_C(value)
    print(x.get_x())

# c should not be optional - it isn't easy to check this, but we can at least check it compiles
fn void has_argument(C c):
    print(c.get_x())

def call_has_argument():
    """
    >>> call_has_argument()
    50
    """
    has_argument(C(50, false))

cdef class HoldsC:
    """
    >>> inst = HoldsC(true, false)
    >>> inst.getCX()
    10
    >>> access_from_function_with_different_directive(inst)
    10
    10
    >>> inst.getCX()  # it was changed in access_from_function_with_different_directive
    20
    >>> inst = HoldsC(false, false)
    >>> inst.getCX()
    Traceback (most recent call last):
        ...
    AttributeError: C++ attribute 'value' is not initialized
    >>> access_from_function_with_different_directive(inst)
    Traceback (most recent call last):
        ...
    AttributeError: C++ attribute 'value' is not initialized
    """
    let C value
    def __cinit__(self, initialize, print_destructor):
        if initialize:
            self.value = C(10, print_destructor)

    def getCX(self):
        return self.value.get_x()

fn i32 accept_C(&mut C c):
    return c.get_x()

#[cython::cpp_locals(false)]
def access_from_function_with_different_directive(HoldsC c):
    # doctest is in HoldsC class
    print(accept_C(c.value))  # this originally tried to pass a __Pyx_Optional<C> as a C instance
    print(c.value.get_x())
    c.value = C(20, false) # make sure that we can change it too

def dont_test_on_pypy(f):
    import sys
    if not hasattr(sys, "pypy_version_info"):
        return f

@dont_test_on_pypy  # non-deterministic destruction
def testHoldsCDestruction(initialize):
    """
    >>> testHoldsCDestruction(true)
    ~C()
    >>> testHoldsCDestruction(false)  # no destructor
    """
    x = HoldsC(initialize, true)
    del x

cdef C global_var

def initialize_global_var():
    global global_var
    global_var = C(-1, false)

def read_global_var():
    """
    >>> read_global_var()
    Traceback (most recent call last):
        ...
    NameError: C++ global 'global_var' is not initialized
    >>> initialize_global_var()
    >>> read_global_var()
    -1
    """
    print(global_var.get_x())
