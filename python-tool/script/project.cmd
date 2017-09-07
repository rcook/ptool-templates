:<<"::CMDLITERAL"
@echo off
goto :CMDSCRIPT
::CMDLITERAL
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

script_dir=$(cd $(dirname $0); pwd -P)

$script_dir/bootstrap $script_dir/$project_name.py $*

exit $?

:CMDSCRIPT
@echo off
call "%~dp0bootstrap.cmd" "%~dp0$project_name.py" %*
if errorlevel 1 (
    echo script failed
    exit /b 1
)
