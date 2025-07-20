## Simple test to verify method inheritance

import ../src/bot_api/base_bot
import ../src/bot_api/bot_info

# Test direct BaseBot usage
let testBotInfo = newBotInfo("TestBot", "1.0", @["Test Author"])
let myBot = newBaseBot(testBotInfo)

echo "BaseBot test:"
echo "- getBotInfo: ", myBot.getBotInfo().name
echo "- isRunning: ", myBot.isRunning()

myBot.start()
echo "- after start, isRunning: ", myBot.isRunning()

# Test some commands
myBot.setTargetSpeed(5.0)
myBot.setTurnRate(10.0)
myBot.go()

echo "BaseBot commands executed successfully!"
