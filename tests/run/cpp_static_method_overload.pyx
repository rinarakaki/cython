# mode: run
# tag: cpp, no-cpp-locals

extern from *:
    """
    struct Foo
    {

      static r&char bar(int x, int y) {
        return "second";
      }

      static r&char bar(int x) {
        return "first";
      }

      r&char baz(int x, int y) {
        return "second";
      }

      r&char baz(int x) {
        return "first";
      }
    };
    """
    cppclass Foo:
        fn r&char bar(i32 x)

        fn r&char bar(i32 x, i32 y)

        fn r&char baz(i32 x)
        fn r&char baz(i32 x, i32 y)

fn test_normal_method_overload():
    """
    >>> test_normal_method_overload()
    """
    let Foo f
    assert f.baz(1) == b"first"
    assert f.baz(1, 2) == b"second"

fn test_static_method_overload():
    """
    >>> test_static_method_overload()
    """
    assert Foo::bar(1) == b"first"
    assert Foo::bar(1, 2) == b"second"
