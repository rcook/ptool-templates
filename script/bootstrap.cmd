@echo off
setlocal

set python_path=%~dp0Scripts\python.exe
set pip_path=%~dp0Scripts\pip.exe

if not exist "%python_path%" (
    cd "%~dp0"
    virtualenv .
)

"%pip_path%" install -q -r "%~dp0requirements.txt"
"%python_path%" %*
