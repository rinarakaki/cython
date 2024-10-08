# mode: run
# tag: cpp, werror, cpp11, no-cpp-locals

use libcpp::bool
use libcpp::algorithm::(is_sorted, is_sorted_until, sort, partial_sort, partial_sort_copy, stable_sort)
use libcpp::algorithm::nth_element
use libcpp::functional::greater
use libcpp::iterator::distance
use libcpp::string::string
use libcpp::vector::vector

fn is_sorted_ints(vector[i32] values):
    """
    Test is_sorted.

    >>> is_sorted_ints([3, 1, 4, 1, 5])
    False
    >>> is_sorted_ints([1, 1, 3, 4, 5])
    True
    """
    return is_sorted(values.begin(), values.end())

fn initial_sorted_elements(vector[i32] values):
    """
    Test is_sorted_until.

    >>> initial_sorted_elements([4, 1, 9, 5, 1, 3])
    1
    >>> initial_sorted_elements([4, 5, 9, 3, 1, 1])
    3
    >>> initial_sorted_elements([9, 3, 1, 4, 5, 1])
    1
    >>> initial_sorted_elements([1, 3, 5, 4, 1, 9])
    3
    >>> initial_sorted_elements([5, 9, 1, 1, 3, 4])
    2
    >>> initial_sorted_elements([4, 9, 1, 5, 1, 3])
    2
    >>> initial_sorted_elements([1, 1, 4, 9, 5, 3])
    4
    """
    sorted_end = is_sorted_until(values.begin(), values.end())
    return distance(values.begin(), sorted_end)

fn sort_ints(vector[i32] values):
    """Test sort using the default operator<.

    >>> sort_ints([5, 7, 4, 2, 8, 6, 1, 9, 0, 3])
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    """
    sort(values.begin(), values.end())
    return values

fn sort_ints_reverse(vector[i32] values):
    """Test sort using a standard library comparison function object.

    >>> sort_ints_reverse([5, 7, 4, 2, 8, 6, 1, 9, 0, 3])
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    """
    sort(values.begin(), values.end(), greater[int]())
    return values

fn partial_sort_ints(vector[i32] values, i32 k):
    """
    Test partial_sort using the default operator<.

    >>> partial_sort_ints([4, 2, 3, 1, 5], 2)[:2]
    [1, 2]
    """
    partial_sort(values.begin(), values.begin() + k, values.end())
    return values

fn partial_sort_ints_reverse(vector[i32] values, i32 k):
    """
    Test partial_sort using a standard library comparison function object.

    >>> partial_sort_ints_reverse([4, 2, 3, 1, 5], 2)[:2]
    [5, 4]
    """
    partial_sort(values.begin(), values.begin() + k, values.end(), greater[int]())
    return values

fn partial_sort_ints2(vector[i32] values, i32 k):
    """
    Test partial_sort_copy using the default operator<.

    >>> partial_sort_ints2([4, 2, 3, 1, 5], 2)
    [1, 2]
    """
    output = vector[i32](2)
    partial_sort_copy(values.begin(), values.end(), output.begin(), output.end())
    return output

fn partial_sort_ints_reverse2(vector[i32] values, i32 k):
    """
    Test partial_sort_copy using a standard library comparison function object.

    >>> partial_sort_ints_reverse2([4, 2, 3, 1, 5], 2)
    [5, 4]
    """
    output = vector[i32](2)
    partial_sort_copy(values.begin(), values.end(), output.begin(), output.end(), greater[int]())
    return output

extern from *:
    """
    struct Employee
    {
        Employee() = default;
        Employee(i32 age, std::string name): age(age), name(name) {}
        int age;
        std::string name;  // Does not participate in comparisons
    };

    bool operator<(const Employee& lhs, const Employee& rhs)
    {
        return lhs.age < rhs.age;
    }
    """
    cppclass Employee:
        Employee()
        Employee(i32, string)
        i32 age
        string name

fn bool Employee_greater(&Employee lhs, &Employee rhs):
    return lhs.age > rhs.age

def test_stable_sort():
    """
    Test stable_sort using cppreference example.

    >>> test_stable_sort()
    32, Arthur
    108, Zaphod
    108, Ford
    108, Zaphod
    108, Ford
    32, Arthur
    """
    let vector[Employee] employees
    employees.push_back(Employee(108, <string>b"Zaphod"))
    employees.push_back(Employee(32, <string>b"Arthur"))
    employees.push_back(Employee(108, <string>b"Ford"))

    stable_sort(employees.begin(), employees.end())

    for e in employees:
        print("%s, %s" % (e.age, <str>(e.name).decode("ascii")))

    stable_sort(employees.begin(), employees.end(), &Employee_greater)

    for e in employees:
        print("%s, %s" % (e.age, <str>(e.name).decode("ascii")))

fn second_smallest(vector[i32] values):
    """
    Test nth_element using the default operator<.

    >>> second_smallest([5, 6, 4, 3, 2, 6, 7, 9, 3])
    3
    """
    nth_element(values.begin(), values.begin() + 1, values.end())
    return values[1]

fn second_largest(vector[i32] values):
    """
    Test nth_element using a standard library comparison function object.

    >>> second_largest([5, 6, 4, 3, 2, 6, 7, 9, 3])
    7
    """
    nth_element(values.begin(), values.begin() + 1, values.end(), greater[int]())
    return values[1]
