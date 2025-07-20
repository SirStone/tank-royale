#!/bin/bash
# Script to convert all bot directories to source-based structure

BOTS=("MyFirstBot" "SpinBot" "CornersBot" "CrazyBot" "VelocityBot")
SOURCE_FILES=("my_first_bot.nim" "spin_bot.nim" "corners_bot.nim" "crazy_bot.nim" "velocity_bot.nim")

echo "Converting bot directories to source-based structure..."

for i in "${!BOTS[@]}"; do
    BOT_NAME="${BOTS[$i]}"
    SOURCE_FILE="${SOURCE_FILES[$i]}"
    
    echo "Processing $BOT_NAME..."
    
    # Copy source file to bot directory
    cp "examples/$SOURCE_FILE" "examples/$BOT_NAME/$BOT_NAME.nim"
    
    # Fix import paths in the source file
    sed -i 's|import ../src/bot_api/|import bot_api/|g' "examples/$BOT_NAME/$BOT_NAME.nim"
    
    # Update shell script
    cat > "examples/$BOT_NAME/$BOT_NAME.sh" << EOF
#!/bin/bash
# $BOT_NAME startup script for Linux/macOS
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "\$SCRIPT_DIR"

# Check if --compile flag is passed
if [[ "\$1" == "--compile" ]]; then
    echo "Compiling $BOT_NAME..."
    nim c --path:../../src $BOT_NAME.nim
    if [ \$? -eq 0 ]; then
        echo "Compilation successful!"
    else
        echo "Compilation failed!"
        exit 1
    fi
else
    # Check if compiled binary exists
    if [ ! -f "./$BOT_NAME" ]; then
        echo "Compiled binary not found. Please compile first with: \$0 --compile"
        exit 1
    fi
    
    # Run the compiled binary with all arguments
    ./$BOT_NAME "\$@"
fi
EOF

    # Update Windows batch script
    cat > "examples/$BOT_NAME/$BOT_NAME.cmd" << EOF
@echo off
rem $BOT_NAME startup script for Windows
cd /d "%~dp0"

rem Check if --compile flag is passed
if "%1"=="--compile" (
    echo Compiling $BOT_NAME...
    nim c --path:..\\..\\src $BOT_NAME.nim
    if %errorlevel% equ 0 (
        echo Compilation successful!
    ) else (
        echo Compilation failed!
        exit /b 1
    )
) else (
    rem Check if compiled binary exists
    if not exist "$BOT_NAME.exe" (
        echo Compiled binary not found. Please compile first with: %0 --compile
        exit /b 1
    )
    
    rem Run the compiled binary with all arguments
    $BOT_NAME.exe %*
)
EOF

    # Make shell script executable
    chmod +x "examples/$BOT_NAME/$BOT_NAME.sh"
    
    echo "$BOT_NAME converted successfully!"
done

echo "All bots converted to source-based structure!"
