#!/bin/bash
# Tank Royale Nim Bot API - Quick Setup Script

echo "🎮 Tank Royale Nim Bot API - Quick Setup"
echo "========================================"

# Check if we're in the right directory
if [ ! -f "bot_api.nimble" ]; then
    echo "❌ Error: Please run this script from the nim/ directory"
    exit 1
fi

echo "📦 Installing dependencies..."
nimble install -y ws

echo ""
echo "🧪 Running test suite..."
nimble test

echo ""
echo "🎯 Compilation check..."
echo "Building advanced network bot..."
nim c --path:src examples/advanced_network_bot.nim

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Available commands:"
echo "  nimble test      - Run all tests"
echo "  nimble demo      - Run networking demo"
echo "  nimble example   - Run basic spinner bot"
echo "  nimble advanced  - Run advanced network bot (needs server)"
echo ""
echo "🚀 To start real testing:"
echo "1. Download Tank Royale server from:"
echo "   https://github.com/robocode-dev/tank-royale/releases"
echo "2. Start the server: java -jar tank-royale-server-X.X.X.jar"
echo "3. Run the bot: nimble advanced"
echo ""
echo "📖 See TESTING_GUIDE.md for detailed instructions"
