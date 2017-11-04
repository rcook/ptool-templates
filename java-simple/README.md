{% extends "_shared/README.md" %}

{% block description %}
Java application with app built using Maven
{% endblock %}

{% block content %}
## Build

```
mvn compile
```

## Package

```
mvn package
```

This builds and runs test before generating the output package.

## Run

```
mvn exec:java -q
```
{% endblock %}
