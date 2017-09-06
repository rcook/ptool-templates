add_library($project_name-lib
  Example.cpp
  public/${project_name}lib/Example.h
)

target_include_directories($project_name-lib PUBLIC public)
