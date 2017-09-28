{% extends "_shared/README.md" %}

{% block description %}
Python game using [pygame][PyGame]
{% endblock %}

{% block content %}
## Running the game

```
./{{project_name}}
```

This will bootstrap and run the game. It should work on Windows, macOS and Linux (including [Raspbian][raspbian]).
{% endblock %}

{% block end_matter %}
[pygame]: https://www.pygame.org/
[raspbian]: https://www.raspbian.org/
{% endblock %}