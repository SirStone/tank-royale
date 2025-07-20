@echo off
rem AdvancedNetworkBot startup script for Windows
cd /d "%~dp0"

rem Check if --compile flag is passed
if "%1"=="--compile" (
    echo Compiling AdvancedNetworkBot...
    nim c --path:..\..\src AdvancedNetworkBot.nim
    if %errorlevel% equ 0 (
        echo Compilation successful!
    ) else (
        echo Compilation failed!
        exit /b 1
    )
) else (
    rem Check if compiled binary exists
    if not exist "AdvancedNetworkBot.exe" (
        echo Compiled binary not found. Please compile first with: %0 --compile
        exit /b 1
    )
    
    rem Run the compiled binary with all arguments
    AdvancedNetworkBot.exe %*
)
