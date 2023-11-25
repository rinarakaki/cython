__doc__ = u"""
>>> import sys
>>> sys.getrefcount(Foo.__pyx_vtable__)
2
>>> sys.getrefcount(__pyx_capi__['bar'])
2
>>> sys.getrefcount(__pyx_capi__['spam'])
2
>>> sys.getrefcount(__pyx_capi__['ten'])
2
>>> sys.getrefcount(__pyx_capi__['pi'])
2
>>> sys.getrefcount(__pyx_capi__['obj'])
2
>>> sys.getrefcount(__pyx_capi__['dct'])
2
>>> sys.getrefcount(__pyx_capi__['tpl'])
2
>>> sys.getrefcount(__pyx_capi__['one'])
2
>>> sys.getrefcount(__pyx_capi__['two'])
Traceback (most recent call last):
  ...
KeyError: 'two'
"""

pub api class Foo [type FooType, object FooObject]:
    fn void bar(self):
        pass

pub api fn void bar():
    pass
api fn void spam():
    pass

api static i32 ten = 10
api static f64 pi = 3.14
api static object obj = object()
api static dict dct = {}

pub api static tuple tpl = ()
pub api static f32 one = 1
pub     static f32 two = 2
