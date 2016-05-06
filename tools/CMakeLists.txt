llvm_map_components_to_libnames(llvm_libs
	bitreader bitwriter ipo linker engine support)

add_executable(klee
	klee/Debug.cpp
	klee/main.cpp)

add_executable(kleaver
	kleaver/main.cpp)

add_executable(gen-random-bout
	gen-random-bout/gen-random-bout.cpp)

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
