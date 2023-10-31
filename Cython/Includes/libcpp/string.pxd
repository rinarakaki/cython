
# deprecated cimport for backwards compatibility:
from libc.string cimport const_char

extern from "<string>" namespace "std::string" nogil:
    const usize npos

extern from "<string>" namespace "std" nogil:
    cdef cppclass string:
        ctypedef char value_type

        # these should really be allocator_type.size_type and
        # allocator_type.difference_type to be true to the C++ definition
        # but cython doesn't support deferred access on template arguments
        ctypedef usize size_type
        ctypedef ptrdiff_t difference_type

        cppclass const_iterator
        cppclass iterator:
            iterator() except +
            iterator(iterator&) except +
            value_type& operator*()
            iterator operator++()
            iterator operator--()
            iterator operator++(i32)
            iterator operator--(i32)
            iterator operator+(size_type)
            iterator operator-(size_type)
            difference_type operator-(iterator)
            difference_type operator-(const_iterator)
            bint operator==(iterator)
            bint operator==(const_iterator)
            bint operator!=(iterator)
            bint operator!=(const_iterator)
            bint operator<(iterator)
            bint operator<(const_iterator)
            bint operator>(iterator)
            bint operator>(const_iterator)
            bint operator<=(iterator)
            bint operator<=(const_iterator)
            bint operator>=(iterator)
            bint operator>=(const_iterator)
        cppclass const_iterator:
            const_iterator() except +
            const_iterator(iterator&) except +
            const_iterator(const_iterator&) except +
            operator=(iterator&) except +
            const value_type& operator*()
            const_iterator operator++()
            const_iterator operator--()
            const_iterator operator++(i32)
            const_iterator operator--(i32)
            const_iterator operator+(size_type)
            const_iterator operator-(size_type)
            difference_type operator-(iterator)
            difference_type operator-(const_iterator)
            bint operator==(iterator)
            bint operator==(const_iterator)
            bint operator!=(iterator)
            bint operator!=(const_iterator)
            bint operator<(iterator)
            bint operator<(const_iterator)
            bint operator>(iterator)
            bint operator>(const_iterator)
            bint operator<=(iterator)
            bint operator<=(const_iterator)
            bint operator>=(iterator)
            bint operator>=(const_iterator)

        cppclass const_reverse_iterator
        cppclass reverse_iterator:
            reverse_iterator() except +
            reverse_iterator(reverse_iterator&) except +
            value_type& operator*()
            reverse_iterator operator++()
            reverse_iterator operator--()
            reverse_iterator operator++(i32)
            reverse_iterator operator--(i32)
            reverse_iterator operator+(size_type)
            reverse_iterator operator-(size_type)
            difference_type operator-(iterator)
            difference_type operator-(const_iterator)
            bint operator==(reverse_iterator)
            bint operator==(const_reverse_iterator)
            bint operator!=(reverse_iterator)
            bint operator!=(const_reverse_iterator)
            bint operator<(reverse_iterator)
            bint operator<(const_reverse_iterator)
            bint operator>(reverse_iterator)
            bint operator>(const_reverse_iterator)
            bint operator<=(reverse_iterator)
            bint operator<=(const_reverse_iterator)
            bint operator>=(reverse_iterator)
            bint operator>=(const_reverse_iterator)
        cppclass const_reverse_iterator:
            const_reverse_iterator() except +
            const_reverse_iterator(reverse_iterator&) except +
            operator=(reverse_iterator&) except +
            const value_type& operator*()
            const_reverse_iterator operator++()
            const_reverse_iterator operator--()
            const_reverse_iterator operator++(i32)
            const_reverse_iterator operator--(i32)
            const_reverse_iterator operator+(size_type)
            const_reverse_iterator operator-(size_type)
            difference_type operator-(iterator)
            difference_type operator-(const_iterator)
            bint operator==(reverse_iterator)
            bint operator==(const_reverse_iterator)
            bint operator!=(reverse_iterator)
            bint operator!=(const_reverse_iterator)
            bint operator<(reverse_iterator)
            bint operator<(const_reverse_iterator)
            bint operator>(reverse_iterator)
            bint operator>(const_reverse_iterator)
            bint operator<=(reverse_iterator)
            bint operator<=(const_reverse_iterator)
            bint operator>=(reverse_iterator)
            bint operator>=(const_reverse_iterator)

        fn string() except +
        fn string(const string& s) except +
        fn string(const string& s, usize pos) except +
        fn string(const string& s, usize pos, usize len) except +
        fn string(const char* s) except +
        fn string(const char* s, usizen) except +
        fn string(usize n, char c) except +
        fn string(iterator first, iterator last) except +

        iterator begin()
        const_iterator const_begin "begin"()
        const_iterator cbegin()
        iterator end()
        const_iterator const_end "end"()
        const_iterator cend()
        reverse_iterator rbegin()
        const_reverse_iterator const_rbegin "rbegin"()
        const_reverse_iterator crbegin()
        reverse_iterator rend()
        const_reverse_iterator const_rend "rend"()
        const_reverse_iterator crend()

        const char* c_str()
        const char* data()
        fn usize size()
        fn usize max_size()
        fn usize length()
        fn void resize(usize) except +
        fn void resize(usize, char) except +
        fn void shrink_to_fit() except +
        fn void swap(string& other)
        fn usize capacity()
        fn void reserve(usize) except +
        fn void clear()
        fn bint empty()

        iterator erase(iterator first, iterator last)
        iterator erase(iterator p)
        iterator erase(const_iterator first, const_iterator last)
        iterator erase(const_iterator p)
        fn string& erase(usize pos, usize len) except +
        fn string& erase(usize) except +
        fn string& erase() except +

        fn char& at(usize pos) except +
        fn char& operator[](usize pos)
        fn char& front()
        fn char& back()
        fn i32 compare(const string& s)
        fn i32 compare(usize pos, usize len, const string& s) except +
        fn i32 compare(usize pos, usize len, const string& s, usize subpos, usize sublen) except +
        fn i32 compare(const char* s) except +
        fn i32 compare(usize pos, usize len, const char* s) except +
        fn i32 compare(usize pos, usize len, const char* s , usize n) except +

        fn string& append(const string& s) except +
        fn string& append(const string& s, usize subpos, usize sublen) except +
        fn string& append(const char* s) except +
        fn string& append(const char* s, usize n) except +
        fn string& append(usize n, char c) except +

        fn void push_back(char c) except +
        fn void pop_back()

        fn string& assign(const string& s) except +
        fn string& assign(const string& s, usize subpos, usize sublen) except +
        fn string& assign(const char* s, usize n) except +
        fn string& assign(const char* s) except +
        fn string& assign(usize n, char c) except +

        fn string& insert(usize pos, const string& s, usize subpos, usize sublen) except +
        fn string& insert(usize pos, const string& s) except +
        fn string& insert(usize pos, const char* s, usize n) except +
        fn string& insert(usize pos, const char* s) except +
        fn string& insert(usize pos, usize n, char c) except +
        fn void insert(iterator p, usize n, char c) except +
        iterator insert(iterator p, char c) except +

        fn usize copy(char* s, usize len, usize pos) except +
        fn usize copy(char* s, usize len) except +

        fn usize find(const string& s, usize pos)
        fn usize find(const string& s)
        fn usize find(const char* s, usize pos, usize n)
        fn usize find(const char* s, usize pos)
        fn usize find(const char* s)
        fn usize find(char c, usize pos)
        fn usize find(char c)

        fn usize rfind(const string&, usize pos)
        fn usize rfind(const string&)
        fn usize rfind(const char* s, usize pos, usize n)
        fn usize rfind(const char* s, usize pos)
        fn usize rfind(const char* s)
        fn usize rfind(char c, usize pos)
        fn usize rfind(char c)

        fn usize find_first_of(const string&, usize pos)
        fn usize find_first_of(const string&)
        fn usize find_first_of(const char* s, usize pos, usize n)
        fn usize find_first_of(const char* s, usize pos)
        fn usize find_first_of(const char* s)
        fn usize find_first_of(char c, usize pos)
        fn usize find_first_of(char c)

        fn usize find_first_not_of(const string& s, usize pos)
        fn usize find_first_not_of(const string& s)
        fn usize find_first_not_of(const char* s, usize pos, usize n)
        fn usize find_first_not_of(const char* s, usize pos)
        fn usize find_first_not_of(const char*)
        fn usize find_first_not_of(char c, usize pos)
        fn usize find_first_not_of(char c)

        fn usize find_last_of(const string& s, usize pos)
        fn usize find_last_of(const string& s)
        fn usize find_last_of(const char* s, usize pos, usize n)
        fn usize find_last_of(const char* s, usize pos)
        fn usize find_last_of(const char* s)
        fn usize find_last_of(char c, usize pos)
        fn usize find_last_of(char c)

        fn usize find_last_not_of(const string& s, usize pos)
        fn usize find_last_not_of(const string& s)
        fn usize find_last_not_of(const char* s, usize pos, usize n)
        fn usize find_last_not_of(const char* s, usize pos)
        fn usize find_last_not_of(const char* s)
        fn usize find_last_not_of(char c, usize pos)
        fn usize find_last_not_of(char c)

        fn string substr(usize pos, usize len) except +
        fn string substr(usize pos) except +
        fn string substr()

        # C++20
        fn bint starts_with(char c) except +
        fn bint starts_with(const char* s)
        fn bint ends_with(char c) except +
        fn bint ends_with(const char* s)
        # C++23
        fn bint contains(char c) except +
        fn bint contains(const char* s)

        # string& operator= (const string&)
        # string& operator= (const char*)
        # string& operator= (char)

        fn string operator+ (const string&) except +
        fn string operator+ (const char*) except +

        fn bint operator==(const string&)
        fn bint operator==(const char*)

        fn bint operator!= (const string&)
        fn bint operator!= (const char*)

        fn bint operator< (const string&)
        fn bint operator< (const char*)

        fn bint operator> (const string&)
        fn bint operator> (const char*)

        fn bint operator<= (const string&)
        fn bint operator<= (const char*)

        fn bint operator>= (const string&)
        fn bint operator>= (const char*)


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
    fn string to_string(long double val) except +

    fn i32 stoi(const string& s, usize* idx, i32 base) except +
    fn i32 stoi(const string& s, usize* idx) except +
    fn i32 stoi(const string& s) except +
    fn i64 stol(const string& s, usize* idx, i32 base) except +
    fn i64 stol(const string& s, usize* idx) except +
    fn i64 stol(const string& s) except +
    fn i128 stoll(const string& s, usize* idx, i32 base) except +
    fn i128 stoll(const string& s, usize* idx) except +
    fn i128 stoll(const string& s) except +

    fn u64 stoul(const string& s, usize* idx, i32 base) except +
    fn u64 stoul(const string& s, usize* idx) except +
    fn u64 stoul(const string& s) except +
    fn u128 stoull(const string& s, usize* idx, i32 base) except +
    fn u128 stoull(const string& s, usize* idx) except +
    fn u128 stoull(const string& s) except +

    fn f32 stof(const string& s, usize* idx) except +
    fn f32 stof(const string& s) except +
    fn f64 stod(const string& s, usize* idx) except +
    fn f64 stod(const string& s) except +
    fn long double stold(const string& s, usize* idx) except +
    fn long double stold(const string& s) except +
