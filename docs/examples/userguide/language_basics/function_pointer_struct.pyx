struct Bar:
    int sum(int a, int b)

fn int add(int a, int b):
    return a + b

let Bar bar = Bar(add)

print(bar.sum(1, 2))
