# $project_name by $author

C++ application with app, library and unit tests using CMake-generated build system

Features:

* Creates app, library and unit test targets
* Uses [Catch][catch] framework

## Clone repository

```
git clone --recurse-submodules $public_git_repo:$git_user_name/$project_name.git
```

## Install prerequisites

### Linux (Ubuntu)

```
sudo apt-get install cmake
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
