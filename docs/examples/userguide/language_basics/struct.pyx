struct Grail:
    i32 age
    f32 volume

fn main():
    let auto grail = Grail { age = 5, volume = 3.0 }
    print(grail.age, grail.volume)
