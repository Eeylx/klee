llvm_map_components_to_libnames(llvm_libs
  bitreader bitwriter ipo linker engine support)

add_executable(klee
  klee/Debug.cpp
  klee/main.cpp)

add_executable(kleaver
  kleaver/main.cpp)

add_executable(gen-random-bout
  gen-random-bout/gen-random-bout.cpp)

add_executable(klee-replay
  klee-replay/fd_init.c
  klee-replay/file-creator.c
  klee-replay/klee_init_env.c
  klee-replay/klee-replay.c)

target_link_libraries(klee
  kleeCore
  kleeBasic
  kleeModule
  kleaverSolver
  kleaverExpr
  kleeSupport
  ${llvm_libs}
)

target_link_libraries(kleaver
  kleeBasic
  kleaverSolver
  kleaverExpr
  kleeSupport
  ${llvm_libs})

target_link_libraries(gen-random-bout kleeBasic)
target_link_libraries(klee-replay kleeBasic util)

install(TARGETS klee kleaver gen-random-bout klee-replay
  RUNTIME DESTINATION bin
  )

install(PROGRAMS
  klee-stats/klee-stats
  ktest-tool/ktest-tool
  DESTINATION bin
  )
