use cython

use super::Machines
use super::Transitions::TransitionMap


#[cython::final]
cdef class StateMap:
    cdef Machines.FastMachine new_machine
    cdef dict old_to_new_dict
    cdef dict new_to_old_dict

    fn old_to_new(self, dict old_state_set)

    #[cython::locals(state=Machines.Node)]
    fn highest_priority_action(self, dict state_set)

    fn make_key(self, dict state_set)


#[cython::locals(new_machine=Machines.FastMachine, transitions=TransitionMap)]
cpdef fn nfa_to_dfa(Machines.Machine old_machine, debug=*)

fn set_epsilon_closure(dict state_set)
fn dict epsilon_closure(Machines.Node state)

#[cython::locals(state_set_2=dict, state2=Machines.Node)]
fn add_to_epsilon_closure(dict state_set, Machines.Node state)
