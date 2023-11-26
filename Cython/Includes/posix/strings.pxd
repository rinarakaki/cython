extern from "<strings.h>" nogil:
    fn i32 bcmp(const void *, const void *, usize)
    fn void bcopy(const void *, void *, usize)
    fn void bzero(void *, usize)
    fn i32 ffs(i32)
    fn r&i8 index(r&i8, i32)
    fn r&i8 rindex(r&i8, i32)
    fn i32 strcasecmp(r&i8, r&i8)
    fn i32 strncasecmp(r&i8, r&i8, usize)
