add_executable($project_name-test
  ExampleTest.cpp
  main.cpp
)

target_include_directories($project_name-test PUBLIC
  ../external/catch/include
  ../lib/public
)

target_link_libraries($project_name-test $project_name-lib)
