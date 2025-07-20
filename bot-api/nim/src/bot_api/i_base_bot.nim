## Base Bot Interface for Tank Royale Bot API
## This interface defines the low-level methods for bot control

import ./bot_info
import ./bot_state
import ./bullet_state

# Forward declaration
type
  IBaseBot* = ref object of RootObj
    ## Base interface for all Tank Royale bots
    
# Core bot information methods
method getBotId*(bot: IBaseBot): int {.base.} =
  ## Returns the unique bot ID
  raise newException(CatchableError, "Method not implemented")

method getBotInfo*(bot: IBaseBot): BotInfo {.base.} =
  ## Returns bot information like name, version, etc.
  raise newException(CatchableError, "Method not implemented")

method getBotState*(bot: IBaseBot): BotState {.base.} =
  ## Returns current bot state (position, energy, etc.)
  raise newException(CatchableError, "Method not implemented")

method getBulletStates*(bot: IBaseBot): seq[BulletState] {.base.} =
  ## Returns states of all bullets currently in the game
  raise newException(CatchableError, "Method not implemented")

# Bot control methods
method isRunning*(bot: IBaseBot): bool {.base.} =
  ## Returns true if the bot is currently running
  raise newException(CatchableError, "Method not implemented")

method start*(bot: IBaseBot) {.base.} =
  ## Starts the bot
  raise newException(CatchableError, "Method not implemented")

method stop*(bot: IBaseBot) {.base.} =
  ## Stops the bot
  raise newException(CatchableError, "Method not implemented")

method go*(bot: IBaseBot) {.base.} =
  ## Executes all pending commands and waits for next turn
  raise newException(CatchableError, "Method not implemented")

# Movement and action commands
method setTargetSpeed*(bot: IBaseBot, speed: float) {.base.} =
  ## Sets the target speed for the next turn
  raise newException(CatchableError, "Method not implemented")

method setTurnRate*(bot: IBaseBot, turnRate: float) {.base.} =
  ## Sets the turn rate for the next turn
  raise newException(CatchableError, "Method not implemented")

method setGunTurnRate*(bot: IBaseBot, gunTurnRate: float) {.base.} =
  ## Sets the gun turn rate for the next turn
  raise newException(CatchableError, "Method not implemented")

method setRadarTurnRate*(bot: IBaseBot, radarTurnRate: float) {.base.} =
  ## Sets the radar turn rate for the next turn
  raise newException(CatchableError, "Method not implemented")

method setFire*(bot: IBaseBot, firepower: float) {.base.} =
  ## Sets the firepower for the next turn
  raise newException(CatchableError, "Method not implemented")