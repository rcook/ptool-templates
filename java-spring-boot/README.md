{% extends "_shared/README.md" %}

{% block description %}
Java application with app built using Maven
{% endblock %}

{% block content %}
## Build

```
mvn package
```

This builds and runs test before generating the output package.

## Run

```
mvn spring-boot:run
```
{% endblock %}
