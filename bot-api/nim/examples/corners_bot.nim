## ------------------------------------------------------------------
## Corners
## ------------------------------------------------------------------
## A sample bot originally made for Robocode by Mathew Nelson.
## Ported to Tank Royale Nim by the community.
##
## This robot moves to a corner, then rotates its gun back and forth
## scanning for enemies. If it performs poorly in a round, it will
## try a different corner in the next round.
## ------------------------------------------------------------------

import asyncdispatch, math, random
import ../src/bot_api/network_bot
import ../src/bot_api/bot_info
import ../src/bot_api/base_bot
import ../src/bot_api/events/scanned_bot_event
import ../src/bot_api/events/death_event

type
  Corners* = ref object of NetworkBot
    ## Bot that moves to corners and scans for enemies
    enemies: int           # Number of enemy bots in the game
    corner: int           # Which corner we are currently using
    stopWhenSeeEnemy: bool # See goCorner()

# Helper functions
proc randomCorner(): int =
  ## Returns a random corner (0, 90, 180, 270)
  return 90 * rand(0..3)

proc smartFire(bot: Corners, distance: float) =
  ## Custom fire method that determines firepower based on distance
  if distance > 200.0 or bot.energy < 15.0:
    bot.fire(1.0)
  elif distance > 50.0:
    bot.fire(2.0)
  else:
    bot.fire(3.0)

proc goCorner(bot: Corners) =
  ## A very inefficient way to get to a corner.
  ## Can you do better as a home exercise? :)
  
  # We don't want to stop when we're just turning...
  bot.stopWhenSeeEnemy = false
  # Turn to face the wall towards our desired corner
  bot.turnLeft(bot.calcBearing(bot.corner.float))
  # Ok, now we don't want to crash into any bot in our way...
  bot.stopWhenSeeEnemy = true
  # Move to that wall
  bot.forward(5000.0)
  # Turn to face the corner
  bot.turnLeft(90.0)
  # Move to the corner
  bot.forward(5000.0)
  # Turn gun to starting point
  bot.turnGunLeft(90.0)

# Override event handlers
method onScannedBot*(bot: Corners, event: ScannedBotEvent) =
  ## We saw another bot -> stop and fire!
  let distance = bot.distanceTo(event.x, event.y)
  
  # Should we stop, or just fire?
  if bot.stopWhenSeeEnemy:
    # Stop movement
    bot.stop()
    # Call our custom firing method
    bot.smartFire(distance)
    # Rescan for another bot
    bot.rescan()
    # This line will not be reached when scanning another bot.
    # So we did not scan another bot -> resume movement
    bot.resume()
  else:
    bot.smartFire(distance)

method onDeath*(bot: Corners, event: DeathEvent) =
  ## We died -> figure out if we need to switch to another corner
  # Well, others should never be 0, but better safe than sorry.
  if bot.enemies == 0:
    return
  
  # If 75% of the bots are still alive when we die, we'll switch corners.
  if bot.getEnemyCount().float / bot.enemies.float >= 0.75:
    bot.corner += 90  # Next corner
    bot.corner = bot.corner mod 360  # Make sure the corner is within 0 - 359
    
    echo "I died and did poorly... switching corner to ", bot.corner
  else:
    echo "I died but did well. I will still use corner ", bot.corner

# Override the run method to implement bot behavior
method run*(bot: Corners) =
  ## Main bot logic - move to corner and scan
  
  # Set colors (red theme)
  bot.setBodyColor("#FF0000")    # Red
  bot.setTurretColor("#000000")  # Black
  bot.setRadarColor("#FFFF00")   # Yellow
  bot.setBulletColor("#00FF00")  # Green
  bot.setScanColor("#00FF00")    # Green
  
  # Save # of other bots
  bot.enemies = bot.getEnemyCount()
  
  # Move to a corner
  bot.goCorner()
  
  # Initialize gun turn speed to 3
  var gunIncrement = 3
  
  # Spin gun back and forth
  while bot.isRunning():
    for i in 0..<30:
      bot.turnGunLeft(gunIncrement.float)
    gunIncrement *= -1

proc newCorners*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
                 serverSecret: string = "", debugMode: bool = true): Corners =
  ## Create a new Corners instance
  result = cast[Corners](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))
  result.corner = randomCorner()  # Start with random corner
  result.stopWhenSeeEnemy = false
  result.enemies = 0

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - Corners Example ==="
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "Corners",
    version = "1.0.0",
    authors = @["Mathew Nelson", "Nim Community"],
    description = "Moves to corners and rotates gun back and forth scanning for enemies",
    homepage = "https://github.com/robocode-dev/tank-royale",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newCorners(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting Corners bot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
