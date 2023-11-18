use cython

use super::Visitor::(CythonTransform, TreeVisitor)

cdef class ControlBlock:
    pub set children
    pub set parents
    pub set positions
    pub list stats
    pub dict gen
    pub set bounded

    # Big integer bitsets
    pub object i_input
    pub object i_output
    pub object i_gen
    pub object i_kill
    pub object i_state

    cpdef u2 empty(self)
    cpdef detach(self)
    cpdef add_child(self, block)

cdef class ExitBlock(ControlBlock):
    cpdef u2 empty(self)

cdef class NameAssignment:
    pub u2 is_arg
    pub u2 is_deletion
    pub object lhs
    pub object rhs
    pub object entry
    pub object pos
    pub set refs
    pub object bit
    pub object inferred_type
    pub object rhs_scope

cdef class AssignmentList:
    pub object bit
    pub object mask
    pub list stats

cdef class AssignmentCollector(TreeVisitor):
    cdef list assignments

#[cython::final]
cdef class ControlFlow:
    pub set blocks
    pub set entries
    pub list loops
    pub list exceptions

    pub ControlBlock entry_point
    pub ExitBlock exit_point
    pub ControlBlock block

    pub dict assmts

    pub isize in_try_block

    cpdef newblock(self, ControlBlock parent=*)
    cpdef nextblock(self, ControlBlock parent=*)
    cpdef u2 is_tracked(self, entry)
    cpdef u2 is_statically_assigned(self, entry)
    cpdef mark_position(self, node)
    cpdef mark_assignment(self, lhs, rhs, entry, rhs_scope=*)
    cpdef mark_argument(self, lhs, rhs, entry)
    cpdef mark_deletion(self, node, entry)
    cpdef mark_reference(self, node, entry)

    #[cython::locals(block=ControlBlock, parent=ControlBlock, unreachable=set)]
    cpdef normalize(self)

    #[cython::locals(bit=object, assmts=AssignmentList, block=ControlBlock)]
    cpdef initialize(self)

    #[cython::locals(assmts=AssignmentList, assmt=NameAssignment)]
    cpdef set map_one(self, istate, entry)

    #[cython::locals(block=ControlBlock, parent=ControlBlock)]
    fn reaching_definitions(self)

cdef class Uninitialized:
    pass

cdef class Unknown:
    pass

cdef class MessageCollection:
    cdef set messages

#[cython::locals(dirty=u2, block=ControlBlock, parent=ControlBlock,
                 assmt=NameAssignment)]
fn check_definitions(ControlFlow flow, dict compiler_directives)

#[cython::final]
cdef class ControlFlowAnalysis(CythonTransform):
    cdef object gv_ctx
    cdef object constant_folder
    cdef set reductions
    cdef list stack  # a stack of (env, flow) tuples
    cdef object env
    cdef ControlFlow flow
    cdef object object_expr
    cdef u2 in_inplace_assignment

    cpdef mark_assignment(self, lhs, rhs=*, rhs_scope=*)
    cpdef mark_position(self, node)
