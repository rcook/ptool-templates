{{cmake_copyright}}
add_executable({{project_name}}-test
  ExampleTest.cpp
  main.cpp
)

target_include_directories({{project_name}}-test PUBLIC
  ../external/catch/include
  ../lib/public
)

target_link_libraries({{project_name}}-test {{project_name}}-lib)

add_test(NAME {{project_name}}-test COMMAND {{project_name}}-test)
