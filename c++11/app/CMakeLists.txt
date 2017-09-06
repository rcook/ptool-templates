add_executable(scratch-app main.cpp)
target_include_directories(scratch-app PUBLIC ../lib/public)
target_link_libraries(scratch-app scratch-lib)
