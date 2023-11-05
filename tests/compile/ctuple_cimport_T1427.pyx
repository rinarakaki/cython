# ticket: 1427
# mode: compile

use ctuple_cimport

# Verify same tuple defined in multiple pxd not redeclared
type int_double = (i32, f64)

ctuple_cimport.get_a_ctuple()
