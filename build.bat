@echo off && cls
REM USE: Bat to EXE converter.

del /f /q .\Ripper.exe

setLocal ENABLEDELAYEDEXPANSION

set BUILD_VERSION=0.0.0.4
set PRODUCT_VERSION=0.0.4

.\converter.exe /bat "Ripper.bat" /exe Ripper.exe /icon resources\assets\icon.ico /include resources /productversion !PRODUCT_VERSION! /productname "Rar ripper" /fileversion !BUILD_VERSION! /internalname "Ripper.bat" /copyright "Copyright 2022" /description "Rar ripper: BRUTE FORCE" /deleteonexit

exit /b
