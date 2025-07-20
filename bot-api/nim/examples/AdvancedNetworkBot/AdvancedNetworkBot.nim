## Advanced example bot that can connect to a real Tank Royale server
## This bot demonstrates networking, debugging, and strategy implementation

import asyncdispatch, random, math, strformat
import bot_api/network_bot
import bot_api/bot_info
import bot_api/base_bot
import bot_api/constants

type
  MyTankBot* = ref object of NetworkBot
    ## Advanced example tank bot with strategy
    targetX, targetY: float
    scanDirection: float
    lastEnemyAngle: float
    hasTarget: bool

# Override the run method to implement bot behavior
method run*(bot: MyTankBot) =
  ## Main bot AI logic - called every turn
  
  # Strategy: 
  # 1. Move around the battlefield in a pattern
  # 2. Continuously scan for enemies
  # 3. Fire when enemies are detected
  # 4. Avoid walls
  
  # Move in a square pattern around the battlefield
  if not bot.hasTarget:
    bot.targetX = rand(100.0..700.0)  # Assuming 800x600 arena
    bot.targetY = rand(100.0..500.0) 
    bot.hasTarget = true
    bot.log(&"New target: ({bot.targetX:.1f}, {bot.targetY:.1f})")
  
  # Basic movement (would need actual position from game state)
  bot.forward(50.0)
  
  # Turn towards target (simplified - in real game would calculate from current position)
  bot.turnRight(5.0)
  
  # Radar scanning pattern
  bot.scanDirection += 10.0
  if bot.scanDirection > 360.0:
    bot.scanDirection = 0.0
  bot.turnRadarRight(10.0)
  
  # Fire occasionally (in real game would fire when enemies detected)
  if rand(1.0) < 0.1:  # 10% chance to fire each turn
    bot.fire(2.0)
    bot.log("Firing at random target!")
  
  # Occasionally change direction
  if rand(1.0) < 0.05:  # 5% chance to change direction
    bot.hasTarget = false
    bot.log("Changing movement pattern")

proc newMyTankBot*(): MyTankBot =
  ## Create a new MyTankBot configured for networking
  let botInfo = newBotInfo(
    name = "MyTankBot",
    version = "1.0.0",
    authors = @["Nim Developer"],
    description = "Advanced networked tank bot with strategy and debugging",
    homepage = "https://github.com/nim-lang/tank-royale-nim",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create bot with server connection
  # Default server URL is ws://localhost:7654 (standard Tank Royale server)
  result = cast[MyTankBot](newNetworkBot(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",  # Change this to match your server
    serverSecret = "",                   # Add secret if your server requires it
    debugMode = true                    # Enable detailed logging
  ))
  
  # Initialize strategy variables
  result.targetX = 400.0
  result.targetY = 300.0
  result.scanDirection = 0.0
  result.lastEnemyAngle = 0.0
  result.hasTarget = false

# Main program
when isMainModule:
  echo "=== Tank Royale Nim Bot - Advanced Networked Example ==="
  echo "This bot will connect to a Tank Royale server and participate in battles."
  echo ""
  echo "Prerequisites:"
  echo "1. Start Tank Royale server (usually on localhost:7654)"
  echo "2. Configure the bot in the server UI"
  echo "3. Start a game with this bot included"
  echo ""
  
  randomize()  # Initialize random number generator
  
  let myBot = newMyTankBot()
  let myBotInfo = cast[BaseBot](myBot).getBotInfo()
  echo &"Created bot: {myBotInfo.name} v{myBotInfo.version}"
  echo &"Server URL: {myBot.getServerUrl()}"
  echo &"Debug mode: {myBot.debugMode}"
  echo ""
  echo "Starting bot... (Press Ctrl+C to stop)"
  
  try:
    waitFor myBot.start()
    echo "Bot finished normally."
  except CatchableError as e:
    echo &"Bot error: {e.msg}"
  
  echo "Bot terminated."
