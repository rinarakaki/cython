extern from "foo.h":
    ctypedef long long big_t
    fn void spam(big_t b)

spam(grail)
