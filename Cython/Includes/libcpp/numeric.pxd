extern from "<numeric>" namespace "std" nogil:
    fn T inner_product[InputIt1, InputIt2, T](InputIt1 first1, InputIt1 last1, InputIt2 first2, T init)

    fn T inner_product[InputIt1, InputIt2, T, BinaryOperation1, BinaryOperation2](InputIt1 first1, InputIt1 last1,
                                                                                  InputIt2 first2, T init,
                                                                                  BinaryOperation1 op1,
                                                                                  BinaryOperation2 op2)

    fn void iota[ForwardIt, T](ForwardIt first, ForwardIt last, T value)

    fn T accumulate[InputIt, T](InputIt first, InputIt last, T init)

    fn T accumulate[InputIt, T, BinaryOperation](InputIt first, InputIt last, T init, BinaryOperation op)

    fn void adjacent_difference[InputIt, OutputIt](InputIt in_first, InputIt in_last, OutputIt out_first)

    fn void adjacent_difference[InputIt, OutputIt, BinaryOperation](InputIt in_first, InputIt in_last, OutputIt out_first,
                                                                    BinaryOperation op)

    fn void partial_sum[InputIt, OutputIt](InputIt in_first, OutputIt in_last, OutputIt out_first)

    fn void partial_sum[InputIt, OutputIt, BinaryOperation](InputIt in_first, InputIt in_last, OutputIt out_first,
                                                            BinaryOperation op)


    fn T reduce[InputIt, T](InputIt first, InputIt last, T init)

    # ambiguous with next overload
    # T reduce[ExecutionPolicy, ForwardIt, T](ExecutionPolicy&& policy,
    #     ForwardIt first, ForwardIt last, T init)

    fn T reduce[InputIt, T, BinaryOp](InputIt first, InputIt last, T init, BinaryOp binary_op)

    fn T reduce[ExecutionPolicy, ForwardIt, T, BinaryOp](ExecutionPolicy&& policy,
        ForwardIt first, ForwardIt last, T init, BinaryOp binary_op)

    fn T transform_reduce[InputIt1, InputIt2, T](InputIt1 first1, InputIt1 last1,
        InputIt2 first2, T init)

    fn T transform_reduce[InputIt1, InputIt2, T, BinaryReductionOp, BinaryTransformOp](
        InputIt1 first1, InputIt1 last1, InputIt2 first2, T init,
        BinaryReductionOp reduce, BinaryTransformOp transform)

    fn T transform_reduce[InputIt, T, BinaryReductionOp, UnaryTransformOp](
        InputIt first, InputIt last, T init, BinaryReductionOp reduce,
        UnaryTransformOp transform)

    # ambiguous with previous overload
    # T transform_reduce[ExecutionPolicy, ForwardIt1, ForwardIt2, T](
    #     ExecutionPolicy&& policy, ForwardIt1 first1, ForwardIt1 last1,
    #     ForwardIt2 first2, T init)

    fn T transform_reduce[ExecutionPolicy, ForwardIt1, ForwardIt2, T, BinaryReductionOp, BinaryTransformOp](
        ExecutionPolicy&& policy, ForwardIt1 first1, ForwardIt1 last1, ForwardIt2 first2, T init,
        BinaryReductionOp reduce, BinaryTransformOp transform)

    # ambiguous with second overload
    # T transform_reduce[ExecutionPolicy, ForwardIt, T, BinaryReductionOp, UnaryTransformOp](
    #     ExecutionPolicy&& policy, ForwardIt first, ForwardIt last, T init, BinaryReductionOp reduce,
    #     UnaryTransformOp transform)

    fn OutputIt inclusive_scan[InputIt, OutputIt](InputIt first, InputIt last, OutputIt d_first)

    # ambiguous with next overload
    # ForwardIt2 inclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2](
    #    ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last,
    #    ForwardIt2 d_first)

    fn OutputIt inclusive_scan[InputIt, OutputIt, BinaryOperation](
        InputIt first, InputIt last, OutputIt d_first, BinaryOperation binary_op)

    # ambiguous with next overload
    # ForwardIt2 inclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2, BinaryOperation](
    #   ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last, ForwardIt2 d_first,
    #   BinaryOperation binary_op)

    fn OutputIt inclusive_scan[InputIt, OutputIt, BinaryOperation, T](
        InputIt first, InputIt last, OutputIt d_first, BinaryOperation binary_op,
        T init)

    #
    # ForwardIt2 inclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2, BinaryOperation, T](
    #     ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last, ForwardIt2 d_first,
    #     BinaryOperation binary_op, T init)

    fn OutputIt exclusive_scan[InputIt, OutputIt, T](InputIt first, InputIt last,
        OutputIt d_first, T init)

    # ambiguous with next overload
    # ForwardIt2 exclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2, T](
    #     ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last,
    #     ForwardIt2 d_first, T init)

    fn OutputIt exclusive_scan[InputIt, OutputIt, T, BinaryOperation](
        InputIt first, InputIt last, OutputIt d_first, T init, BinaryOperation binary_op)

    fn ForwardIt2 exclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2, T, BinaryOperation](
        ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last, ForwardIt2 d_first,
        T init, BinaryOperation binary_op)

    fn OutputIt transform_inclusive_scan[InputIt, OutputIt, BinaryOperation, UnaryOperation](
        InputIt first, InputIt last, OutputIt d_first, BinaryOperation binary_op,
        UnaryOperation unary_op)

    # ambiguous with next overload
    # ForwardIt2 transform_inclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2, BinaryOperation, UnaryOperation](
    #    ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last, ForwardIt2 d_first,
    #    BinaryOperation binary_op, UnaryOperation unary_op)

    fn OutputIt transform_inclusive_scan[InputIt, OutputIt, BinaryOperation, UnaryOperation, T](
        InputIt first, InputIt last, OutputIt d_first, BinaryOperation binary_op,
        UnaryOperation unary_op, T init)

    fn ForwardIt2 transform_inclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2, BinaryOperation, UnaryOperation, T](
        ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last, ForwardIt2 d_first,
        BinaryOperation binary_op, UnaryOperation unary_op, T init)

    fn OutputIt transform_exclusive_scan[InputIt, OutputIt, T, BinaryOperation, UnaryOperation](
        InputIt first, InputIt last, OutputIt d_first, T init, BinaryOperation binary_op,
        UnaryOperation unary_op)

    fn ForwardIt2 transform_exclusive_scan[ExecutionPolicy, ForwardIt1, ForwardIt2, T, BinaryOperation, UnaryOperation](
        ExecutionPolicy&& policy, ForwardIt1 first, ForwardIt1 last, ForwardIt2 d_first,
        T init, BinaryOperation binary_op, UnaryOperation unary_op)

    # C++17
    fn T gcd[T](T a, T b)
    fn T lcm[T](T a, T b)

    # C++20
    fn T midpoint[T](T a, T b) except +
