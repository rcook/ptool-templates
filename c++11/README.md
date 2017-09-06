# $project_name by $author

C++ application with app, library and unit tests using CMake-generated build system

Features:

* Creates app, library and unit test targets
* Uses [Catch][catch] framework

## Clone repository

```
git clone --recurse-submodules git@github.com:$git_user_name/$project_name.git
```

## Generate and run build

```
script/run-cmake
cd _build
make
```

## Licence

Released under [MIT License][licence]

[catch]: https://github.com/philsquared/Catch
[licence]: LICENSE
