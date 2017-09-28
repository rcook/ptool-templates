{% extends "_shared/elm/src/index.js" %}

{% block embed %}
Elm.App.embed(root, {
    logoPath: logoPath,
    apiRootUrl: process.env.{{env_project_name}}_API_ROOT_URL
})
{% endblock %}