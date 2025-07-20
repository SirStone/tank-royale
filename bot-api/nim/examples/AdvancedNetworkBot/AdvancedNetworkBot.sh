#!/bin/bash
# AdvancedNetworkBot startup script for Linux/macOS
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "$SCRIPT_DIR"

# Check if --compile flag is passed
if [[ "$1" == "--compile" ]]; then
    echo "Compiling AdvancedNetworkBot..."
    nim c --path:../../src AdvancedNetworkBot.nim
    if [ $? -eq 0 ]; then
        echo "Compilation successful!"
    else
        echo "Compilation failed!"
        exit 1
    fi
else
    # Check if compiled binary exists
    if [ ! -f "./AdvancedNetworkBot" ]; then
        echo "Compiled binary not found. Please compile first with: $0 --compile"
        exit 1
    fi
    
    # Run the compiled binary with all arguments
    ./AdvancedNetworkBot "$@"
fi
