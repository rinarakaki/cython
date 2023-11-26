# delorean.pyx

pub struct Vehicle:
    i32 speed
    f32 power

api fn void activate(Vehicle *v) except *:
    if v.speed >= 88 and v.power >= 1.21:
        print("Time travel achieved")
