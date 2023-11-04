# cython: language_level=3

# We declare all of these here to type the first argument.

from __future__ import absolute_import

use cython
use super::Scanning::PyrexScanner

ctypedef object (*p_sub_expr_func)(PyrexScanner obj)

# entry points

cpdef p_module(PyrexScanner s, pxd, full_module_name, ctx=*)
cpdef p_code(PyrexScanner s, level= *, ctx=*)

# internal parser states

fn p_ident(PyrexScanner s, message =*)
fn p_ident_list(PyrexScanner s)

fn tuple p_binop_operator(PyrexScanner s)
fn p_binop_expr(PyrexScanner s, ops, p_sub_expr_func p_sub_expr)
fn p_lambdef(PyrexScanner s)
fn p_test(PyrexScanner s)
fn p_test_allow_walrus_after(PyrexScanner s)
fn p_namedexpr_test(PyrexScanner s)
fn p_or_test(PyrexScanner s)
fn p_rassoc_binop_expr(PyrexScanner s, unicode op, p_sub_expr_func p_subexpr)
fn p_and_test(PyrexScanner s)
fn p_not_test(PyrexScanner s)
fn p_comparison(PyrexScanner s)
fn p_test_or_starred_expr(PyrexScanner s)
fn p_namedexpr_test_or_starred_expr(PyrexScanner s)
fn p_starred_expr(PyrexScanner s)
fn p_cascaded_cmp(PyrexScanner s)
fn p_cmp_op(PyrexScanner s)
fn p_bit_expr(PyrexScanner s)
fn p_xor_expr(PyrexScanner s)
fn p_and_expr(PyrexScanner s)
fn p_shift_expr(PyrexScanner s)
fn p_arith_expr(PyrexScanner s)
fn p_term(PyrexScanner s)
fn p_factor(PyrexScanner s)
fn _p_factor(PyrexScanner s)
fn p_typecast(PyrexScanner s)
fn p_sizeof(PyrexScanner s)
fn p_yield_expression(PyrexScanner s)
fn p_yield_statement(PyrexScanner s)
fn p_async_statement(PyrexScanner s, ctx, decorators)
fn p_power(PyrexScanner s)
fn p_new_expr(PyrexScanner s)
fn p_trailer(PyrexScanner s, node1)
fn p_call_parse_args(PyrexScanner s, bint allow_genexp = *)
fn p_call_build_packed_args(pos, positional_args, keyword_args)
fn p_call(PyrexScanner s, function)
fn p_index(PyrexScanner s, base)
fn tuple p_subscript_list(PyrexScanner s)
fn p_subscript(PyrexScanner s)
fn p_slice_element(PyrexScanner s, follow_set)
fn expect_ellipsis(PyrexScanner s)
fn make_slice_nodes(pos, subscripts)
cpdef make_slice_node(pos, start, stop = *, step = *)
fn p_atom(PyrexScanner s)

fn p_exponent(PyrexScanner s)
fn dict p_numeric_literal_suffix(s)
fn p_numeric_literal(PyrexScanner s)
#[cython.locals(value=unicode)]
fn p_int_literal(PyrexScanner s)

fn p_name(PyrexScanner s, name)
fn wrap_compile_time_constant(pos, value)
fn p_cat_string_literal(PyrexScanner s)
fn p_opt_string_literal(PyrexScanner s, required_type=*)
fn bint check_for_non_ascii_characters(unicode string)

#[cython.locals(systr=unicode, is_python3_source=bint, is_raw=bint)]
fn p_string_literal(PyrexScanner s, kind_override=*)

fn _append_escape_sequence(kind, builder, unicode escape_sequence, PyrexScanner s)
fn tuple _f_string_error_pos(pos, string, isize i)

#[cython.locals(i=isize, size=isize, c=Py_UCS4, next_start=isize)]
fn list p_f_string(PyrexScanner s, unicode_value, pos, bint is_raw)

