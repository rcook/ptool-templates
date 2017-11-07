{% extends "_shared/README.md" %}

{% block description %}
[![View on PyPI](https://img.shields.io/pypi/v/{{project_name}}.svg)](https://pypi.python.org/pypi/{{project_name}})
[![Licence](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/{{ git_server | git_group }}/{{project_name}}/master/LICENSE)

Python tool with virtual environment wrappers
{% endblock %}

{% block content -%}

## Developer notes

Various package properties are defined in `{{project_name}}/__init__py`:

* `__project_name__`
* `__version__`
* `__description__`

When publishing a new build of the package, ensure that `__version__` is incremented as appropriate.
{% endblock %}

{% block end_matter %}
[pypi]: https://pypi.python.org/pypi
{% endblock %}
