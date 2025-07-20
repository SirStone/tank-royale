## Example Bot: Simple Spinner
## This bot demonstrates basic Tank Royale bot programming using the Nim API

import ../src/bot_api/bot
import ../src/bot_api/bot_info

type
  SpinnerBot* = ref object of Bot
    ## A simple bot that spins and fires

# Override the run method to implement bot behavior
method run*(bot: SpinnerBot) =
  ## Main bot loop - this is where the bot's AI logic goes
  
  # Move forward a bit
  bot.forward(100.0)
  
  # Turn the body, gun and radar in different directions
  bot.turnRight(30.0)
  bot.turnGunLeft(45.0) 
  bot.turnRadarRight(60.0)
  
  # Fire with medium power
  bot.fire(2.0)
  
  # Execute all commands and wait for next turn
  # Note: In current implementation, go() would be handled by the game loop

proc newSpinnerBot*(): SpinnerBot =
  ## Create a new SpinnerBot
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
  
  result = cast[SpinnerBot](newBot(botInfo))

# Example usage
when isMainModule:
  echo "Creating SpinnerBot..."
  let spinnerBot = newSpinnerBot()
  echo "Bot created: ", spinnerBot.getBotInfo().name
  
  # Start the bot (in a real game this would connect to server)
  spinnerBot.start()
  echo "Bot started, running: ", spinnerBot.isRunning()
  
  # Simulate one turn of the bot's behavior
  echo "Running bot logic..."
  spinnerBot.run()
  
  echo "SpinnerBot example completed!"
