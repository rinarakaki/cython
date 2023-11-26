# mode: compile

ctypedef pub api class Foo [type PyFoo_Type, object PyFooObject]:
    pass

ctypedef pub api class Bar [type PyBar_Type, object PyBarObject]:
        pass

pub api ctypedef class Baz [type PyBaz_Type, object PyBazObject]:
        pass
