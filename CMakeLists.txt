cmake_minimum_required(VERSION 2.8.8)

project(klee C CXX)
set(PACKAGE_NAME "klee")
set(PACKAGE_STRING "klee")
set(PACKAGE_URL "https://github.com/klee/klee")

find_package(LLVM REQUIRED CONFIG)
include(CheckIncludeFiles)
include(CheckFunctionExists)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(include)
include_directories(${CMAKE_BINARY_DIR}/include)

add_definitions(${LLVM_DEFINITIONS})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wno-unused-parameter")

check_include_files(malloc/malloc.h HAVE_MALLOC_MALLOC_H)
check_include_files(inttypes.h HAVE_INTTYPES_H)
check_include_files(memory.h HAVE_MEMORY_H)
check_function_exists(mallinfo HAVE_MALLINFO)

set(ENABLE_STP ON CACHE BOOL "Enable STP solver backend")
set(ENABLE_Z3 OFF CACHE BOOL "Enable Z3 solver backend")

if (LLVM_ENABLE_ASSERTIONS)
	set(ENABLE_KLEE_DEBUG ON)
endif()
if (LLVM_ENABLE_RTTI)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -frtti")
else()
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

set(KLEE_BUILD_MODE ${CMAKE_BUILD_TYPE})

configure_file(include/klee/Config/config.h.cmake include/klee/Config/config.h)
configure_file(include/klee/Config/CompileTimeInfo.h.cmake include/klee/Config/CompileTimeInfo.h)

if (${ENABLE_STP})
	find_package(STP REQUIRED CONFIG)
	add_definitions("-DEXT_HASH_MAP")
	include_directories(${STP_INCLUDE_DIRS})
endif()

add_definitions("-DKLEE_DIR=\"${CMAKE_BINARY_DIR}\"")
add_definitions("-DKLEE_INSTALL_BIN_DIR=\"${CMAKE_INSTALL_PREFIX}/bin\"")
add_definitions("-DKLEE_INSTALL_RUNTIME_DIR=\"${CMAKE_INSTALL_PREFIX}/lib/klee/runtime\"")

add_subdirectory(lib)
add_subdirectory(tools)
add_subdirectory(runtime)
