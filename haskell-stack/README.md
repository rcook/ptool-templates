# {{project_name}} by {{author}}

Haskell application with main executable only built using Stack

## Clone repository

```
git clone {{ project_name | git_url(git_server) }}
```

## Install compiler

```
stack setup
```

## Build

```
stack build
```

## Run application

```
stack exec {{project_name}}-app
```

## Run tests

```
stack test
```

## Licence

Released under [MIT License][licence]

[licence]: LICENSE
