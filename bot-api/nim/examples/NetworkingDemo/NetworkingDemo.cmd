@echo off
rem NetworkingDemo startup script for Tank Royale (Windows)
rem Usage: NetworkingDemo.cmd [--compile]

setlocal enabledelayedexpansion
cd /d "%~dp0"

set BOT_NAME=NetworkingDemo

rem Check for compile flag
if "%1"=="--compile" (
    echo Compiling %BOT_NAME%...
    nim compile --path:../../src %BOT_NAME%.nim
    
    if !errorlevel! neq 0 (
        echo ❌ Compilation failed for %BOT_NAME%
        exit /b 1
    )
    
    echo ✅ %BOT_NAME% compiled successfully
    shift /1
)

rem Check if binary exists
if not exist "%BOT_NAME%.exe" (
    echo ❌ Binary '%BOT_NAME%.exe' not found. Run with --compile flag first:
    echo    %0 --compile
    exit /b 1
)

rem Run the demo
echo 🚀 Starting %BOT_NAME%...
%BOT_NAME%.exe %*
