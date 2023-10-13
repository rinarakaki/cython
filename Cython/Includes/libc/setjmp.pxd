cdef extern from "<setjmp.h>" nogil:
    struct jmp_buf
    int setjmp(jmp_buf state)
    void longjmp(jmp_buf state, int value)

    struct sigjmp_buf
    int sigsetjmp(sigjmp_buf state, int savesigs)
    void siglongjmp(sigjmp_buf state, int value)
