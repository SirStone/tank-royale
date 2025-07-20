## ------------------------------------------------------------------
## BasicBot Template
## ------------------------------------------------------------------
## A simple template for creating Tank Royale bots in Nim.
## This demonstrates the basic structure and common patterns.
##
## Use this as a starting point for your own bot implementations.
## ------------------------------------------------------------------

import asyncdispatch
import ../src/bot_api/network_bot
import ../src/bot_api/bot_info
import ../src/bot_api/base_bot
import ../src/bot_api/events/scanned_bot_event
import ../src/bot_api/events/hit_by_bullet_event
import ../src/bot_api/events/hit_bot_event
import ../src/bot_api/events/hit_wall_event
import ../src/bot_api/events/bullet_fired_event
import ../src/bot_api/events/death_event

type
  BasicBot* = ref object of NetworkBot
    ## Template for a basic Tank Royale bot
    strategy: string  # Current strategy state
    targetX, targetY: float
    scanDirection: float

# Override event handlers - customize these for your bot's behavior
method onScannedBot*(bot: BasicBot, event: ScannedBotEvent) =
  ## Called when we scan an enemy bot
  bot.log("Enemy detected! Firing...")
  bot.fire(2.0)

method onHitByBullet*(bot: BasicBot, event: HitByBulletEvent) =
  ## Called when we're hit by a bullet
  bot.log("Ouch! Hit by bullet, evading...")
  # Simple evasion - turn perpendicular to bullet direction
  let bearing = bot.calcBearing(event.bullet.direction)
  bot.turnRight(90.0 - bearing)

method onHitBot*(bot: BasicBot, event: HitBotEvent) =
  ## Called when we collide with another bot
  bot.log("Collision with another bot!")
  # Back away from the collision
  bot.back(50.0)

method onHitWall*(bot: BasicBot, event: HitWallEvent) =
  ## Called when we hit a wall
  bot.log("Hit wall, turning around...")
  # Simple wall avoidance - turn around
  bot.turnRight(90.0)

method onBulletFired*(bot: BasicBot, event: BulletFiredEvent) =
  ## Called when we fire a bullet
  bot.log("Bullet fired!")

method onDeath*(bot: BasicBot, event: DeathEvent) =
  ## Called when our bot dies
  bot.log("Bot destroyed! Game over.")

# Override the run method to implement main bot behavior
method run*(bot: BasicBot) =
  ## Main bot AI logic - customize this for your strategy
  
  # Set bot colors (optional)
  bot.setBodyColor("#4169E1")    # Royal blue
  bot.setTurretColor("#FFD700")  # Gold
  bot.setRadarColor("#FF4500")   # Orange red
  bot.setBulletColor("#00FF00")  # Green
  bot.setScanColor("#FF69B4")    # Hot pink
  
  bot.log("BasicBot started - implementing basic strategy")
  bot.strategy = "patrol"
  bot.scanDirection = 0.0
  
  # Main game loop
  while bot.isRunning():
    case bot.strategy:
    of "patrol":
      # Simple patrol pattern
      bot.forward(100.0)
      bot.turnRight(45.0)
      
      # Continuous radar scanning
      bot.scanDirection += 30.0
      if bot.scanDirection >= 360.0:
        bot.scanDirection = 0.0
      bot.turnRadarRight(30.0)
      
      # Occasionally fire to deter enemies
      if bot.getEnemyCount() > 0:
        bot.fire(1.0)
        
    else:
      # Default behavior
      bot.forward(50.0)
      bot.turnGunRight(360.0)
    
    # Update strategy based on game state (example)
    if bot.getEnergy() < 20.0:
      bot.strategy = "defensive"
      bot.log("Low energy, switching to defensive mode")

proc newBasicBot*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
                  serverSecret: string = "", debugMode: bool = true): BasicBot =
  ## Create a new BasicBot instance
  result = cast[BasicBot](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))
  result.strategy = "patrol"
  result.scanDirection = 0.0

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - BasicBot Template ==="
  
  # Create bot info - customize this for your bot
  let botInfo = newBotInfo(
    name = "BasicBot",
    version = "1.0.0", 
    authors = @["Your Name"],
    description = "A basic bot template for Tank Royale",
    homepage = "https://github.com/yourusername/your-bot-repo",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newBasicBot(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting BasicBot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  echo ""
  echo "Customize this template by:"
  echo "1. Modifying the event handlers (onScannedBot, onHitWall, etc.)"
  echo "2. Implementing your strategy in the run() method"
  echo "3. Adding your own bot logic and AI"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
