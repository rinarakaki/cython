# distutils: language = c++

use libcpp::vector::vector

def main():
    let vector[i32] v = [4, 6, 5, 10, 3]

    let i32 value
    for value in v:
        print(value)

    return [x * x for x in v if x % 2 == 0]
