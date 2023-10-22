# mode: error
# tag: werror

fn useless_semicolon():
    let i32 i;
    pass;

ctypedef i32 x;


_ERRORS="""
5:14: useless trailing semicolon
6:8: useless trailing semicolon
8:14: useless trailing semicolon
"""
