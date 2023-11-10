extern from "<omp.h>":
    struct omp_lock_t:
        pass
    struct omp_nest_lock_t:
        pass

    enum omp_sched_t:
        omp_sched_static = 1,
        omp_sched_dynamic = 2,
        omp_sched_guided = 3,
        omp_sched_auto = 4

    extern fn void omp_set_num_threads(i32) nogil
    extern fn i32 omp_get_num_threads() nogil
    extern fn i32 omp_get_max_threads() nogil
    extern fn i32 omp_get_thread_num() nogil
    extern fn i32 omp_get_num_procs() nogil

    extern fn i32 omp_in_parallel() nogil

    extern fn void omp_set_dynamic(i32) nogil
    extern fn i32 omp_get_dynamic() nogil

    extern fn void omp_set_nested(i32) nogil
    extern fn i32 omp_get_nested() nogil

    extern fn void omp_init_lock(omp_lock_t *) nogil
    extern fn void omp_destroy_lock(omp_lock_t *) nogil
    extern fn void omp_set_lock(omp_lock_t *) nogil
    extern fn void omp_unset_lock(omp_lock_t *) nogil
    extern fn i32 omp_test_lock(omp_lock_t *) nogil

    extern fn void omp_init_nest_lock(omp_nest_lock_t *) nogil
    extern fn void omp_destroy_nest_lock(omp_nest_lock_t *) nogil
    extern fn void omp_set_nest_lock(omp_nest_lock_t *) nogil
    extern fn void omp_unset_nest_lock(omp_nest_lock_t *) nogil
    extern fn i32 omp_test_nest_lock(omp_nest_lock_t *) nogil

    extern fn f64 omp_get_wtime() nogil
    extern fn f64 omp_get_wtick() nogil

    fn void omp_set_schedule(omp_sched_t, i32) nogil
    fn void omp_get_schedule(omp_sched_t *, i32 *) nogil
    fn i32 omp_get_thread_limit() nogil
    fn void omp_set_max_active_levels(i32) nogil
    fn i32 omp_get_max_active_levels() nogil
    fn i32 omp_get_level() nogil
    fn i32 omp_get_ancestor_thread_num(i32) nogil
    fn i32 omp_get_team_size(i32) nogil
    fn i32 omp_get_active_level() nogil
