extern from "c-algorithms/src/queue.h":
    struct Queue:
        pass
    ctypedef void* QueueValue

    fn Queue* queue_new()
    fn void queue_free(Queue* queue)

    fn i32 queue_push_head(Queue* queue, QueueValue data)
    fn QueueValue queue_pop_head(Queue* queue)
    fn QueueValue queue_peek_head(Queue* queue)

    fn i32 queue_push_tail(Queue* queue, QueueValue data)
    fn QueueValue queue_pop_tail(Queue* queue)
    fn QueueValue queue_peek_tail(Queue* queue)

    fn u2 queue_is_empty(Queue* queue)
