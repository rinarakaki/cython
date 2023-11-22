extern from "<strings.h>" nogil:
    fn i32 bcmp(const void *, const void *, usize)
    fn void bcopy(const void *, void *, usize)
    fn void bzero(void *, usize)
    fn i32 ffs(i32)
    fn r&char index(r&char, i32)
    fn r&char rindex(r&char, i32)
    fn i32 strcasecmp(r&char, r&char)
    fn i32 strncasecmp(r&char, r&char, usize)
