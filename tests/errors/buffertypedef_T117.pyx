# ticket: t117
# mode: error

type mybuffer = object[f32]

_ERRORS = u"""
1:0: Buffer vars not allowed in module scope
4:0: Buffer types only allowed as function local variables
"""
