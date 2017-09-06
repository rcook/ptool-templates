add_executable(scratch-test
  ExampleTest.cpp
  main.cpp
)

target_include_directories(scratch-test PUBLIC
  ../external/catch/include
  ../lib/public
)

target_link_libraries(scratch-test scratch-lib)
