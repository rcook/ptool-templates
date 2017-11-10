{% extends "_shared/README.md" %}

{% block description %}
Precompiled Java web app with Gradle build
{% endblock %}

{% block content %}
## Build

```
gradle build
```

## Run tests

```
gradle test
```

## Build WAR archive

```
gradle war
```
{% endblock %}
