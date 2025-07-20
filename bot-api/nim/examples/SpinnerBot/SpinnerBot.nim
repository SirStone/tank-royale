## Example Bot: Simple Spinner
## This bot demonstrates basic Tank Royale bot programming using the Nim API

import asyncdispatch
import bot_api/network_bot
import bot_api/bot_info

type
  SpinnerBot* = ref object of NetworkBot
    ## A simple bot that spins and fires
    turnDirection: float

# Override the run method to implement bot behavior
method run*(bot: SpinnerBot) =
  ## Main bot loop - this is where the bot's AI logic goes
  bot.log("SpinnerBot starting main loop")
  
  # Set initial turn direction
  bot.turnDirection = 10.0
  
  # Main game loop
  while bot.isRunning():
    # Move forward a bit
    bot.forward(100.0)
    
    # Turn the body, gun and radar in different directions
    bot.turnRight(bot.turnDirection)
    bot.turnGunLeft(45.0) 
    bot.turnRadarRight(60.0)
    
    # Fire with medium power
    bot.fire(2.0)
    
    # Adjust turn direction to create spinning motion
    bot.turnDirection += 5.0
    if bot.turnDirection > 45.0:
      bot.turnDirection = 10.0

proc newSpinnerBot*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", 
                    serverSecret: string = "", debugMode: bool = true): SpinnerBot =
  ## Create a new SpinnerBot
  result = cast[SpinnerBot](newNetworkBot(botInfo, serverUrl, serverSecret, debugMode))
  result.turnDirection = 10.0

proc main() {.async.} =
  echo "=== Tank Royale Nim Bot - SpinnerBot ==="
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "SpinnerBot",
    version = "1.0",
    authors = @["Nim Developer"],
    description = "A simple spinning bot",
    homepage = "https://github.com/nim-lang/tank-royale-nim",
    countryCodes = @["US"],
    gameTypes = @["classic"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  # Create the bot
  let bot = newSpinnerBot(
    botInfo = botInfo,
    serverUrl = "ws://localhost:7654",
    serverSecret = "",
    debugMode = true
  )
  
  echo "Starting SpinnerBot..."
  echo "Make sure Tank Royale server is running on localhost:7654"
  
  # Start the bot
  await bot.start()

when isMainModule:
  waitFor main()
