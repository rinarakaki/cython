# mode: compile

const f32 nan = float('nan')
const f32 inf = float('inf')
const f32 minf = -float('inf')

fn i32 f() except -1:
    let f32 x, y, z
    x = nan
    y = inf
    z = minf

f()
