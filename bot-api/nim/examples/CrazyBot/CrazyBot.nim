## ------------------------------------------------------------------
## Crazy
## ------------------------------------------------------------------
## A sample bot originally made for Robocode by Mathew Nelson.
## Ported to Tank Royale Nim by the community.
##
## This robot moves in a zigzag pattern while firing at enemies.
## ------------------------------------------------------------------

import asyncdispatch, math
import bot_api/network_bot
import bot_api/bot_info
import bot_api/base_bot
import bot_api/events/scanned_bot_event
import bot_api/events/hit_bot_event
import bot_api/events/hit_wall_event

type
  Crazy* = ref object of NetworkBot
    ## Bot that moves in a zigzag pattern
    movingForward: bool

  TurnCompleteCondition* = ref object
    ## Condition that is triggered when the turning is complete
    bot: Crazy

# Helper methods
proc reverseDirection(bot: Crazy) =
  ## ReverseDirection: Switch from ahead to back & vice versa
  if bot.movingForward:
    bot.setBack(40000.0)
    bot.movingForward = false
  else:
    bot.setForward(40000.0)
    bot.movingForward = true

proc test(condition: TurnCompleteCondition): bool =
  ## Turn is complete when the remainder of the turn is zero
  return condition.bot.getTurnRemaining() == 0.0

# Override event handlers
method onScannedBot*(bot: Crazy, event: ScannedBotEvent) =
  ## We scanned another bot -> fire!
  bot.fire(1.0)

method onHitBot*(bot: Crazy, event: HitBotEvent) =
  ## We hit another bot -> back up!
  # If we're moving into the other bot, reverse!
  if event.rammed:
    bot.reverseDirection()

method onHitWall*(bot: Crazy, event: HitWallEvent) =
  ## We collided with a wall -> reverse the direction
  # Bounce off!
  bot.reverseDirection()

# Override the run method to implement bot behavior
method run*(bot: Crazy) =
  ## Main bot logic - zigzag movement pattern
  
  # Set colors (lime green theme)
  bot.setBodyColor("#00C800")    # Lime
  bot.setTurretColor("#009632")  # Green
  bot.setRadarColor("#006464")   # Dark cyan
  bot.setBulletColor("#FFFF64")  # Yellow
  bot.setScanColor("#FFC8C8")    # Light red
  
  # Loop while as long as the bot is running
  while bot.isRunning():
    # Tell the game we will want to move ahead 40000 -- some large number
    bot.setForward(40000.0)
    bot.movingForward = true
    # Tell the game we will want to turn left 90
    bot.setTurnLeft(90.0)
    # At this point, we have indicated to the game that *when we do something*,
    # we will want to move ahead and turn left. That's what "set" means.
    # It is important to realize we have not done anything yet!
    # In order to actually move, we'll want to call a method that takes real time, such as
    # waitFor.
    
    # Create condition for turn complete
    let turnCondition = TurnCompleteCondition(bot: bot)
    
    # waitFor actually starts the action -- we start moving and turning.
    # It will not return until we have finished turning.
    bot.waitFor(proc(): bool = turnCondition.test())
    
    # Note: We are still moving ahead now, but the turn is complete.
    # Now we'll turn the other way...
    bot.setTurnRight(180.0)
    # ... and wait for the turn to finish ...
    bot.waitFor(proc(): bool = turnCondition.test())
    # ... then the other way ...
    bot.setTurnLeft(180.0)
    # ... and wait for that turn to finish.
    bot.waitFor(proc(): bool = turnCondition.test())
    # then back to the top to do it all again.

proc newCrazy*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
               serverSecret: string = "", debugMode: bool = true): Crazy =
  ## Create a new Crazy instance
  result = cast[Crazy](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))
  result.movingForward = true

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - Crazy Example ==="
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "Crazy",
    version = "1.0.0",
    authors = @["Mathew Nelson", "Nim Community"],
    description = "Moves in a zigzag pattern while firing at enemies",
    homepage = "https://github.com/robocode-dev/tank-royale",
    countryCodes = @["US"],
    gameTypes = @["classic", "melee", "1v1"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newCrazy(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting Crazy bot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
