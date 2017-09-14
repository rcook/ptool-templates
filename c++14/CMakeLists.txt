$cmake_copyright
cmake_minimum_required(VERSION 3.0)
project($project_name)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_CXX_STANDARD 14)

include(threads)

add_subdirectory(app)
add_subdirectory(lib)
add_subdirectory(test)
