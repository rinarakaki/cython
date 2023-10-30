extern from "<setjmp.h>" nogil:
    struct jmp_buf:
        pass
    fn i32 setjmp(jmp_buf state)
    fn void longjmp(jmp_buf state, i32 value)

    struct sigjmp_buf:
        pass
    fn i32 sigsetjmp(sigjmp_buf state, i32 savesigs)
    fn void siglongjmp(sigjmp_buf state, i32 value)
