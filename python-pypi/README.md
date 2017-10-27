{% extends "_shared/README.md" %}

{% block description %}
Simple Python tool for distribution via PyPI etc.
{% endblock %}

{% block content -%}
## Install prerequisites

```
pip install setuptools-markdown
```

## Run tests

```
python setup.py test
```

## Upload to [PyPI][pypi]

```
python setup.py sdist upload
```
{% endblock %}

{% block end_matter %}
[pypi]: https://pypi.python.org/pypi
{% endblock %}
