union Food:
    r&char spam
    f32* eggs

fn main():
    let f32* arr = [1.0, 2.0]
    let Food spam = Food(spam='b')
    let Food eggs = Food(eggs=arr)
    print(spam.spam, eggs.eggs[0])
