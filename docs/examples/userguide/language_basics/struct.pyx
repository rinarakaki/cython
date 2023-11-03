struct Grail:
    i32 age
    f32 volume

def main():
    let auto grail = Grail(5, 3.0)
    print(grail.age, grail.volume)
