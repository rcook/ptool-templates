{% extends "_shared/README.md" %}

{% block description %}
Scala application with app built using SBT
{% endblock %}

{% block content %}
## Build

```
sbt compile
```

This builds and runs test before generating the output package.

## Run

```
sbt run
```
{% endblock %}
