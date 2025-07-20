## ------------------------------------------------------------------
## VelocityBot
## ------------------------------------------------------------------
## A sample bot originally made for Robocode by Joshua Galecki.
## Ported to Tank Royale Nim by the community.
##
## Example bot of how to use turn rates.
## ------------------------------------------------------------------

import asyncdispatch
import bot_api/network_bot
import bot_api/bot_info
import bot_api/base_bot
import bot_api/events/scanned_bot_event
import bot_api/events/hit_by_bullet_event
import bot_api/events/hit_wall_event

type
  VelocityBot* = ref object of NetworkBot
    ## Bot that demonstrates using turn rates and target speeds
    turnCounter: int

# Override event handlers
method onScannedBot*(bot: VelocityBot, event: ScannedBotEvent) =
  ## We scanned another bot -> fire!
  bot.fire(1.0)

method onHitByBullet*(bot: VelocityBot, event: HitByBulletEvent) =
  ## We were hit by a bullet -> set turn rate
  # Turn to confuse the other bots
  bot.setTurnRate(5.0)

method onHitWall*(bot: VelocityBot, event: HitWallEvent) =
  ## We hit a wall -> move in the opposite direction
  # Move away from the wall by reversing the target speed.
  # Note that current speed is 0 as the bot just hit the wall.
  bot.setTargetSpeed(-1.0 * bot.getTargetSpeed())

# Override the run method to implement bot behavior
method run*(bot: VelocityBot) =
  ## Main bot logic - demonstrates turn rates and target speeds
  
  bot.turnCounter = 0
  
  bot.setGunTurnRate(15.0)
  
  while bot.isRunning():
    if bot.turnCounter mod 64 == 0:
      # Straighten out, if we were hit by a bullet (ends turning)
      bot.setTurnRate(0.0)
      
      # Go forward with a target speed of 4
      bot.setTargetSpeed(4.0)
    
    if bot.turnCounter mod 64 == 32:
      # Go backwards, faster
      bot.setTargetSpeed(-6.0)
    
    bot.turnCounter += 1
    bot.go()  # execute turn

proc newVelocityBot*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
                     serverSecret: string = "", debugMode: bool = true): VelocityBot =
  ## Create a new VelocityBot instance
  result = cast[VelocityBot](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))
  result.turnCounter = 0

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - VelocityBot Example ==="
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "VelocityBot",
    version = "1.0.0",
    authors = @["Joshua Galecki", "Nim Community"],
    description = "Example bot demonstrating how to use turn rates and target speeds",
    homepage = "https://github.com/robocode-dev/tank-royale",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newVelocityBot(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting VelocityBot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
