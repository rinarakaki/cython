extern from "<strings.h>" nogil:
    int    bcmp(const void *, const void *, usize)
    void   bcopy(const void *, void *, usize)
    void   bzero(void *, usize)
    int    ffs(i32)
    char   *index(const char *, int)
    char   *rindex(const char *, int)
    int    strcasecmp(const char *, const char *)
    int    strncasecmp(const char *, const char *, usize)
