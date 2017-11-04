{% extends "_shared/universal_script.cmd" %}

{% block bash %}
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

this_dir=$(cd $(dirname $0); pwd -P)
cd $this_dir
args=(${@// /\\ })
mvn exec:java -Dexec.mainClass="{{reversed_domain}}.App" -Dexec.args="${args[*]}"
exit $?
{% endblock %}

{% block cmd %}
@echo off
setlocal
set args=%*
call :Main "%~dp0\."
goto :eof

:Main
set this_dir=%~f1
cd /d "%this_dir%"
mvn exec:java -Dexec.mainClass="{{reversed_domain}}.App" -Dexec.args="%args%" || exit /b 1
goto :eof
{% endblock %}
