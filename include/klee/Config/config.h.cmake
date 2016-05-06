
#ifndef KLEE_CONFIG_CONFIG_H
#define KLEE_CONFIG_CONFIG_H

/* Enable KLEE DEBUG checks */
#cmakedefine ENABLE_KLEE_DEBUG

/* Enable metaSMT API */
#cmakedefine ENABLE_METASMT

/* Using STP Solver backend */
#cmakedefine ENABLE_STP

/* Using Z3 Solver backend */
#cmakedefine ENABLE_Z3

/* Does the platform use __ctype_b_loc, etc. */
#cmakedefine HAVE_CTYPE_EXTERNALS

/* Define to 1 if you have the <gperftools/malloc_extension.h> header file. */
#cmakedefine HAVE_GPERFTOOLS_MALLOC_EXTENSION_H

/* Define if mallinfo() is available on this platform. */
#cmakedefine01 HAVE_MALLINFO

/* Define to 1 if you have the <malloc/malloc.h> header file. */
#cmakedefine HAVE_MALLOC_MALLOC_H

/* Define to 1 if you have the `malloc_zone_statistics' function. */
#cmakedefine HAVE_MALLOC_ZONE_STATISTICS

/* Define to 1 if you have the <memory.h> header file. */
#cmakedefine HAVE_MEMORY_H

/* Define to 1 if you have the <selinux/selinux.h> header file. */
#cmakedefine HAVE_SELINUX_SELINUX_H

/* Define to 1 if you have the <stdint.h> header file. */
#cmakedefine HAVE_STDINT_H

/* Define to 1 if you have the <stdlib.h> header file. */
#cmakedefine HAVE_STDLIB_H

/* Define to 1 if you have the <strings.h> header file. */
#cmakedefine HAVE_STRINGS_H

/* Define to 1 if you have the <string.h> header file. */
#cmakedefine HAVE_STRING_H

/* Define to 1 if you have the <sys/acl.h> header file. */
#cmakedefine HAVE_SYS_ACL_H

/* Define to 1 if you have the <sys/capability.h> header file. */
#cmakedefine HAVE_SYS_CAPABILITY_H

/* Define to 1 if you have the <sys/stat.h> header file. */
#cmakedefine HAVE_SYS_STAT_H

/* Define to 1 if you have the <sys/types.h> header file. */
#cmakedefine HAVE_SYS_TYPES_H

/* Define to 1 if you have the <unistd.h> header file. */
#cmakedefine HAVE_UNISTD_H

/* Z3 needs a Z3_context passed to Z3_get_error_msg() */
#cmakedefine HAVE_Z3_GET_ERROR_MSG_NEEDS_CONTEXT

/* Define to empty or 'const' depending on how SELinux qualifies its security
   context parameters. */
#cmakedefine KLEE_SELINUX_CTX_CONST

/* LLVM version is release (instead of development) */
#cmakedefine LLVM_IS_RELEASE

/* Define to the address where bug reports for this package should be sent. */
#cmakedefine PACKAGE_BUGREPORT

/* Define to the full name of this package. */
#cmakedefine PACKAGE_NAME

/* Define to the full name and version of this package. */
#cmakedefine PACKAGE_STRING

/* Define to the one symbol short name of this package. */
#cmakedefine PACKAGE_TARNAME

/* Define to the home page for this package. */
#cmakedefine PACKAGE_URL

/* Define to the version of this package. */
#cmakedefine PACKAGE_VERSION

/* Configuration for runtime libraries */
#define RUNTIME_CONFIGURATION "@RUNTIME_CONFIGURATION@"

/* Define to 1 if you have the ANSI C header files. */
#cmakedefine STDC_HEADERS

/* klee-uclibc is supported */
#cmakedefine SUPPORT_KLEE_UCLIBC

#ifndef LLVM_VERSION_MAJOR
#cmakedefine LLVM_VERSION_MAJOR @LLVM_VERSION_MAJOR@
#endif

#ifndef LLVM_VERSION_MINOR
#cmakedefine LLVM_VERSION_MINOR @LLVM_VERSION_MINOR@
#endif

#endif
