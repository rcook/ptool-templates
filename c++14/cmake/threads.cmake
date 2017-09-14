$cmake_copyright
find_package(Threads REQUIRED)

function(add_threads target)
    if(THREADS_HAVE_PTHREAD_ARG)
        target_compile_options($${target} PUBLIC "-pthread")
    endif()
    if(CMAKE_THREAD_LIBS_INIT)
        target_link_libraries($${target} "$${CMAKE_THREAD_LIBS_INIT}")
    endif()
endfunction()
