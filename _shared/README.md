# {{project_name}} by {{author}}
{% block description %}
DESCRIPTION
{% endblock %}
## Clone repository

```
{%- block cloning_repo %}
git clone {{ project_name | git_clone_url(git_server) }}
{% endblock -%}
```
{% block content %}
CONTENT
{% endblock %}
## Licence

Released under [MIT License][licence]

[licence]: LICENSE
{%- block end_matter %}
{% endblock %}