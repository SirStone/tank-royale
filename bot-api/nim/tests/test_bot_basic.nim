import unittest
import ../src/bot_api/bot
import ../src/bot_api/bot_info
import ../src/bot_api/constants

suite "Bot Basic Tests":
  test "Bot creation":
    let botInfo = newBotInfo("TestBot", "1.0", @["Test Author"])
    let bot = newBot(botInfo)
    
    check bot != nil
    echo "✓ Bot creation test passed"

  test "Bot movement commands don't crash":
    let botInfo = newBotInfo("TestBot", "1.0", @["Test Author"])
    let bot = newBot(botInfo)
    
    # Test movement commands don't crash
    bot.forward(50.0)
    bot.back(30.0)
    bot.turnLeft(45.0)
    bot.turnRight(90.0)
    bot.turnGunLeft(30.0)
    bot.turnGunRight(60.0)
    bot.turnRadarLeft(90.0)
    bot.turnRadarRight(180.0)
    echo "✓ Bot movement commands test passed"

  test "Bot firing commands don't crash":
    let botInfo = newBotInfo("TestBot", "1.0", @["Test Author"])
    let bot = newBot(botInfo)
    
    # Test firing commands don't crash
    bot.fire()
    bot.fire(2.5)
    bot.fire(0.1)  # Should clamp to MIN_FIREPOWER
    bot.fire(5.0)  # Should clamp to MAX_FIREPOWER
    echo "✓ Bot firing commands test passed"

  test "Utility functions":
    # Test angle normalization
    check normalizeAngle(0.0) == 0.0
    check normalizeAngle(180.0) == 180.0
    check normalizeAngle(-180.0) == 180.0
    check normalizeAngle(270.0) == -90.0
    check normalizeAngle(-270.0) == 90.0
    
    # Test distance calculation
    check distanceTo(0.0, 0.0, 3.0, 4.0) == 5.0
    check distanceTo(0.0, 0.0, 0.0, 0.0) == 0.0
    
    # Test angle calculation
    let angle = angleTo(0.0, 0.0, 1.0, 1.0)
    check abs(angle - 45.0) < 0.001
    echo "✓ Utility functions test passed"

echo "All basic Bot tests completed successfully!"
