## ------------------------------------------------------------------
## SpinBot
## ------------------------------------------------------------------
## A sample bot originally made for Robocode by Mathew Nelson.
## Ported to Tank Royale Nim by the community.
##
## Continuously moves in a circle while firing at maximum power when
## detecting enemies.
## ------------------------------------------------------------------

import asyncdispatch, math
import ../src/bot_api/network_bot
import ../src/bot_api/bot_info
import ../src/bot_api/base_bot
import ../src/bot_api/events/scanned_bot_event
import ../src/bot_api/events/hit_bot_event

type
  SpinBot* = ref object of NetworkBot
    ## Bot that continuously spins while moving in a circle

# Override event handlers
method onScannedBot*(bot: SpinBot, event: ScannedBotEvent) =
  ## We scanned another bot -> fire hard!
  bot.fire(3.0)

method onHitBot*(bot: SpinBot, event: HitBotEvent) =
  ## We hit another bot -> if it's our fault, we'll stop turning and moving,
  ## so we need to turn again to keep spinning.
  # Fire at the bot we hit
  bot.fire(3.0)
  
  # Turn to keep spinning
  bot.turnRight(10.0)

# Override the run method to implement bot behavior
method run*(bot: SpinBot) =
  ## Main bot logic - continuous spinning movement
  
  # Set colors (blue theme) - TODO: Implement color setting methods
  # bot.setBodyColor("#0000FF")    # Blue
  # bot.setTurretColor("#0000FF")  # Blue
  # bot.setRadarColor("#000000")   # Black
  # bot.setScanColor("#FFFF00")    # Yellow
  
  # Repeat while the bot is running
  while bot.isRunning():
    # Tell the game that when we move, we'll also want to turn right... a lot
    bot.turnRight(10_000.0)
    # Limit our speed to 5
    bot.setTargetSpeed(5.0)
    # Start moving (and turning)
    bot.forward(10_000.0)

proc newSpinBot*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
                 serverSecret: string = "", debugMode: bool = true): SpinBot =
  ## Create a new SpinBot instance
  result = cast[SpinBot](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - SpinBot Example ==="
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "SpinBot",
    version = "1.0.0",
    authors = @["Mathew Nelson", "Nim Community"],
    description = "Continuously moves in a circle while firing at maximum power",
    homepage = "https://github.com/robocode-dev/tank-royale",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newSpinBot(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting SpinBot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
