## High-level Bot Interface for Tank Royale Bot API
## This interface extends IBaseBot with convenience methods

import ./i_base_bot
import ./constants

type
  IBot* = ref object of IBaseBot
    ## High-level interface that extends IBaseBot with convenience methods

# High-level movement methods
method forward*(bot: IBot, distance: float) {.base.} =
  ## Move forward a specific distance
  raise newException(CatchableError, "Method not implemented")

method back*(bot: IBot, distance: float) {.base.} =
  ## Move backward a specific distance  
  raise newException(CatchableError, "Method not implemented")

method turnLeft*(bot: IBot, degrees: float) {.base.} =
  ## Turn left by specified degrees
  raise newException(CatchableError, "Method not implemented")

method turnRight*(bot: IBot, degrees: float) {.base.} =
  ## Turn right by specified degrees
  raise newException(CatchableError, "Method not implemented")

method turnGunLeft*(bot: IBot, degrees: float) {.base.} =
  ## Turn gun left by specified degrees
  raise newException(CatchableError, "Method not implemented")

method turnGunRight*(bot: IBot, degrees: float) {.base.} =
  ## Turn gun right by specified degrees
  raise newException(CatchableError, "Method not implemented")

method turnRadarLeft*(bot: IBot, degrees: float) {.base.} =
  ## Turn radar left by specified degrees
  raise newException(CatchableError, "Method not implemented")

method turnRadarRight*(bot: IBot, degrees: float) {.base.} =
  ## Turn radar right by specified degrees
  raise newException(CatchableError, "Method not implemented")

# Firing methods
method fire*(bot: IBot) {.base.} =
  ## Fire with default firepower
  raise newException(CatchableError, "Method not implemented")

method fire*(bot: IBot, firepower: float) {.base.} =
  ## Fire with specified firepower
  raise newException(CatchableError, "Method not implemented")

# State query convenience methods
method getX*(bot: IBot): float {.base.} =
  ## Get current X coordinate
  return bot.getBotState().x

method getY*(bot: IBot): float {.base.} =
  ## Get current Y coordinate
  return bot.getBotState().y

method getDirection*(bot: IBot): float {.base.} =
  ## Get current body direction
  return bot.getBotState().direction

method getGunDirection*(bot: IBot): float {.base.} =
  ## Get current gun direction
  return bot.getBotState().gunDirection

method getRadarDirection*(bot: IBot): float {.base.} =
  ## Get current radar direction
  return bot.getBotState().radarDirection

method getSpeed*(bot: IBot): float {.base.} =
  ## Get current speed
  return bot.getBotState().speed

method getEnergy*(bot: IBot): float {.base.} =
  ## Get current energy
  return bot.getBotState().energy

# Event handling methods (to be implemented)
method run*(bot: IBot) {.base.} =
  ## Main bot logic - override this method
  raise newException(CatchableError, "Method not implemented")
    