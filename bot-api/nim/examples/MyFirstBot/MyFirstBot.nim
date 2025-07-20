## ------------------------------------------------------------------
## MyFirstBot
## ------------------------------------------------------------------
## A sample bot originally made for Robocode by Mathew Nelson.
## Ported to Tank Royale Nim by the community.
##
## Probably the first bot you will learn about.
## Moves in a seesaw motion and spins the gun around at each end.
## ------------------------------------------------------------------

import asyncdispatch
import bot_api/network_bot
import bot_api/bot_info
import bot_api/base_bot
import bot_api/events/scanned_bot_event
import bot_api/events/hit_by_bullet_event

type
  MyFirstBot* = ref object of NetworkBot
    ## Simple example bot that demonstrates basic Tank Royale concepts

# Override event handlers
method onScannedBot*(bot: MyFirstBot, event: ScannedBotEvent) =
  ## We saw another bot -> fire!
  bot.fire(1.0)

method onHitByBullet*(bot: MyFirstBot, event: HitByBulletEvent) =
  ## We were hit by a bullet -> turn perpendicular to the bullet
  # Calculate the bearing to the direction of the bullet
  let bearing = bot.calcBearing(event.bullet.direction)
  
  # Turn 90 degrees to the bullet direction based on the bearing
  bot.turnRight(90.0 - bearing)

# Override the run method to implement bot behavior
method run*(bot: MyFirstBot) =
  ## Main bot logic - simple seesaw movement pattern
  
  # Repeat while the bot is running
  while bot.isRunning():
    bot.forward(100.0)
    bot.turnGunLeft(360.0)
    bot.back(100.0)
    bot.turnGunLeft(360.0)

proc newMyFirstBot*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
                    serverSecret: string = "", debugMode: bool = true): MyFirstBot =
  ## Create a new MyFirstBot instance
  result = cast[MyFirstBot](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - MyFirstBot Example ==="
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "MyFirstBot",
    version = "1.0.0",
    authors = @["Mathew Nelson", "Nim Community"],
    description = "A simple bot that moves in a seesaw motion and spins the gun",
    homepage = "https://github.com/robocode-dev/tank-royale",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newMyFirstBot(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting MyFirstBot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
