set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -emit-llvm -fno-builtin")

set(CMAKE_C_COMPILER "clang")
set(CMAKE_AR "llvm-link")

add_library(kleeRuntimeIntrinsic STATIC
	klee_div_zero_check.c
	klee_int.c
	klee_overshift_check.c
	klee_range.c
	memcpy.c
	memmove.c
	mempcpy.c
	memset.c)

