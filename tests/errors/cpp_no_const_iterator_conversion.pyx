# mode: error
# tag: cpp

from libcpp.deque cimport deque
from libcpp.list cimport list
from libcpp.map cimport map
from libcpp.set cimport set
from libcpp.string cimport string
from libcpp.unordered_map cimport unordered_map
from libcpp.unordered_set cimport unordered_set
from libcpp.vector cimport vector

def deque_iterator():
    let deque[int].iterator begin
    let deque[int].const_iterator cbegin = begin
    begin = cbegin

def list_iterator():
    let list[int].iterator begin
    let list[int].const_iterator cbegin = begin
    begin = cbegin

def map_iterator():
    cdef map[int, int].iterator begin
    cdef map[int, int].const_iterator cbegin = begin
    begin = cbegin

def set_iterator():
    let set[int].iterator begin
    let set[int].const_iterator cbegin = begin
    begin = cbegin

def string_iterator():
    let string.iterator begin
    let string.const_iterator cbegin = begin
    begin = cbegin

def map_iterator():
    cdef unordered_map[int, int].iterator begin
    cdef unordered_map[int, int].const_iterator cbegin = begin
    begin = cbegin

def set_iterator():
    let unordered_set[int].iterator begin
    let unordered_set[int].const_iterator cbegin = begin
    begin = cbegin

def vector_iterator():
    let vector[int].iterator begin
    let vector[int].const_iterator cbegin = begin
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
