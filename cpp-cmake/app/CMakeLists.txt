{{cmake_copyright}}
add_executable({{project_name}}-app main.cpp)
target_include_directories({{project_name}}-app PUBLIC ../lib/public)
target_link_libraries({{project_name}}-app {{project_name}}-lib)
