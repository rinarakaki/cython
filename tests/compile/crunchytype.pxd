extern from *:
    """
    struct CrunchyType {
        int number;
        PyObject* string;
    };
    """
    struct crunchytype::Crunchy [ object CrunchyType ]:
        i32 number
        object string
