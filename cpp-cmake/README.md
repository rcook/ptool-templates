{% extends "_shared/README.md" %}

{% block description %}
C++ application with app, library and unit tests using CMake-generated build system

Features:

* Creates app, library and unit test targets
* Uses [Catch][catch] framework
{% endblock %}

{%- block cloning_repo %}
git clone --recurse-submodules {{ project_name | git_clone_url(git_server) }}
{% endblock %}

{% block content %}
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
{% endblock %}

{% block end_matter %}
[catch]: https://github.com/catchorg/Catch
{% endblock %}
