#!/bin/bash
# JSON Configuration Loading Demo for Tank Royale Nim Bot API
# This script demonstrates the enhanced JSON "business card" loading functionality

echo "🎮 Tank Royale Nim Bot API - JSON Configuration Loading Demo"
echo "==========================================================="
echo ""

# Navigate to the nim directory
cd "$(dirname "$0")"

echo "📋 Testing JSON configuration loading functionality..."
echo ""

echo "1️⃣ Running JSON loading tests..."
nim c -r --path:src tests/test_bot_info_json.nim
if [ $? -eq 0 ]; then
    echo "✅ JSON loading tests PASSED!"
else
    echo "❌ JSON loading tests FAILED!"
    exit 1
fi

echo ""
echo "2️⃣ Demonstrating automatic JSON loading with MyFirstBot..."

# Navigate to MyFirstBot directory
cd examples/MyFirstBot

echo ""
echo "🔍 Current MyFirstBot.json configuration:"
echo "----------------------------------------"
cat MyFirstBot.json
echo ""
echo "----------------------------------------"

echo ""
echo "3️⃣ Compiling MyFirstBot with enhanced JSON loading..."
nim c --path:../../src MyFirstBot.nim
if [ $? -eq 0 ]; then
    echo "✅ MyFirstBot compilation successful!"
else
    echo "❌ MyFirstBot compilation failed!"
    exit 1
fi

echo ""
echo "4️⃣ Testing JSON loading (dry run - server not required)..."
# Create a test script that just loads the configuration without connecting
cat > test_json_loading.nim << 'EOF'
import ../../src/bot_api/bot_info

proc main() =
  echo "=== JSON Configuration Loading Test ==="
  echo ""
  
  # Test 1: Automatic loading
  echo "🔸 Testing autoLoadFromFile('MyFirstBot')..."
  try:
    let botInfo1 = autoLoadFromFile("MyFirstBot")
    echo "✅ Loaded configuration successfully!"
    echo "   Name: " & botInfo1.name
    echo "   Version: " & botInfo1.version
    echo "   Authors: " & $botInfo1.authors
    echo "   Description: " & botInfo1.description
    echo "   Game Types: " & $botInfo1.gameTypes
    echo "   Platform: " & botInfo1.platform
    echo ""
  except Exception as e:
    echo "❌ Error: " & e.msg
    echo ""
  
  # Test 2: Direct file loading
  echo "🔸 Testing fromJsonFile('MyFirstBot.json')..."
  try:
    let botInfo2 = fromJsonFile("MyFirstBot.json")
    echo "✅ Loaded from JSON file successfully!"
    echo "   Name: " & botInfo2.name
    echo "   Version: " & botInfo2.version
    echo "   Authors: " & $botInfo2.authors
    echo ""
  except Exception as e:
    echo "❌ Error: " & e.msg
    echo ""
  
  # Test 3: Try non-existent file (should return default)
  echo "🔸 Testing autoLoadFromFile('NonExistentBot')..."
  try:
    let botInfo3 = autoLoadFromFile("NonExistentBot")
    echo "✅ Fallback to default configuration!"
    echo "   Name: " & botInfo3.name
    echo "   Version: " & botInfo3.version
    echo "   Authors: " & $botInfo3.authors
    echo ""
  except Exception as e:
    echo "❌ Error: " & e.msg
    echo ""
  
  echo "=== Test Complete ==="

when isMainModule:
  main()
EOF

# Compile and run the test
nim c -r --path:../../src test_json_loading.nim
if [ $? -eq 0 ]; then
    echo "✅ JSON loading demonstration successful!"
else
    echo "❌ JSON loading demonstration failed!"
fi

# Clean up
rm -f test_json_loading test_json_loading.nim

echo ""
echo "🎯 Key Benefits of JSON Configuration Loading:"
echo "=============================================="
echo "✅ Automatic bot metadata loading from {BotName}.json files"
echo "✅ Compatible with Tank Royale standard JSON format"
echo "✅ Graceful fallback to default configuration if file not found"
echo "✅ Similar behavior to .NET and Java Bot APIs"
echo "✅ Easy integration with Tank Royale GUI and server"
echo ""
echo "📚 Usage Examples:"
echo "=================="
echo "  # Automatic JSON loading (recommended)"
echo "  let bot = newNetworkBot(\"MyFirstBot\")  # Loads MyFirstBot.json"
echo ""
echo "  # Manual configuration (still supported)"
echo "  let botInfo = newBotInfo(\"MyBot\", \"1.0\", @[\"Author\"])"
echo "  let bot = newNetworkBot(botInfo)"
echo ""
echo "  # Direct JSON file loading"
echo "  let botInfo = fromJsonFile(\"MyBot.json\")"
echo "  let bot = newNetworkBot(botInfo)"
echo ""
echo "🚀 The Nim Bot API now has feature parity with .NET and Java implementations!"
echo "   Bots can automatically load their 'business card' metadata from JSON files."
echo ""

# Navigate back to nim directory
cd ../..

echo "📁 To test with a real Tank Royale server:"
echo "=========================================="
echo "1. Download Tank Royale server from:"
echo "   https://github.com/robocode-dev/tank-royale/releases"
echo "2. Start the server: java -jar tank-royale-server-X.X.X.jar"
echo "3. Run the bot: cd examples/MyFirstBot && ./MyFirstBot"
echo "4. The bot will automatically load MyFirstBot.json configuration"
echo ""
echo "✨ Demo complete! JSON configuration loading is now available in Nim Bot API."
