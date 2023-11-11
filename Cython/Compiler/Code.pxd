# cython: language_level=3

use cython
use super::super::StringIOTree::StringIOTree

cdef class UtilityCodeBase(object):
    cpdef format_code(self, code_string, replace_empty_lines=*)

cdef class UtilityCode(UtilityCodeBase):
    pub object name
    pub object proto
    pub object impl
    pub object init
    pub object cleanup
    pub object proto_block
    pub object requires
    pub dict _cache
    pub list specialize_list
    pub object file

    cpdef none_or_sub(self, s, context)

cdef class FunctionState:
    pub set names_taken
    pub object owner
    pub object scope

    pub object error_label
    pub usize label_counter
    pub set labels_used
    pub object return_label
    pub object continue_label
    pub object break_label
    pub list yield_labels

    pub object return_from_error_cleanup_label # not used in __init__ ?

    pub object exc_vars
    pub object current_except
    pub u2 in_try_finally
    pub u2 can_trace
    pub u2 gil_owned

    pub list temps_allocated
    pub dict temps_free
    pub dict temps_used_type
    pub set zombie_temps
    pub usize temp_counter
    pub list collect_temps_stack

    pub object closure_temps
    pub u2 should_declare_error_indicator
    pub u2 uses_error_indicator
    pub u2 error_without_exception

    pub u2 needs_refnanny

    #[cython.locals(n=usize)]
    cpdef new_label(self, name=*)
    cpdef tuple get_loop_labels(self)
    cpdef set_loop_labels(self, labels)
    cpdef tuple get_all_labels(self)
    cpdef set_all_labels(self, labels)
    cpdef start_collecting_temps(self)
    cpdef stop_collecting_temps(self)

    cpdef list temps_in_use(self)

cdef class IntConst:
    pub object cname
    pub object value
    pub u2 is_long

cdef class PyObjectConst:
    pub object cname
    pub object type

cdef class StringConst:
    pub object cname
    pub object text
    pub object escaped_value
    pub dict py_strings
    pub list py_versions

    #[cython.locals(intern=u2, is_str=u2, is_unicode=u2)]
    cpdef get_py_string_const(self, encoding, identifier=*, is_str=*, py3str_cstring=*)

# cdef class PyStringConst:
#     pub object cname
#     pub object encoding
#     pub u2 is_str
#     pub u2 is_unicode
#     pub u2 intern

#class GlobalState(object):

#def funccontext_property(name):

cdef class CCodeWriter(object):
    cdef readonly StringIOTree buffer
    cdef readonly list pyclass_stack
    cdef readonly object globalstate
    cdef readonly object funcstate
    cdef object code_config
    cdef object last_pos
    cdef object last_marked_pos
    cdef isize level
    pub isize call_level  # debug-only, see Nodes.py
    cdef u2 bol

    cpdef write(self, s)

    #[cython.final]
    fn _write_lines(self, s)

    cpdef _write_to_buffer(self, s)

    cpdef put(self, code)

    cpdef put_safe(self, code)

    cpdef putln(self, code=*, u2 safe=*)

    #[cython.final]
    fn increase_indent(self)

    #[cython.final]
    fn decrease_indent(self)
    
    #[cython.final]
    fn indent(self)

cdef class PyrexCodeWriter:
    pub object f
    pub isize level
