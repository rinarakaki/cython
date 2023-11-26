extern from "<atomic>" namespace "std" nogil:
    enum memory_order:
        memory_order_relaxed
        memory_order_consume
        memory_order_acquire
        memory_order_release
        memory_order_acq_rel
        memory_order_seq_cst

    cdef cppclass atomic[T]:
        atomic()
        atomic(T)

        fn u2 is_lock_free()
        fn void store(T)
        fn void store(T, memory_order)
        fn T load()
        fn T load(memory_order)
        fn T exchange(T)
        fn T exchange(T, memory_order)

        fn u2 compare_exchange_weak(&mut T, T, memory_order, memory_order)
        fn u2 compare_exchange_weak(&mut T, T, memory_order)
        fn u2 compare_exchange_weak(&mut T, T)
        fn u2 compare_exchange_strong(&mut T, T, memory_order, memory_order)
        fn u2 compare_exchange_strong(&mut T, T, memory_order)
        fn u2 compare_exchange_strong(&mut T, T)

        fn T fetch_add(T, memory_order)
        fn T fetch_add(T)
        fn T fetch_sub(T, memory_order)
        fn T fetch_sub(T)
        fn T fetch_and(T, memory_order)
        fn T fetch_and(T)
        fn T fetch_or(T, memory_order)
        fn T fetch_or(T)
        fn T fetch_xor(T, memory_order)
        fn T fetch_xor(T)

        fn T operator++()
        fn T operator++(i32)
        fn T operator--()
        fn T operator--(i32)

        # modify-in-place operators not yet supported by Cython:
        # fn T operator+=(T)
        # fn T operator-=(T)
        # fn T operator&=(T)
        # fn T operator|=(T)
        # fn T operator^=(T)

        fn u2 operator==(atomic[T]&, atomic[T]&)
        fn u2 operator==(atomic[T]&, &mut T)
        fn u2 operator==(&mut T, atomic[T]&)
        fn u2 operator!=(atomic[T]&, atomic[T]&)
        fn u2 operator!=(atomic[T]&, &mut T)
        fn u2 operator!=(&mut T, atomic[T]&)
