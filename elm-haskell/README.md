{% extends "_shared/README.md" %}

{% block description %}
This project is bootstrapped with [create-elm-app][create-elm-app].{% endblock %}

{% block content %}
## Code generation

```
script/codegen
```

## Frontend

### Running app

```
script/frontend
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
cd frontend
elm-app package install <package-name>
```

NPM packages:
```
cd frontend
npm install --save <package-name>
```

## Backend

### Running app

```
script/backend
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
