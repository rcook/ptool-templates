{% extends "_shared/README.md" %}

{% block description %}
[![View on PyPI](https://img.shields.io/pypi/v/{{project_name}}.svg)](https://pypi.python.org/pypi/{{project_name}})

Python tool with virtual environment wrappers
{% endblock %}

{% block content -%}

## Set up Python virtual environment

```
script/virtualenv
```

## Dev-install main script into virtual environment

```
script\env pip install -e .
```

This will allow edits to the scripts to be picked up automatically

## Run main script in virtual environment

```
script/env {{project_name}} --version
```

## Build package

```
script/env python setup.py build
```

## Test package

```
script/env python setup.py test
```

## Upload package

```
script/env python setup.py sdist upload
```

## Install package into global site packages

```
python setup.py install --record files.txt
```

Note that this calls the `python` global Python instead of the Python in the project's virtual environment.

## Notes

Various package properties are defined in `{{project_name}}/__init__py`:

* `__project_name__`
* `__version__`
* `__description__`

When publishing a new build of the package, ensure that `__version__` is incremented as appropriate.

## User-level installation

```
pip install --user {{project_name}}
```

This will perform a user-level installation of the package. The scripts will be placed at:

* Windows: `%APPDATA%\Python\Scripts`
* Linux/macOS: `$HOME/.local/bin`

## Global installation

```
pip install {{project_name}}
```

This will perform a global installation of the package and should add the script to `PATH`.
{% endblock %}

{% block end_matter %}
[pypi]: https://pypi.python.org/pypi
{% endblock %}
