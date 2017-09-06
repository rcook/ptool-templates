@echo off
setlocal
call :Main "%~f0" "%~dp0" "%~dp0.."
goto :eof

:Main
set script_path=%~f1
set script_dir=%~f2
set repo_dir=%~f3
set build_dir=%repo_dir%\_build

if exist "%build_dir%" (
    rd /s /q "%build_dir%"
)

mkdir "%build_dir%"
cd /d "%build_dir%"
cmake -G "Visual Studio 14 2015 Win64" ..