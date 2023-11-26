extern from "<string>" namespace "std::string" nogil:
    static const usize npos

extern from "<string>" namespace "std" nogil:
    cdef cppclass string:
        type value_type = i8

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        type size_type = usize
        type difference_type = ptrdiff_t

        cppclass const_iterator
        cppclass iterator:
            iterator() except +
            iterator(iterator&) except +
            fn &mut value_type operator*()
            fn iterator operator++()
            fn iterator operator--()
            fn iterator operator++(i32)
            fn iterator operator--(i32)
            fn iterator operator+(size_type)
            fn iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)
            fn u2 operator<(iterator)
            fn u2 operator<(const_iterator)
            fn u2 operator>(iterator)
            fn u2 operator>(const_iterator)
            fn u2 operator<=(iterator)
            fn u2 operator<=(const_iterator)
            fn u2 operator>=(iterator)
            fn u2 operator>=(const_iterator)
        cppclass const_iterator:
            const_iterator() except +
            const_iterator(iterator&) except +
            const_iterator(const_iterator&) except +
            fn operator=(&mut iterator) except +
            fn &value_type operator*()
            fn const_iterator operator++()
            fn const_iterator operator--()
            fn const_iterator operator++(i32)
            fn const_iterator operator--(i32)
            fn const_iterator operator+(size_type)
            fn const_iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(iterator)
            fn u2 operator==(const_iterator)
            fn u2 operator!=(iterator)
            fn u2 operator!=(const_iterator)
            fn u2 operator<(iterator)
            fn u2 operator<(const_iterator)
            fn u2 operator>(iterator)
            fn u2 operator>(const_iterator)
            fn u2 operator<=(iterator)
            fn u2 operator<=(const_iterator)
            fn u2 operator>=(iterator)
            fn u2 operator>=(const_iterator)

        cppclass const_reverse_iterator
        cppclass reverse_iterator:
            reverse_iterator() except +
            reverse_iterator(reverse_iterator&) except +
            fn &mut value_type operator*()
            fn reverse_iterator operator++()
            fn reverse_iterator operator--()
            fn reverse_iterator operator++(i32)
            fn reverse_iterator operator--(i32)
            fn reverse_iterator operator+(size_type)
            fn reverse_iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)
            fn u2 operator<(reverse_iterator)
            fn u2 operator<(const_reverse_iterator)
            fn u2 operator>(reverse_iterator)
            fn u2 operator>(const_reverse_iterator)
            fn u2 operator<=(reverse_iterator)
            fn u2 operator<=(const_reverse_iterator)
            fn u2 operator>=(reverse_iterator)
            fn u2 operator>=(const_reverse_iterator)
        cppclass const_reverse_iterator:
            const_reverse_iterator() except +
            const_reverse_iterator(reverse_iterator&) except +
            fn operator=(&mut reverse_iterator) except +
            fn &value_type operator*()
            fn const_reverse_iterator operator++()
            fn const_reverse_iterator operator--()
            fn const_reverse_iterator operator++(i32)
            fn const_reverse_iterator operator--(i32)
            fn const_reverse_iterator operator+(size_type)
            fn const_reverse_iterator operator-(size_type)
            fn difference_type operator-(iterator)
            fn difference_type operator-(const_iterator)
            fn u2 operator==(reverse_iterator)
            fn u2 operator==(const_reverse_iterator)
            fn u2 operator!=(reverse_iterator)
            fn u2 operator!=(const_reverse_iterator)
            fn u2 operator<(reverse_iterator)
            fn u2 operator<(const_reverse_iterator)
            fn u2 operator>(reverse_iterator)
            fn u2 operator>(const_reverse_iterator)
            fn u2 operator<=(reverse_iterator)
            fn u2 operator<=(const_reverse_iterator)
            fn u2 operator>=(reverse_iterator)
            fn u2 operator>=(const_reverse_iterator)

        string() except +
        string(string& s) except +
        string(string& s, usize pos) except +
        string(string& s, usize pos, usize len) except +
        string(r&i8 s) except +
        string(r&i8 s, usizen) except +
        string(usize n, i8 c) except +
        string(iterator first, iterator last) except +

        fn iterator begin()
        fn const_iterator const_begin "begin"()
        fn const_iterator cbegin()
        fn iterator end()
        fn const_iterator const_end "end"()
        fn const_iterator cend()
        fn reverse_iterator rbegin()
        fn const_reverse_iterator const_rbegin "rbegin"()
        fn const_reverse_iterator crbegin()
        fn reverse_iterator rend()
        fn const_reverse_iterator const_rend "rend"()
        fn const_reverse_iterator crend()

        fn r&i8 c_str()
        fn r&i8 data()
        fn usize size()
        fn usize max_size()
        fn usize length()
        fn void resize(usize) except +
        fn void resize(usize, i8) except +
        fn void shrink_to_fit() except +
        fn void swap(&mut string other)
        fn usize capacity()
        fn void reserve(usize) except +
        fn void clear()
        fn u2 empty()

        fn iterator erase(iterator first, iterator last)
        fn iterator erase(iterator p)
        fn iterator erase(const_iterator first, const_iterator last)
        fn iterator erase(const_iterator p)
        fn &mut string erase(usize pos, usize len) except +
        fn &mut string erase(usize) except +
        fn &mut string erase() except +

        fn &mut i8 at(usize pos) except +
        fn &mut i8 operator[](usize pos)
        fn &mut i8 front()
        fn &mut i8 back()
        fn i32 compare(&string s)
        fn i32 compare(usize pos, usize len, &string s) except +
        fn i32 compare(usize pos, usize len, &string s, usize subpos, usize sublen) except +
        fn i32 compare(r&i8 s) except +
        fn i32 compare(usize pos, usize len, r&i8 s) except +
        fn i32 compare(usize pos, usize len, r&i8 s , usize n) except +

        fn &mut string append(&string s) except +
        fn &mut string append(&string s, usize subpos, usize sublen) except +
        fn &mut string append(r&i8 s) except +
        fn &mut string append(r&i8 s, usize n) except +
        fn &mut string append(usize n, i8 c) except +

        fn void push_back(i8 c) except +
        fn void pop_back()

        fn &mut string assign(&string s) except +
        fn &mut string assign(&string s, usize subpos, usize sublen) except +
        fn &mut string assign(r&i8 s, usize n) except +
        fn &mut string assign(r&i8 s) except +
        fn &mut string assign(usize n, i8 c) except +

        fn &mut string insert(usize pos, &string s, usize subpos, usize sublen) except +
        fn &mut string insert(usize pos, &string s) except +
        fn &mut string insert(usize pos, r&i8 s, usize n) except +
        fn &mut string insert(usize pos, r&i8 s) except +
        fn &mut string insert(usize pos, usize n, i8 c) except +
        fn void insert(iterator p, usize n, i8 c) except +
        fn iterator insert(iterator p, i8 c) except +

        fn usize copy(r&i8 s, usize len, usize pos) except +
        fn usize copy(r&i8 s, usize len) except +

        fn usize find(&string s, usize pos)
        fn usize find(&string s)
        fn usize find(r&i8 s, usize pos, usize n)
        fn usize find(r&i8 s, usize pos)
        fn usize find(r&i8 s)
        fn usize find(i8 c, usize pos)
        fn usize find(i8 c)

        fn usize rfind(&string, usize pos)
        fn usize rfind(&string)
        fn usize rfind(r&i8 s, usize pos, usize n)
        fn usize rfind(r&i8 s, usize pos)
        fn usize rfind(r&i8 s)
        fn usize rfind(i8 c, usize pos)
        fn usize rfind(i8 c)

        fn usize find_first_of(&string, usize pos)
        fn usize find_first_of(&string)
        fn usize find_first_of(r&i8 s, usize pos, usize n)
        fn usize find_first_of(r&i8 s, usize pos)
        fn usize find_first_of(r&i8 s)
        fn usize find_first_of(i8 c, usize pos)
        fn usize find_first_of(i8 c)

        fn usize find_first_not_of(&string s, usize pos)
        fn usize find_first_not_of(&string s)
        fn usize find_first_not_of(r&i8 s, usize pos, usize n)
        fn usize find_first_not_of(r&i8 s, usize pos)
        fn usize find_first_not_of(r&i8)
        fn usize find_first_not_of(i8 c, usize pos)
        fn usize find_first_not_of(i8 c)

        fn usize find_last_of(&string s, usize pos)
        fn usize find_last_of(&string s)
        fn usize find_last_of(r&i8 s, usize pos, usize n)
        fn usize find_last_of(r&i8 s, usize pos)
        fn usize find_last_of(r&i8 s)
        fn usize find_last_of(i8 c, usize pos)
        fn usize find_last_of(i8 c)

        fn usize find_last_not_of(&string s, usize pos)
        fn usize find_last_not_of(&string s)
        fn usize find_last_not_of(r&i8 s, usize pos, usize n)
        fn usize find_last_not_of(r&i8 s, usize pos)
        fn usize find_last_not_of(r&i8 s)
        fn usize find_last_not_of(i8 c, usize pos)
        fn usize find_last_not_of(i8 c)

        fn string substr(usize pos, usize len) except +
        fn string substr(usize pos) except +
        fn string substr()

        # C++20
        fn u2 starts_with(i8 c) except +
        fn u2 starts_with(r&i8 s)
        fn u2 ends_with(i8 c) except +
        fn u2 ends_with(r&i8 s)
        # C++23
        fn u2 contains(i8 c) except +
        fn u2 contains(r&i8 s)

        # fn &mut string operator=(&string)
        # fn &mut string operator=(r&i8)
        # fn &mut string operator=(i8)

        fn string operator+(&string) except +
        fn string operator+(r&i8) except +

        fn u2 operator==(&string)
        fn u2 operator==(r&i8)

        fn u2 operator!=(&string)
        fn u2 operator!=(r&i8)

        fn u2 operator<(&string)
        fn u2 operator<(r&i8)

        fn u2 operator>(&string)
        fn u2 operator>(r&i8)

        fn u2 operator<=(&string)
        fn u2 operator<=(r&i8)

        fn u2 operator>=(&string)
        fn u2 operator>=(r&i8)


    fn string to_string(i32 val) except +
    fn string to_string(long val) except +
    fn string to_string(long long val) except +
    fn string to_string(unsigned val) except +
    fn string to_string(usize val) except +
    fn string to_string(ssize_t val) except +
    fn string to_string(unsigned long val) except +
    fn string to_string(u128 val) except +
    fn string to_string(float val) except +
    fn string to_string(double val) except +
    fn string to_string(f128 val) except +

    fn i32 stoi(&string s, usize* idx, i32 base) except +
    fn i32 stoi(&string s, usize* idx) except +
    fn i32 stoi(&string s) except +
    fn i64 stol(&string s, usize* idx, i32 base) except +
    fn i64 stol(&string s, usize* idx) except +
    fn i64 stol(&string s) except +
    fn i128 stoll(&string s, usize* idx, i32 base) except +
    fn i128 stoll(&string s, usize* idx) except +
    fn i128 stoll(&string s) except +

    fn u64 stoul(&string s, usize* idx, i32 base) except +
    fn u64 stoul(&string s, usize* idx) except +
    fn u64 stoul(&string s) except +
    fn u128 stoull(&string s, usize* idx, i32 base) except +
    fn u128 stoull(&string s, usize* idx) except +
    fn u128 stoull(&string s) except +

    fn f32 stof(&string s, usize* idx) except +
    fn f32 stof(&string s) except +
    fn f64 stod(&string s, usize* idx) except +
    fn f64 stod(&string s) except +
    fn f128 stold(&string s, usize* idx) except +
    fn f128 stold(&string s) except +
