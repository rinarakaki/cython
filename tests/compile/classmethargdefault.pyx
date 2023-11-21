# mode: compile

__doc__ = u"""
    >>> s = Swallow()
    >>> s.spam(1)
    1 42 'grail' True
    >>> s.spam(1, 2)
    1 2 'grail' True
    >>> s.spam(1, z = 2)
    1 42 'grail' 2
    >>> s.spam(1, y = 2)
    1 42 2 True
    >>> s.spam(1, x = 2, y = 'test')
    1 2 'test' True
"""

swallow = true

struct Swallow

impl Swallow:
    def spam(w, i32 x = 42, y = "grail", z = swallow):
        print w, x, y, z
