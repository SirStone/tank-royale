## ------------------------------------------------------------------
## Walls
## ------------------------------------------------------------------
## A sample bot originally made for Robocode by Mathew Nelson.
## Ported to Tank Royale Nim by the community.
##
## This robot navigates around the perimeter of the battlefield with
## the gun pointed inward.
## ------------------------------------------------------------------

import asyncdispatch, math
import ../src/bot_api/network_bot
import ../src/bot_api/bot_info
import ../src/bot_api/base_bot
import ../src/bot_api/events/scanned_bot_event
import ../src/bot_api/events/hit_bot_event

type
  Walls* = ref object of NetworkBot
    ## Bot that moves around the perimeter of the battlefield
    peek: bool         # Don't turn if there's a bot there
    moveAmount: float  # How much to move

# Override event handlers
method onScannedBot*(bot: Walls, event: ScannedBotEvent) =
  ## We scanned another bot -> fire!
  bot.fire(2.0)
  
  # Note that scan is called automatically when the bot is turning.
  # By calling it manually here, we make sure we generate another scan event if there's a bot
  # on the next wall, so that we do not start moving up it until it's gone.
  if bot.peek:
    # bot.rescan()  # TODO: Implement rescan method
    discard

method onHitBot*(bot: Walls, event: HitBotEvent) =
  ## We hit another bot -> move away a bit
  # If we hit another bot, move back to avoid getting stuck
  bot.back(100.0)
  # else he's in back of us, so set ahead a bit.
  bot.forward(100.0)

# Override the run method to implement bot behavior
method run*(bot: Walls) =
  ## Main bot logic - navigate around the battlefield perimeter
  
  # Set colors (black theme with orange radar)
  bot.setBodyColor("#000000")    # Black
  bot.setTurretColor("#000000")  # Black
  bot.setRadarColor("#FFA500")   # Orange
  bot.setBulletColor("#00FFFF")  # Cyan
  bot.setScanColor("#00FFFF")    # Cyan
  
  # Initialize moveAmount to the maximum possible for the arena
  bot.moveAmount = max(bot.getArenaWidth().float, bot.getArenaHeight().float)
  # Initialize peek to false
  bot.peek = false
  
  # Turn to face a wall.
  # `getDirection() % 90` means the remainder of getDirection() divided by 90.
  bot.turnRight(bot.getDirection() mod 90.0)
  bot.forward(bot.moveAmount)
  
  # Turn the gun to turn left 90 degrees.
  bot.peek = true
  bot.turnGunLeft(90.0)
  bot.turnLeft(90.0)
  
  # Main loop
  while bot.isRunning():
    # Peek before we turn when forward() completes.
    bot.peek = true
    # Move up the wall
    bot.forward(bot.moveAmount)
    # Don't peek now
    bot.peek = false
    # Turn to the next wall
    bot.turnLeft(90.0)

proc newWalls*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
               serverSecret: string = "", debugMode: bool = true): Walls =
  ## Create a new Walls instance
  result = cast[Walls](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))
  result.peek = false
  result.moveAmount = 1000.0  # Default value

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - Walls Example ==="
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "Walls",
    version = "1.0.0",
    authors = @["Mathew Nelson", "Nim Community"],
    description = "Navigates around the perimeter of the battlefield with gun pointed inward",
    homepage = "https://github.com/robocode-dev/tank-royale",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newWalls(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting Walls bot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
