:<<"::CMDLITERAL"
@echo off
goto :CMDSCRIPT
::CMDLITERAL
#!/bin/bash
set -euo pipefail
IFS=$$'\n\t'

script_dir=$$(cd $$(dirname $$0); pwd -P)
repo_dir=$$(dirname $$script_dir)
build_dir=$$repo_dir/_build

if [ -d $$build_dir ]; then
  rm -rf $$build_dir
fi

mkdir -p $$build_dir
cd $$build_dir
cmake \
  -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=Debug \
  -DSANITIZE_ADDRESS=On \
  ..

exit $$?

:CMDSCRIPT
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
