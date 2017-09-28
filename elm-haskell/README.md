{% extends "_shared/README.md" %}

{% block description %}
This project is bootstrapped with [create-elm-app][create-elm-app].{% endblock %}

{% block content %}
## Frontend

### Running app

```
cd frontend
elm-app start
```

### Other tasks

* `elm-app build`
* `elm-app test`
* `elm-app eject`
* `elm-app package`
* `elm-app repl`
* `elm-app make`
* `elm-app reactor`

### Installing additional packages

Elm packages:
```
elm-app package install <package-name>
```

NPM packages:
```
npm install --save <package-name>
```

## Backend

### Building app

```
cd backend
stack setup
stack build --fast
```

### Running server

```
cd backend
stack exec {{project_name}}-app -- --port 3333
```
{% endblock %}

{% block end_matter %}
[create-elm-app]:(https://github.com/halfzebra/create-elm-app
{% endblock %}
