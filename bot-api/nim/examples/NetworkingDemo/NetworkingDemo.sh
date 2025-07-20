#!/bin/bash

# NetworkingDemo startup script for Tank Royale
# Usage: ./NetworkingDemo.sh [--compile]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "$SCRIPT_DIR"

BOT_NAME="NetworkingDemo"

# Check for compile flag
if [ "$1" = "--compile" ]; then
    echo "Compiling $BOT_NAME..."
    nim compile --path:../../src "$BOT_NAME.nim"
    
    if [ $? -ne 0 ]; then
        echo "❌ Compilation failed for $BOT_NAME"
        exit 1
    fi
    
    echo "✅ $BOT_NAME compiled successfully"
    shift  # Remove --compile from arguments
fi

# Check if binary exists
if [ ! -f "$BOT_NAME" ]; then
    echo "❌ Binary '$BOT_NAME' not found. Run with --compile flag first:"
    echo "   $0 --compile"
    exit 1
fi

# Run the demo
echo "🚀 Starting $BOT_NAME..."
./"$BOT_NAME" "$@"