#[cython.locals(i=isize, size=isize, c=Py_UCS4, quote_char=Py_UCS4, NO_CHAR=Py_UCS4)]
fn tuple p_f_string_expr(PyrexScanner s, unicode_value, pos, isize starting_index, bint is_raw)

fn p_list_maker(PyrexScanner s)
fn p_comp_iter(PyrexScanner s, body)
fn p_comp_for(PyrexScanner s, body)
fn p_comp_if(PyrexScanner s, body)
fn p_dict_or_set_maker(PyrexScanner s)
fn p_backquote_expr(PyrexScanner s)
fn p_simple_expr_list(PyrexScanner s, expr=*)
fn p_test_or_starred_expr_list(PyrexScanner s, expr=*)
fn p_namedexpr_test_or_starred_expr_list(s, expr=*)
fn p_testlist(PyrexScanner s)
fn p_testlist_star_expr(PyrexScanner s)
fn p_testlist_comp(PyrexScanner s)
fn p_genexp(PyrexScanner s, expr)

#-------------------------------------------------------
#
#   Statements
#
#-------------------------------------------------------

fn p_global_statement(PyrexScanner s)
fn p_nonlocal_statement(PyrexScanner s)
fn p_expression_or_assignment(PyrexScanner s)
fn p_print_statement(PyrexScanner s)
fn p_exec_statement(PyrexScanner s)
fn p_del_statement(PyrexScanner s)
fn p_pass_statement(PyrexScanner s, bint with_newline = *)
fn p_break_statement(PyrexScanner s)
fn p_continue_statement(PyrexScanner s)
fn p_return_statement(PyrexScanner s)
fn p_raise_statement(PyrexScanner s)
fn p_import_statement(PyrexScanner s)
fn p_from_import_statement(PyrexScanner s, bint first_statement = *)
fn p_imported_name(PyrexScanner s)
fn p_dotted_name(PyrexScanner s, bint as_allowed)
fn p_as_name(PyrexScanner s)
fn p_assert_statement(PyrexScanner s)
fn p_if_statement(PyrexScanner s)
fn p_if_clause(PyrexScanner s)
fn p_else_clause(PyrexScanner s)
fn p_while_statement(PyrexScanner s)
fn p_for_statement(PyrexScanner s, bint is_async=*)
fn dict p_for_bounds(PyrexScanner s, bint allow_testlist=*, bint is_async=*)
fn p_for_from_relation(PyrexScanner s)
fn p_for_from_step(PyrexScanner s)
fn p_target(PyrexScanner s, terminator)
fn p_for_target(PyrexScanner s)
fn p_for_iterator(PyrexScanner s, bint allow_testlist=*, bint is_async=*)
fn p_try_statement(PyrexScanner s)
fn p_except_clause(PyrexScanner s)
fn p_include_statement(PyrexScanner s, ctx)
fn p_with_statement(PyrexScanner s)
fn p_with_items(PyrexScanner s, bint is_async=*)
fn p_with_items_list(PyrexScanner s, bint is_async)
fn tuple p_with_item(PyrexScanner s, bint is_async)
fn p_with_template(PyrexScanner s)
fn p_simple_statement(PyrexScanner s, bint first_statement = *)
fn p_simple_statement_list(PyrexScanner s, ctx, bint first_statement = *)
fn p_compile_time_expr(PyrexScanner s)
fn p_DEF_statement(PyrexScanner s)
fn p_IF_statement(PyrexScanner s, ctx)
fn p_statement(PyrexScanner s, ctx, bint first_statement = *)
fn p_statement_list(PyrexScanner s, ctx, bint first_statement = *)
fn p_suite(PyrexScanner s, ctx = *)
fn tuple p_suite_with_docstring(PyrexScanner s, ctx, bint with_doc_only=*)
fn tuple _extract_docstring(node)
fn p_positional_and_keyword_args(PyrexScanner s, end_sy_set, templates = *)

