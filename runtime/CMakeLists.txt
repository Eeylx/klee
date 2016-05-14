set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -emit-llvm -fno-builtin")

set(CMAKE_C_COMPILER ${CLANG})
set(CMAKE_AR ${LLVM_AR})

add_library(kleeRuntimeIntrinsic STATIC
	Intrinsic/klee_div_zero_check.c
	Intrinsic/klee_int.c
	Intrinsic/klee_overshift_check.c
	Intrinsic/klee_range.c
	Intrinsic/memcpy.c
	Intrinsic/memmove.c
	Intrinsic/mempcpy.c
	Intrinsic/memset.c)

add_library(klee-libc STATIC
	klee-libc/abort.c
	klee-libc/atexit.c
	klee-libc/atoi.c
	klee-libc/calloc.c
	klee-libc/__cxa_atexit.c
	klee-libc/htonl.c
	klee-libc/klee-choose.c
	klee-libc/memchr.c
	klee-libc/memcmp.c
	klee-libc/memcpy.c
	klee-libc/memmove.c
	klee-libc/mempcpy.c
	klee-libc/memset.c
	klee-libc/putchar.c
	klee-libc/stpcpy.c
	klee-libc/strcat.c
	klee-libc/strchr.c
	klee-libc/strcmp.c
	klee-libc/strcoll.c
	klee-libc/strcpy.c
	klee-libc/strlen.c
	klee-libc/strncmp.c
	klee-libc/strncpy.c
	klee-libc/strrchr.c
	klee-libc/strtol.c
	klee-libc/strtoul.c
	klee-libc/tolower.c
	klee-libc/toupper.c)

add_library(kleeRuntimePOSIX 
	POSIX/fd_32.c
	POSIX/fd_64.c
	POSIX/fd.c
	POSIX/fd_init.c
	POSIX/illegal.c
	POSIX/klee_init_env.c
	POSIX/misc.c
	POSIX/selinux.c
	POSIX/stubs.c
	)
set_target_properties(
	kleeRuntimePOSIX kleeRuntimeIntrinsic klee-libc
	PROPERTIES
	SUFFIX ".bca"
	PREFIX ""
	)
