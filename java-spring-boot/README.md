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
java -cp target/{{project_name}}-1.0-SNAPSHOT.jar {{reversed_domain}}.app.App
```
{% endblock %}