# mode: compile
# tag: cpp

# Test that using functionality from libcpp.vector does not lead to compile
# errors when wildcard imports are used as well.

# Import libcpp.vector, which declares PY_SSIZE_T_MAX.
use libcpp::vector::vector

# Import any other module using a wildcard import.
from spam import *

# Use the imports (details don't matter).
extern from *:
    """
    #include <vector>
    std::vector<int> get_vector()
    {
      return std::vector<int>(17);
    }
    """
    vector[i32] get_vector()

my_vector = get_vector()
