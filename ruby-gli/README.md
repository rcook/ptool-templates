{% extends "_shared/README.md" %}

{% block description %}
[![Build status](https://travis-ci.org/rcook/gem-template.png)](https://travis-ci.org/rcook/gem-template)

A Ruby gem
{% endblock %}

{% block content -%}
## Prerequisites

```
gem install bundler
```

## Set up environment

```
bundle install
```

## Run tests

```
bundle exec rake test
```

## Run script

```
bundle exec {{project_name}}
```
{% endblock %}