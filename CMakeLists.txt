cmake_minimum_required(VERSION 2.8.8)

project(klee C CXX)
set(PACKAGE_NAME "klee")
set(PACKAGE_STRING "klee")
set(PACKAGE_URL "https://github.com/klee/klee")

find_package(LLVM REQUIRED CONFIG)
include(CheckIncludeFiles)
include(CheckIncludeFileCXX)
include(CheckFunctionExists)

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  message(STATUS "Using CCACHE: ${CCACHE_FOUND}")
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif(CCACHE_FOUND)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(include)
include_directories(${CMAKE_BINARY_DIR}/include)

add_definitions(${LLVM_DEFINITIONS})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wno-unused-parameter")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -Wall -Wextra -Wno-unused-parameter")

find_program(CLANG
  NAMES clang clang-${LLVM_VERSION_MAJOR}.${LLVM_VERSION_MINOR}
  HINTS ${LLVM_TOOLS_BINARY_DIR}
  )
find_program(LLVM_AR
  NAMES llvm-ar llvm-ar-${LLVM_VERSION_MAJOR}.${LLVM_VERSION_MINOR}
  HINTS ${LLVM_TOOLS_BINARY_DIR}
  )
message(STATUS "Using Clang ${CLANG}")
message(STATUS "Using llvm-ar ${LLVM_AR}")


check_include_files(malloc/malloc.h HAVE_MALLOC_MALLOC_H)
check_include_files(inttypes.h HAVE_INTTYPES_H)
check_include_files(selinux/selinux.h HAVE_SELINUX)
check_include_files(sys/acl.h HAVE_SYS_ACL_H)
check_include_files(memory.h HAVE_MEMORY_H)
check_function_exists(mallinfo HAVE_MALLINFO)

set(ENABLE_TCMALLOC ON CACHE BOOL "Use tcmalloc")
set(ENABLE_STP ON CACHE BOOL "Enable STP solver backend")
set(ENABLE_Z3 OFF CACHE BOOL "Enable Z3 solver backend")
set(KLEE_UCLIBC_BCA_NAME "klee-uclibc.bca" CACHE STRING "Name of klee-uclibc library")

if (LLVM_ENABLE_ASSERTIONS)
  set(ENABLE_KLEE_DEBUG ON)
endif()

if (LLVM_ENABLE_RTTI)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -frtti")
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

set(KLEE_BUILD_MODE ${CMAKE_BUILD_TYPE})
set(abs_top_builddir ${PROJECT_BINARY_DIR})
set(abs_top_srcdir ${PROJECT_SOURCE_DIR})


configure_file(include/klee/Config/config.h.cmake include/klee/Config/config.h)
configure_file(include/klee/Config/CompileTimeInfo.h.cmake include/klee/Config/CompileTimeInfo.h)
configure_file(docs/doxygen.cfg.in docs/doxygen.cfg)

if (ENABLE_STP)
  find_package(STP REQUIRED CONFIG)
  add_definitions("-DEXT_HASH_MAP")
  include_directories(${STP_INCLUDE_DIRS})
endif()

if (ENABLE_Z3)
  find_library(Z3LIB z3)
endif()

add_definitions("-DKLEE_DIR=\"${CMAKE_BINARY_DIR}\"")
add_definitions("-DKLEE_INSTALL_BIN_DIR=\"${CMAKE_INSTALL_PREFIX}/bin\"")
add_definitions("-DKLEE_INSTALL_RUNTIME_DIR=\"${CMAKE_INSTALL_PREFIX}/lib/klee\"")

if (ENABLE_TCMALLOC)
  find_library(TCMALLOC_LIB tcmalloc_minimal)
  check_include_file_cxx(gperftools/malloc_extension.h
    HAVE_GPERFTOOLS_MALLOC_EXTENSION_H)
  set(HAVE_TCMALLOC ON)
else()
  set(HAVE_TCMALLOC OFF)
endif()

add_subdirectory(lib)
add_subdirectory(tools)
add_subdirectory(runtime)
