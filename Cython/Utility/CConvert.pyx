#################### FromPyStructUtility ####################

extern from *:
    struct PyTypeObject:
        r&mut i8 tp_name
    fn r&mut PyTypeObject Py_TYPE(obj)
    fn u2 PyMapping_Check(obj)
    fn object PyErr_Format(exc, r&i8 format, ...)
    fn i32 __Pyx_RaiseUnexpectedTypeError(r&i8 expected, object obj) except 0

#[cname("{{funcname}}")]
fn {{struct_type}} {{funcname}}(obj) except *:
    let {{struct_type}} result
    if not PyMapping_Check(obj):
        __Pyx_RaiseUnexpectedTypeError(b"a mapping", obj)

    {{for member in var_entries:}}
    try:
        value = obj['{{member.name}}']
    except KeyError:
        raise ValueError("No value specified for struct attribute '{{member.name}}'")
    result.{{member.name}} = value
    {{endfor}}
    return result


#################### FromPyUnionUtility ####################

extern from *:
    struct PyTypeObject:
        r&mut i8 tp_name
    fn r&mut PyTypeObject Py_TYPE(obj)
    fn u2 PyMapping_Check(obj)
    fn object PyErr_Format(exc, r&i8 format, ...)
    fn i32 __Pyx_RaiseUnexpectedTypeError(r&i8 expected, object obj) except 0

#[cname("{{funcname}}")]
fn {{struct_type}} {{funcname}}(obj) except *:
    let {{struct_type}} result
    let isize length
    if not PyMapping_Check(obj):
        __Pyx_RaiseUnexpectedTypeError(b"a mapping", obj)

    last_found = None
    length = len(obj)
    if length:
        {{for member in var_entries:}}
        if '{{member.name}}' in obj:
            if last_found is not None:
                raise ValueError("More than one union attribute passed: '%s' and '%s'" % (last_found, '{{member.name}}'))
            last_found = '{{member.name}}'
            result.{{member.cname}} = obj['{{member.name}}']
            length -= 1
            if not length:
                return result
        {{endfor}}
    if last_found is None:
        raise ValueError("No value specified for any of the union attributes (%s)" %
                         '{{", ".join(member.name for member in var_entries)}}')
    return result


#################### cfunc.to_py ####################

#[cname("{{cname}}")]
fn object {{cname}}({{return_type.ctype}} (*f)({{ ', '.join(arg.type_cname for arg in args) }}) {{except_clause}}):
    def wrap({{ ', '.join('{arg.ctype} {arg.name}'.format(arg=arg) for arg in args) }}):
        """wrap({{', '.join(('{arg.name}: {arg.type_displayname}'.format(arg=arg) if arg.type_displayname else arg.name) for arg in args)}}){{if return_type.type_displayname}} -> {{return_type.type_displayname}}{{endif}}"""
        {{'' if return_type.type.is_void else 'return '}}f({{ ', '.join(arg.name for arg in args) }})
    return wrap


#################### carray.from_py ####################

extern from *:
    fn object PyErr_Format(exc, r&i8 format, ...)

#[cname("{{cname}}")]
fn i32 {{cname}}(object o, {{base_type}} *v, isize length) except -1:
    let auto i = length
    try:
        i = len(o)
    except (TypeError, OverflowError):
        pass
    if i == length:
        for i, item in enumerate(o):
            if i >= length:
                break
            v[i] = item
        else:
            i += 1  # convert index to length
            if i == length:
                return 0

    PyErr_Format(
        IndexError,
        ("too many values found during array assignment, expected %zd"
         if i >= length else
         "not enough values found during array assignment, expected %zd, got %zd"),
        length, i)


#################### carray.to_py ####################

extern from *:
    fn void Py_INCREF(object o)
    fn tuple PyTuple_New(isize size)
    fn list PyList_New(isize size)
    fn void PyTuple_SET_ITEM(object p, isize pos, object o)
    fn void PyList_SET_ITEM(object p, isize pos, object o)

#[cname("{{cname}}")]
fn inline list {{cname}}({{base_type}} *v, isize length):
    let usize i
    let object value
    l = PyList_New(length)
    for i in 0..<usize>length:
        value = v[i]
        Py_INCREF(value)
        PyList_SET_ITEM(l, i, value)
    return l

#[cname("{{to_tuple_cname}}")]
fn inline tuple {{to_tuple_cname}}({{base_type}} *v, isize length):
    let usize i
    let object value
    t = PyTuple_New(length)
    for i in 0..<usize>length:
        value = v[i]
        Py_INCREF(value)
        PyTuple_SET_ITEM(t, i, value)
    return t
