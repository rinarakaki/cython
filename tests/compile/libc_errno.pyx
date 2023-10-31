# mode: compile

use libc::errno::*

if errno == EDOM   : pass
if errno == EILSEQ : pass
if errno == ERANGE : pass

errno = 0
