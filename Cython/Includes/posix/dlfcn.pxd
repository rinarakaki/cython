# POSIX dynamic linking/loading interface.
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dlfcn.h.html

extern from "<dlfcn.h>" nogil:
    fn void* dlopen(r&i8, i32)
    fn r&i8 dlerror()
    fn void* dlsym(void*, r&i8)
    fn i32 dlclose(void*)

    enum:
        RTLD_LAZY
        RTLD_NOW
        RTLD_GLOBAL
        RTLD_LOCAL
