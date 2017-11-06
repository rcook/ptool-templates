{% extends "_shared/README.md" %}

{% block description %}
Java application with app built using Maven
{% endblock %}

{% block content %}
## Build

```
gradle build
```

## Test

```
gradle test
```

## Run main entrypoint

```
gradle main
```

And pass some arguments:

```
gradle main -PmainArgs=a,b,c
```
{% endblock %}
