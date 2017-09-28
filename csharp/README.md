{% extends "_shared/README.md" %}

{% block description %}
C# application with app built using MSBuild or [xbuild][xbuild]
{% endblock %}

{% block content %}
## Build

```
msbuild {{project_name}}.csproj /t:Build
```
{% endblock %}

{% block end_matter %}
[xbuild]: http://www.mono-project.com/docs/tools+libraries/tools/xbuild/
{% endblock %}