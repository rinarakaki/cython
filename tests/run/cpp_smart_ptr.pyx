# mode: run
# tag: cpp, werror, cpp14, no-cpp-locals

use libcpp::memory::(unique_ptr, shared_ptr, default_delete, dynamic_pointer_cast, make_unique)
use libcpp::nullptr

extern from "cpp_smart_ptr_helper.h":
    cdef cppclass CountAllocDealloc:
        CountAllocDealloc(i32*, int*)

    cdef cppclass FreePtr[T]:
        pass

    cdef cppclass RaiseOnConstruct:
        pass

fn test_unique_ptr():
    """
    >>> test_unique_ptr()
    """
    let i32 alloc_count = 0, dealloc_count = 0
    let unique_ptr[CountAllocDealloc] x_ptr
    x_ptr.reset(new CountAllocDealloc(&alloc_count, &dealloc_count))
    assert alloc_count == 1
    x_ptr.reset()
    assert alloc_count == 1
    assert dealloc_count == 1

    # Repeat the above test with an explicit default_delete type
    alloc_count = 0
    dealloc_count = 0
    let unique_ptr[CountAllocDealloc,default_delete[CountAllocDealloc]] x_ptr2
    x_ptr2.reset(new CountAllocDealloc(&alloc_count, &dealloc_count))
    assert alloc_count == 1
    x_ptr2.reset()
    assert alloc_count == 1
    assert dealloc_count == 1

    alloc_count = 0
    dealloc_count = 0
    let unique_ptr[CountAllocDealloc,FreePtr[CountAllocDealloc]] x_ptr3
    x_ptr3.reset(new CountAllocDealloc(&alloc_count, &dealloc_count))
    assert x_ptr3.get() != nullptr;
    x_ptr3.reset()
    assert x_ptr3.get() == nullptr;

    # Test that make_unique works
    let unique_ptr[int] x_ptr4
    x_ptr4 = make_unique[int](5)
    assert(x_ptr4) != nullptr
    let unique_ptr[RaiseOnConstruct] x_ptr5
    try:
        x_ptr5 = make_unique[RaiseOnConstruct]()
    except RuntimeError:
        pass  # good - this is what we expect

type const_CountAllocDealloc = const CountAllocDealloc

fn test_const_shared_ptr():
    """
    >>> test_const_shared_ptr()
    """
    let i32 alloc_count = 0, dealloc_count = 0
    let shared_ptr[const_CountAllocDealloc] ptr = shared_ptr[const_CountAllocDealloc](
        new CountAllocDealloc(&alloc_count, &dealloc_count))
    assert alloc_count == 1
    assert dealloc_count == 0

    let shared_ptr[const_CountAllocDealloc] ptr2 = ptr
    assert alloc_count == 1
    assert dealloc_count == 0

    ptr.reset()
    assert alloc_count == 1
    assert dealloc_count == 0

    ptr2.reset()
    assert alloc_count == 1
    assert dealloc_count == 1

cdef cppclass A:
    fn void some_method():  # Force this to be a polymorphic class for dynamic cast.
        pass

cdef cppclass B(A):
    pass

cdef cppclass C(B):
    pass

static shared_ptr[A] holding_subclass = shared_ptr[A](new C())

fn test_assignment_to_base_class():
    """
    >>> test_assignment_to_base_class()
    """
    let shared_ptr[C] derived = shared_ptr[C](new C())
    let shared_ptr[A] base = derived

fn test_dynamic_pointer_cast():
    """
    >>> test_dynamic_pointer_cast()
    """
    let shared_ptr[B] b = shared_ptr[B](new B())
    let shared_ptr[A] a = dynamic_pointer_cast[A, B](b)
    assert a.get() == b.get()

    a = shared_ptr[A](new A())
    b = dynamic_pointer_cast[B, A](a)
    assert b.get() == NULL
