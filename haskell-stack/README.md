{% extends "_shared/README.md" %}

{% block description %}
Haskell application with main executable only built using Stack
{% endblock %}

{% block content %}
## Install compiler

```
stack setup
```

## Build

```
stack build --fast
```

## Run application

```
stack exec {{project_name}}-app
```

## Run tests

```
stack test
```
{% endblock %}
