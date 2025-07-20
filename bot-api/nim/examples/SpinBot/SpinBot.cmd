@echo off
rem SpinBot startup script for Windows
cd /d "%~dp0"

rem Check if --compile flag is passed
if "%1"=="--compile" (
    echo Compiling SpinBot...
    nim c --path:..\..\src SpinBot.nim
    if %errorlevel% equ 0 (
        echo Compilation successful!
    ) else (
        echo Compilation failed!
        exit /b 1
    )
) else (
    rem Check if compiled binary exists
    if not exist "SpinBot.exe" (
        echo Compiled binary not found. Please compile first with: %0 --compile
        exit /b 1
    )
    
    rem Run the compiled binary with all arguments
    SpinBot.exe %*
)
