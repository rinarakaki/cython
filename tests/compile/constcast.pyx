# mode: compile

use libc::stdlib::(malloc, free)

fn void f():
    let auto allocated = <const i32 **>malloc(sizeof(i32 *))
    free(allocated)

f()
