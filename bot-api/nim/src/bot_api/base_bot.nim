## Base implementation of the Tank Royale Bot API
## This provides the core functionality for bot control

import ./i_base_bot
import ./bot_info
import ./bot_state
import ./bullet_state
import ./constants

type
  BaseBot* = ref object of IBaseBot
    ## Base implementation of the bot interface
    botInfo: BotInfo
    botState: BotState
    bulletStates: seq[BulletState]
    running: bool
    turnNumber: int
    
    # Pending commands for next turn
    pendingTargetSpeed: float
    pendingTurnRate: float
    pendingGunTurnRate: float
    pendingRadarTurnRate: float
    pendingFirepower: float
    
    # Command flags
    hasSpeedCommand: bool
    hasTurnCommand: bool
    hasGunTurnCommand: bool
    hasRadarTurnCommand: bool
    hasFireCommand: bool

proc newBaseBot*(botInfo: BotInfo): BaseBot =
  ## Create a new BaseBot with given bot information
  result = BaseBot()
  result.botInfo = botInfo
  result.botState = initBotState()
  result.bulletStates = @[]
  result.running = false
  result.turnNumber = 0
  
  # Initialize pending commands
  result.pendingTargetSpeed = 0.0
  result.pendingTurnRate = 0.0
  result.pendingGunTurnRate = 0.0
  result.pendingRadarTurnRate = 0.0
  result.pendingFirepower = 0.0
  
  # Initialize command flags
  result.hasSpeedCommand = false
  result.hasTurnCommand = false
  result.hasGunTurnCommand = false
  result.hasRadarTurnCommand = false
  result.hasFireCommand = false

# Implement IBaseBot methods
method getBotId*(bot: BaseBot): int =
  ## Returns the unique bot ID (placeholder)
  return 1

method getBotInfo*(bot: BaseBot): BotInfo =
  ## Returns bot information
  return bot.botInfo

method getBotState*(bot: BaseBot): BotState =
  ## Returns current bot state
  return bot.botState

method getBulletStates*(bot: BaseBot): seq[BulletState] =
  ## Returns states of all bullets currently in the game
  return bot.bulletStates

method isRunning*(bot: BaseBot): bool =
  ## Returns true if the bot is currently running
  return bot.running

method start*(bot: BaseBot) =
  ## Starts the bot
  bot.running = true

method stop*(bot: BaseBot) =
  ## Stops the bot
  bot.running = false

method go*(bot: BaseBot) =
  ## Executes all pending commands and waits for next turn
  # This is where we would send commands to the game server
  # For now, just increment turn number and clear commands
  bot.turnNumber += 1
  
  # Clear all pending commands
  bot.hasSpeedCommand = false
  bot.hasTurnCommand = false
  bot.hasGunTurnCommand = false
  bot.hasRadarTurnCommand = false
  bot.hasFireCommand = false

method setTargetSpeed*(bot: BaseBot, speed: float) =
  ## Sets the target speed for the next turn
  bot.pendingTargetSpeed = speed
  bot.hasSpeedCommand = true

method setTurnRate*(bot: BaseBot, turnRate: float) =
  ## Sets the turn rate for the next turn
  bot.pendingTurnRate = turnRate
  bot.hasTurnCommand = true

method setGunTurnRate*(bot: BaseBot, gunTurnRate: float) =
  ## Sets the gun turn rate for the next turn
  bot.pendingGunTurnRate = gunTurnRate
  bot.hasGunTurnCommand = true

method setRadarTurnRate*(bot: BaseBot, radarTurnRate: float) =
  ## Sets the radar turn rate for the next turn
  bot.pendingRadarTurnRate = radarTurnRate
  bot.hasRadarTurnCommand = true

method setFire*(bot: BaseBot, firepower: float) =
  ## Sets the firepower for the next turn
  bot.pendingFirepower = firepower
  bot.hasFireCommand = true

# Getter methods for pending commands
method getTargetSpeed*(bot: BaseBot): float =
  ## Gets the current target speed
  return bot.pendingTargetSpeed