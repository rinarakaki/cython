use cython

cdef object StringIO

#[cython::final]
cdef class StringIOTree:
    pub list prepended_children
    pub object stream
    pub object write
    pub list markers

    cpdef fn u2 empty(self)

    #[cython::locals(x=StringIOTree)]
    cpdef fn getvalue(self)

    #[cython::locals(x=StringIOTree)]
    fn _collect_in(self, list target_list)

    #[cython::locals(child=StringIOTree)]
    cpdef fn copyto(self, target)

    cpdef fn commit(self)
    
    # def insert(self, iotree)
    # def insertion_point(self)

    #[cython::locals(c=StringIOTree)]
    cpdef fn allmarkers(self)
