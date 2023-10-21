from __future__ import absolute_import

import cython

from Cython.Plex.Actions cimport Action

cdef class Scanner:
    cdef public lexicon
    cdef public stream
    cdef public name
    cdef public unicode buffer
    cdef public isize buf_start_pos
    cdef public isize next_pos
    cdef public isize cur_pos
    cdef public isize cur_line
    cdef public isize cur_line_start
    cdef public isize start_pos
    cdef tuple current_scanner_position_tuple
    cdef public tuple last_token_position_tuple
    cdef public text
    cdef public initial_state # int?
    cdef public state_name
    cdef public list queue
    cdef public bint trace
    cdef public cur_char
    cdef public i64 input_state

    cdef public level

    @cython.locals(input_state=i64)
    cdef inline next_char(self)
    @cython.locals(action=Action)
    cpdef tuple read(self)
    cdef inline unread(self, token, value, position)
    cdef inline get_current_scan_pos(self)
    cdef inline tuple scan_a_token(self)
    ##cdef tuple position(self)  # used frequently by Parsing.py

    @cython.final
    @cython.locals(cur_pos=isize, cur_line=isize, cur_line_start=isize,
                   input_state=i64, next_pos=isize, state=dict,
                   buf_start_pos=isize, buf_len=isize, buf_index=isize,
                   trace=bint, discard=isize, data=unicode, buffer=unicode)
    cdef run_machine_inlined(self)

    cdef inline begin(self, state)
    cdef inline produce(self, value, text = *)
