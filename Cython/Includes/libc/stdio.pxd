# 7.19 Input/output <stdio.h>


# deprecated cimports for backwards compatibility:
use libc::string::(const_char, const_void)

extern from "<stdio.h>" nogil:
    struct FILE
    static FILE* stdin
    static FILE* stdout
    static FILE* stderr

    enum: FOPEN_MAX
    enum: FILENAME_MAX
    fn FILE* fopen(r&i8 filename, r&i8 opentype)
    fn FILE* freopen(r&i8 filename, r&i8 opentype, FILE* stream)
    fn FILE* fdopen(i32 fdescriptor, r&i8 opentype)
    fn i32 fclose(FILE* stream)
    fn i32 remove(r&i8 filename)
    fn i32 rename(r&i8 oldname, r&i8 newname)
    fn FILE* tmpfile ()

    fn i32 remove(r&i8 pathname)
    fn i32 rename(r&i8 oldpath, r&i8 newpath)

    enum: _IOFBF
    enum: _IOLBF
    enum: _IONBF
    fn i32 setvbuf(FILE* stream, r&i8 buf, i32 mode, usize size)
    enum: BUFSIZ
    fn void setbuf(FILE* stream, r&i8 buf)

    fn usize fread(void* data, usize size, usize count, FILE* stream)
    fn usize fwrite(const void* data, usize size, usize count, FILE* stream)
    fn i32 fflush(FILE* stream)

    enum: EOF
    fn void clearerr(FILE* stream)
    fn i32 feof(FILE* stream)
    fn i32 ferror(FILE* stream)

    enum: SEEK_SET
    enum: SEEK_CUR
    enum: SEEK_END
    fn i32 fseek(FILE* stream, i64 offset, i32 whence)
    fn void rewind(FILE* stream)
    fn i64 ftell(FILE* stream)

    struct fpos_t
    fn i32 fgetpos(FILE* stream, fpos_t* position)
    fn i32 fsetpos(FILE* stream, const fpos_t* position)

    fn i32 scanf(r&i8 template, ...)
    fn i32 sscanf(r&i8 s, r&i8 template, ...)
    fn i32 fscanf(FILE* stream, r&i8 template, ...)

    fn i32 printf(r&i8 template, ...)
    fn i32 sprintf(r&i8 s, r&i8 template, ...)
    fn i32 snprintf(r&i8 s, usize size, r&i8 template, ...)
    fn i32 fprintf(FILE* stream, r&i8 template, ...)

    fn void perror(r&i8 message)

    fn r&i8 gets(r&i8 s)
    fn r&i8 fgets(r&i8 s, i32 count, FILE* stream)
    fn i32 getchar()
    fn i32 fgetc(FILE* stream)
    fn i32 getc(FILE* stream)
    fn i32 ungetc(i32 c, FILE* stream)

    fn i32 puts(r&i8 s)
    fn i32 fputs(r&i8 s, FILE* stream)
    fn i32 putchar(i32 c)
    fn i32 fputc(i32 c, FILE* stream)
    fn i32 putc(i32 c, FILE* stream)

    fn usize getline(i8** lineptr, usize *n, FILE* stream)
