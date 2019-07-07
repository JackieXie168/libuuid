# libuuid
library and program to generate uuid (from e2fsprogs／util-linux)

LICENSE: BSD-style (from e2fsprog NOTICE)

DEPENDENCIES (Important for cross-compile):
unistd.h inttypes.h getopt.h

Compile:
$ ./autogen.sh - to generate configure files
$ make all - builds libuuid shared object
$ make test - builds test application
