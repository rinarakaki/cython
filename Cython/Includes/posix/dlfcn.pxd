# POSIX dynamic linking/loading interface.
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dlfcn.h.html

extern from "<dlfcn.h>" nogil:
    fn void *dlopen(const char *, i32)
    fn char *dlerror()
    fn void *dlsym(void *, const char *)
    fn i32 dlclose(void *)

    enum:
        RTLD_LAZY
        RTLD_NOW
        RTLD_GLOBAL
        RTLD_LOCAL
