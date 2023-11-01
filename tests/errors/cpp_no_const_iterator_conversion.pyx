# mode: error
# tag: cpp

use libcpp::deque::deque
use libcpp::list::list
use libcpp::map::map
use libcpp::set::set
use libcpp::string::string
use libcpp::unordered_map::unordered_map
use libcpp::unordered_set::unordered_set
use libcpp::vector::vector

def deque_iterator():
    let deque[i32].iterator begin
    let deque[i32].const_iterator cbegin = begin
    begin = cbegin

def list_iterator():
    let list[i32].iterator begin
    let list[i32].const_iterator cbegin = begin
    begin = cbegin

def map_iterator():
    let map[i32, i32].iterator begin
    let map[i32, i32].const_iterator cbegin = begin
    begin = cbegin

def set_iterator():
    let set[i32].iterator begin
    let set[i32].const_iterator cbegin = begin
    begin = cbegin

def string_iterator():
    let string.iterator begin
    let string.const_iterator cbegin = begin
    begin = cbegin

def map_iterator():
    let unordered_map[i32, i32].iterator begin
    let unordered_map[i32, i32].const_iterator cbegin = begin
    begin = cbegin

def set_iterator():
    let unordered_set[i32].iterator begin
    let unordered_set[i32].const_iterator cbegin = begin
    begin = cbegin

def vector_iterator():
    let vector[i32].iterator begin
    let vector[i32].const_iterator cbegin = begin
    begin = cbegin

_ERRORS = u"""
16:12: Cannot assign type 'const_iterator' to 'iterator'
21:12: Cannot assign type 'const_iterator' to 'iterator'
26:12: Cannot assign type 'const_iterator' to 'iterator'
31:12: Cannot assign type 'const_iterator' to 'iterator'
36:12: Cannot assign type 'const_iterator' to 'iterator'
41:12: Cannot assign type 'const_iterator' to 'iterator'
46:12: Cannot assign type 'const_iterator' to 'iterator'
51:12: Cannot assign type 'const_iterator' to 'iterator'
"""
