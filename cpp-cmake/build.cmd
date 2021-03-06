{% extends "_shared/universal_script.cmd" %}

{% block bash %}
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

script_dir=$(cd $(dirname $0); pwd -P)
repo_dir=$(dirname $script_dir)
build_dir=$repo_dir/_build

cmake --build $build_dir

exit $?
{% endblock %}

{% block cmd %}
@echo off
setlocal
call :Main "%~f0" "%~dp0" "%~dp0.."
goto :eof

:Main
set script_path=%~f1
set script_dir=%~f2
set repo_dir=%~f3
set build_dir=%repo_dir%\_build

cmake --build "%build_dir%"
{% endblock %}