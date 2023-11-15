/* embedded_main.c */

/* This include file is automatically generated by Cython for 'public' functions. */
#include "embedded.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t main(int32_t argc, char *argv[])
{
    PyObject *pmodule;
    wchar_t *program;

    program = Py_DecodeLocale(argv[0], NULL);
    if (program == NULL) {
        fprintf(stderr, "Fatal error: cannot decode argv[0], got %d arguments\n", argc);
        exit(1);
    }

    /* Add a built-in module, before Py_Initialize */
    if (PyImport_AppendInittab("embedded", PyInit_embedded) == -1) {
        fprintf(stderr, "Error: could not extend in-built modules table\n");
        exit(1);
    }

    /* Pass argv[0] to the Python interpreter */
    Py_SetProgramName(program);

    /* Initialize the Python interpreter.  Required.
       If this step fails, it will be a fatal error. */
    Py_Initialize();

    /* Optionally import the module; alternatively,
       import can be deferred until the embedded script
       imports it. */
    pmodule = PyImport_ImportModule("embedded");
    if (!pmodule) {
        PyErr_Print();
        fprintf(stderr, "Error: could not import module 'embedded'\n");
        goto exit_with_error;
    }

    /* Now call into your module code. */
    if (say_hello_from_python() < 0) {
        PyErr_Print();
        fprintf(stderr, "Error in Python code, exception was printed.\n");
        goto exit_with_error;
    }

    /* ... */

    /* Clean up after using CPython. */
    PyMem_RawFree(program);
    Py_Finalize();

    return 0;

    /* Clean up in the error cases above. */
exit_with_error:
    PyMem_RawFree(program);
    Py_Finalize();
    return 1;
}

#ifdef __cplusplus
}
#endif
