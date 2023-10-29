# mode: compile

const nan = float('nan')
const inf = float('inf')
const minf = -float('inf')

fn i32 f() except -1:
    let f32 x, y, z
    x = nan
    y = inf
    z = minf

f()
