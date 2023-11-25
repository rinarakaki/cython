# mode: error

struct Grail

extern static object xobj  # Python object cannot be extern
static object aobj[42]    # array element cannot be Python object
static object* pobj       # pointer base type cannot be Python object

static i32 spam[] # incomplete variable type
static Grail g     # incomplete variable type
static void nada   # incomplete variable type

static i32 a_spam[17][]  # incomplete element type
static Grail a_g[42]     # incomplete element type
static void a_nada[88]   # incomplete element type

struct Eggs:
    i32 spam[]

fn f(Grail g,   # incomplete argument type
     void v,         # incomplete argument type
     i32 a[]):
    pass

static NoSuchType* ptr
ptr = None             # This should not produce another error

_ERRORS = u"""
5:21: Python object cannot be declared extern
6:18: Array element cannot be a Python object
7:7: Pointer base type cannot be a Python object
9:15: Variable type 'int []' is incomplete
10:13: Variable type 'Grail' is incomplete
11:12: Variable type 'void' is incomplete
13:17: Array element type 'int []' is incomplete
14:16: Array element type 'Grail' is incomplete
15:18: Array element type 'void' is incomplete
18:12: Variable type 'int []' is incomplete
# 19:1: Function argument cannot be void
21:5: Use spam() rather than spam(void) to declare a function with no arguments.
20:5: Argument type 'Grail' is incomplete
21:5: Invalid use of 'void'
25:7: 'NoSuchType' is not a type identifier
"""
