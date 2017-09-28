:<<"::CMDLITERAL"
@echo off
goto :CMDSCRIPT
::CMDLITERAL
{%- block bash %}
{% endblock -%}
:CMDSCRIPT
{%- block cmd %}
{% endblock -%}