cpdef p_c_base_type(PyrexScanner s, bint nonempty = *, templates = *)
fn p_calling_convention(PyrexScanner s)
fn p_c_complex_base_type(PyrexScanner s, templates = *)
fn p_c_simple_base_type(PyrexScanner s, bint nonempty, templates = *)
fn p_buffer_or_template(PyrexScanner s, base_type_node, templates)
fn p_bracketed_base_type(PyrexScanner s, base_type_node, nonempty, empty)
fn is_memoryviewslice_access(PyrexScanner s)
fn p_memoryviewslice_access(PyrexScanner s, base_type_node)
fn bint looking_at_name(PyrexScanner s) except -2
fn object looking_at_expr(PyrexScanner s)# except -2
fn bint looking_at_base_type(PyrexScanner s) except -2
fn bint looking_at_dotted_name(PyrexScanner s) except -2
fn p_sign_and_longness(PyrexScanner s)
fn p_opt_cname(PyrexScanner s)
cpdef p_c_declarator(PyrexScanner s, ctx = *, bint empty = *, bint is_type = *, bint cmethod_flag = *,
                   bint assignable = *, bint nonempty = *,
                   bint calling_convention_allowed = *)
fn p_c_array_declarator(PyrexScanner s, base)
fn p_c_func_declarator(PyrexScanner s, pos, ctx, base, bint cmethod_flag)
fn p_c_simple_declarator(PyrexScanner s, ctx, bint empty, bint is_type, bint cmethod_flag,
                          bint assignable, bint nonempty)
fn p_nogil(PyrexScanner s)
fn p_with_gil(PyrexScanner s)
fn p_exception_value_clause(PyrexScanner s, bint is_extern)
cpdef p_c_arg_list(PyrexScanner s, ctx = *, bint in_pyfunc = *, bint cmethod_flag = *,
                   bint nonempty_declarators = *, bint kw_only = *, bint annotated = *)
fn p_optional_ellipsis(PyrexScanner s)
fn p_c_arg_decl(PyrexScanner s, ctx, in_pyfunc, bint cmethod_flag = *, bint nonempty = *, bint kw_only = *, bint annotated = *)
fn p_api(PyrexScanner s)
fn p_cdef_statement(PyrexScanner s, ctx)
fn p_cdef_block(PyrexScanner s, ctx)
fn p_cdef_extern_block(PyrexScanner s, pos, ctx)
fn p_c_enum_definition(PyrexScanner s, pos, ctx)
fn p_c_enum_line(PyrexScanner s, ctx, list items)
fn p_c_enum_item(PyrexScanner s, ctx, list items)
fn p_c_struct_or_union_definition(PyrexScanner s, pos, ctx)
fn p_fused_definition(PyrexScanner s, pos, ctx)
fn p_struct_enum(PyrexScanner s, pos, ctx)
fn p_visibility(PyrexScanner s, prev_visibility)
fn p_c_modifiers(PyrexScanner s)
fn p_c_func_or_var_declaration(PyrexScanner s, pos, ctx)
fn p_ctypedef_statement(PyrexScanner s, ctx)
fn p_decorators(PyrexScanner s)
fn _reject_cdef_modifier_in_py(PyrexScanner s, name)
fn p_def_statement(PyrexScanner s, list decorators=*, bint is_async_def=*)
fn p_varargslist(PyrexScanner s, terminator=*, bint annotated = *)
fn p_py_arg_decl(PyrexScanner s, bint annotated = *)
fn p_class_statement(PyrexScanner s, decorators)
fn p_c_class_definition(PyrexScanner s, pos,  ctx)
fn tuple p_c_class_options(PyrexScanner s)
fn p_property_decl(PyrexScanner s)
fn p_doc_string(PyrexScanner s)
fn p_ignorable_statement(PyrexScanner s)
fn dict p_compiler_directive_comments(PyrexScanner s)
fn p_template_definition(PyrexScanner s)
fn p_cpp_class_definition(PyrexScanner s, pos, ctx)
fn p_cpp_class_attribute(PyrexScanner s, ctx)
fn p_annotation(PyrexScanner s)
