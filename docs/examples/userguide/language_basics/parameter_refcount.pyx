use cpython::ref::PyObject

import sys

python_dict = {"abc": 123}
python_dict_refcount = sys.getrefcount(python_dict)

fn owned_reference(object obj):
    refcount = sys.getrefcount(python_dict)
    print('Inside owned_reference: {refcount}'.format(refcount=refcount))

fn borrowed_reference(PyObject * obj):
    refcount = obj.ob_refcnt
    print('Inside borrowed_reference: {refcount}'.format(refcount=refcount))

print('Initial refcount: {refcount}'.format(refcount=python_dict_refcount))
owned_reference(python_dict)
borrowed_reference(<PyObject *>python_dict)
