add_library(kleeBasic
  Basic/CmdLineOptions.cpp
  Basic/ConstructSolverChain.cpp
  Basic/Statistics.cpp
  Basic/KTest.cpp
)

add_library(kleeSupport
  Support/ErrorHandling.cpp
  Support/MemoryUsage.cpp
  Support/PrintVersion.cpp
  Support/RNG.cpp
  Support/Time.cpp
  Support/Timer.cpp
  Support/TreeStream.cpp
)

add_library(kleaverExpr
  Expr/ArrayCache.cpp
  Expr/Assigment.cpp
  Expr/Constraints.cpp
  Expr/ExprBuilder.cpp
  Expr/Expr.cpp
  Expr/ExprEvaluator.cpp
  Expr/ExprPPrinter.cpp
  Expr/ExprSMTLIBPrinter.cpp
  Expr/ExprUtil.cpp
  Expr/ExprVisitor.cpp
  Expr/Lexer.cpp
  Expr/Parser.cpp
  Expr/Updates.cpp
)

add_library(kleaverSolver
  Solver/CachingSolver.cpp
  Solver/CexCachingSolver.cpp
  Solver/ConstantDivision.cpp
  Solver/CoreSolver.cpp
  Solver/DummySolver.cpp
  Solver/FastCexSolver.cpp
  Solver/IncompleteSolver.cpp
  Solver/IndependentSolver.cpp
  Solver/MetaSMTSolver.cpp
  Solver/PCLoggingSolver.cpp
  Solver/QueryLoggingSolver.cpp
  Solver/SMTLIBLoggingSolver.cpp
  Solver/Solver.cpp
  Solver/SolverImpl.cpp
  Solver/SolverStats.cpp
  Solver/STPBuilder.cpp
  Solver/STPSolver.cpp
  Solver/ValidatingSolver.cpp
  Solver/Z3Builder.cpp
  Solver/Z3Solver.cpp
)

add_library(kleeModule
  Module/Checks.cpp
  Module/InstructionInfoTable.cpp
  Module/IntrinsicCleaner.cpp
  Module/KInstruction.cpp
  Module/KModule.cpp
  Module/LowerSwitch.cpp
  Module/ModuleUtil.cpp
  Module/Optimize.cpp
  Module/PhiCleaner.cpp
  Module/RaiseAsm.cpp
)

add_library(kleeCore
  Core/AddressSpace.cpp
  Core/CallPathManager.cpp
  Core/Context.cpp
  Core/CoreStats.cpp
  Core/ExecutionState.cpp
  Core/Executor.cpp
  Core/ExecutorTimers.cpp
  Core/ExecutorUtil.cpp
  Core/ExternalDispatcher.cpp
  Core/ImpliedValue.cpp
  Core/Memory.cpp
  Core/MemoryManager.cpp
  Core/PTree.cpp
  Core/Searcher.cpp
  Core/SeedInfo.cpp
  Core/SpecialFunctionHandler.cpp
  Core/StatsTracker.cpp
  Core/TimingSolver.cpp
  Core/UserSearcher.cpp
)

llvm_map_components_to_libnames(llvm_core
  core)
llvm_map_components_to_libnames(llvm_module
  support instcombine object scalaropts
  transformutils executionengine target
  codegen mc)

target_link_libraries(kleeCore ${llvm_core})
target_link_libraries(kleeModule ${llvm_module})
if (ENABLE_STP)
  target_link_libraries(kleaverSolver ${STP_STATIC_LIBRARY})
endif()
if (ENABLE_Z3)
  target_link_libraries(kleaverSolver ${Z3LIB})
endif()
