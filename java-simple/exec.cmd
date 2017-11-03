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
