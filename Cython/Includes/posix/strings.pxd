extern from "<strings.h>" nogil:
    fn i32   bcmp(const void *, const void *, usize)
    fn void  bcopy(const void *, void *, usize)
    fn void  bzero(void *, usize)
    fn i32   ffs(i32)
    fn char *index(const char *, i32)
    fn char *rindex(const char *, i32)
    fn i32   strcasecmp(const char *, const char *)
    fn i32   strncasecmp(const char *, const char *, usize)
