# Interfaces to configure, query, create & destroy the Python runtime

from libc.stdio cimport FILE
from .pystate cimport PyThreadState

extern from "Python.h":
    ctypedef i32 wchar_t

    fn void Py_SetProgramName(wchar_t *)
    wchar_t *Py_GetProgramName()

    fn void Py_SetPythonHome(wchar_t *)
    wchar_t *Py_GetPythonHome()

    # Only used by applications that embed the interpreter and need to
    # override the standard encoding determination mechanism
    int Py_SetStandardStreamEncoding(const char *encoding, const char *errors)

    fn void Py_Initialize()
    fn void Py_InitializeEx(i32)
    fn void _Py_InitializeEx_Private(i32, i32)
    fn void Py_Finalize()
    fn i32 Py_FinalizeEx()
    fn i32 Py_IsInitialized()
    PyThreadState *Py_NewInterpreter()
    fn void Py_EndInterpreter(PyThreadState *)

    # _Py_PyAtExit is for the atexit module, Py_AtExit is for low-level
    # exit functions.
    fn void _Py_PyAtExit(void (*func)(object), object)
    fn i32 Py_AtExit(void (*func)())

    fn void Py_Exit(i32)

    # Restore signals that the interpreter has called SIG_IGN on to SIG_DFL.
    fn void _Py_RestoreSignals()

    fn i32 Py_FdIsInteractive(FILE *, const char *)

    # Bootstrap __main__ (defined in Modules/main.c)
    fn i32 Py_Main(i32 argc, wchar_t **argv)

    # In getpath.c
    wchar_t *Py_GetProgramFullPath()
    wchar_t *Py_GetPrefix()
    wchar_t *Py_GetExecPrefix()
    wchar_t *Py_GetPath()
    fn void Py_SetPath(const wchar_t *)
    fn i32 _Py_CheckPython3()

    # In their own files
    static const char *Py_GetVersion()
    static const char *Py_GetPlatform()
    static const char *Py_GetCopyright()
    static const char *Py_GetCompiler()
    static const char *Py_GetBuildInfo()
    static const char *_Py_gitidentifier()
    static const char *_Py_gitversion()

    ctypedef void (*PyOS_sighandler_t)(i32)
    PyOS_sighandler_t PyOS_getsig(i32)
    PyOS_sighandler_t PyOS_setsig(i32, PyOS_sighandler_t)

    # Random
    fn i32 _PyOS_URandom(void *buffer, isize size)
    fn i32 _PyOS_URandomNonblock(void *buffer, isize size)
