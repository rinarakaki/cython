# 7.21 String handling <string.h>

extern from *:
    # deprecated backwards compatibility declarations
    type const_char "const char" = const i8
    type const_schar "const signed char" = const signed char
    type const_uchar "const unsigned char" = const u8
    type const_void "const void" = const void

extern from "<string.h>" nogil:
    fn void* memcpy(void* pto, const void* pfrom, usize size)
    fn void* memmove(void* pto, const void* pfrom, usize size)
    fn void* memset(void* block, i32 c, usize size)
    fn i32  memcmp(const void* a1, const void* a2, usize size)
    fn void* memchr(const void* block, i32 c, usize size)

    fn void* memchr(const void* block, i32 c, usize size)
    fn void* memrchr(const void* block, i32 c, usize size)

    fn usize strlen(r&i8 s)
    fn r&i8 strcpy(r&i8 pto, r&i8 pfrom)
    fn r&i8 strncpy(r&i8 pto, r&i8 pfrom, usize size)
    fn r&i8 strdup(r&i8 s)
    fn r&i8 strndup(r&i8 s, usize size)
    fn r&i8 strcat(r&i8 pto, r&i8 pfrom)
    fn r&i8 strncat(r&i8 pto, r&i8 pfrom, usize size)

    fn i32 strcmp(r&i8 s1, r&i8 s2)
    fn i32 strcasecmp(r&i8 s1, r&i8 s2)
    fn i32 strncmp(r&i8 s1, r&i8 s2, usize size)
    fn i32 strncasecmp(r&i8 s1, r&i8 s2, usize n)

    fn i32 strcoll(r&i8 s1, r&i8 s2)
    fn usize strxfrm(r&i8 pto, r&i8 pfrom, usize size)

    fn r&i8 strerror(i32 errnum)

    fn r&i8 strchr(r&i8 string, i32 c)
    fn r&i8 strrchr(r&i8 string, i32 c)

    fn r&i8 strstr(r&i8 haystack, r&i8 needle)
    fn r&i8 strcasestr(r&i8 haystack, r&i8 needle)

    fn usize strcspn(r&i8 string, r&i8 stopset)
    fn usize strspn(r&i8 string, r&i8 set)
    fn r&mut i8 strpbrk(r&i8 string, r&i8 stopset)

    fn r&i8 strtok(r&i8 newstring, r&i8 delimiters)
    fn r&i8 strsep(i8** string_ptr, r&i8 delimiter)
