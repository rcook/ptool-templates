# {{project_name}} by {{author}}

C++ application with app, library and unit tests using CMake-generated build system

Features:

* Creates app, library and unit test targets
* Uses [Catch][catch] framework

## Clone repository

```
git clone --recurse-submodules {{public_git_repo}}:{{git_user_name}}/{{project_name}}.git
```

## Install prerequisites

### Linux (Ubuntu)

```
sudo apt-get install cmake
```

## Generate build system

```
script/setup
```

This will generate build or project files under the `_build` directory.

## Build

```
script/build
```

Once a `_build` directory exists, this script will perform a build.

## Test

```
script/test
```

Once a `_build` directory exists, this script will build and run the `test` target.

## Licence

Released under [MIT License][licence]

[catch]: https://github.com/philsquared/Catch
[licence]: LICENSE
