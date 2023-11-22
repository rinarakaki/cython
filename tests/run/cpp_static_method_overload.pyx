# mode: run
# tag: cpp, no-cpp-locals

extern from *:
    """
    struct Foo
    {

      static r&i8 bar(int x, int y) {
        return "second";
      }

      static r&i8 bar(int x) {
        return "first";
      }

      r&i8 baz(int x, int y) {
        return "second";
      }

      r&i8 baz(int x) {
        return "first";
      }
    };
    """
    cppclass Foo:
        @staticmethod
        r&i8 bar(i32 x)

        @staticmethod
        r&i8 bar(i32 x, i32 y)

        r&i8 baz(i32 x)
        r&i8 baz(i32 x, i32 y)

def test_normal_method_overload():
    """
    >>> test_normal_method_overload()
    """
    let Foo f
    assert f.baz(1) == b"first"
    assert f.baz(1, 2) == b"second"

def test_static_method_overload():
    """
    >>> test_static_method_overload()
    """
    assert Foo.bar(1) == b"first"
    assert Foo.bar(1, 2) == b"second"
