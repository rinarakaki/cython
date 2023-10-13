extern from *:
    """
    struct CrunchyType {
        int number;
        PyObject* string;
    };
    """
    cdef class crunchytype.Crunchy [ object CrunchyType ]:
        let i32 number
        let object string
