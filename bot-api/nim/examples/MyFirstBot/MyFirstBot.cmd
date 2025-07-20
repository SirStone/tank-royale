@echo off
rem MyFirstBot startup script for Windows
cd /d "%~dp0"

rem Check if --compile flag is passed
if "%1"=="--compile" (
    echo Compiling MyFirstBot...
    nim c --path:..\..\src MyFirstBot.nim
    if %errorlevel% equ 0 (
        echo Compilation successful!
    ) else (
        echo Compilation failed!
        exit /b 1
    )
) else (
    rem Check if compiled binary exists
    if not exist "MyFirstBot.exe" (
        echo Compiled binary not found. Please compile first with: %0 --compile
        exit /b 1
    )
    
    rem Run the compiled binary with all arguments
    MyFirstBot.exe %*
)
