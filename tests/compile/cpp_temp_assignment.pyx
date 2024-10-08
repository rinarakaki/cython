# tag: cpp,cpp11
# mode: compile 
# tag: no-cpp-locals
# TODO cpp_locals works fine with the standard library that comes with gcc11
# but not with gcc8. Therefore disable the test for now

extern from *:
    """
    class NoAssignIterator {
        public:
            explicit NoAssignIterator(int pos) : pos_(pos) {}
            NoAssignIterator(NoAssignIterator&) = delete;
            NoAssignIterator(NoAssignIterator&&) {}
            NoAssignIterator& operator=(NoAssignIterator&) = delete;
            NoAssignIterator& operator=(NoAssignIterator&&) { return *this; }
            // Default constructor of temp variable is needed by Cython
            // as of 3.0a6.
            NoAssignIterator() : pos_(0) {}
            int operator*() {
                return pos_;
            }
            NoAssignIterator operator++() {
                return NoAssignIterator(pos_ + 1);
            }
            int operator!=(NoAssignIterator other) {
                return pos_ != other.pos_;
            }
            int pos_;
    };
    class NoAssign {
        public:
            NoAssign() {}
            NoAssign(NoAssign&) = delete;
            NoAssign(NoAssign&&) {}
            NoAssign& operator=(NoAssign&) = delete;
            NoAssign& operator=(NoAssign&&) { return *this; }
            void func() {}
            NoAssignIterator begin() {
                return NoAssignIterator(0);
            }
            NoAssignIterator end() {
                return NoAssignIterator(2);
            }
    };

    NoAssign get_NoAssign_Py() {
        return NoAssign();
    }
    NoAssign get_NoAssign_Cpp() {
        return NoAssign();
    }

    """
    cdef cppclass NoAssignIterator:
        fn i32 operator*()
        fn NoAssignIterator operator++()
        fn i32 operator!=(NoAssignIterator)

    cdef cppclass NoAssign:
        fn void func()
        fn NoAssignIterator begin()
        fn NoAssignIterator end()

    # might raise Python exception (thus needs a temp)
    fn NoAssign get_NoAssign_Py() except *
    # might raise C++ exception (thus needs a temp)
    fn NoAssign get_NoAssign_Cpp() except +

fn internal_cpp_func(NoAssign arg):
    pass

def test_call_to_function():
    # will fail to compile if move constructors aren't used
    internal_cpp_func(get_NoAssign_Py())
    internal_cpp_func(get_NoAssign_Cpp())

def test_assignment_to_name():
    # will fail if move constructors aren't used
    let NoAssign value
    value = get_NoAssign_Py()
    value = get_NoAssign_Cpp()

def test_assignment_to_scope():
    let NoAssign value
    value = get_NoAssign_Py()
    value = get_NoAssign_Cpp()
    def inner():
        value.func()

cdef class AssignToClassAttr:
    cdef NoAssign attr
    def __init__(self):
        self.attr = get_NoAssign_Py()
        self.attr = get_NoAssign_Cpp()

def test_generator_cpp_iterator_as_temp():
    for i in get_NoAssign_Py():
        yield i
