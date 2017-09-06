add_library(scratch-lib
  Example.cpp
  public/scratchlib/Example.h
)

target_include_directories(scratch-lib PUBLIC public)
