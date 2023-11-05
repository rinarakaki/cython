# mode: run

"""
>>> Foo::Bar == 3
True
>>> Foo::Honk == 3 + 2 + 1
True
>>> NonPublic         # doctest: +ELLIPSIS
Traceback (most recent call last):
NameError: ...name 'NonPublic' is not defined
>>> Foo::NowPublic == 23 + 42
True
"""

enum Secret:
    NonPublic = 23 + 42

pub enum Foo:
    Bar = 3
    Honk = 3 + 2 + 1
    NowPublic = NonPublic
