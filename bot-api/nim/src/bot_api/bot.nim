## High-level Bot implementation for Tank Royale Bot API
## This provides convenient methods for bot programming

import ./base_bot
import ./i_bot
import ./bot_info
import ./constants
import math

type
  Bot* = ref object of BaseBot
    ## High-level bot implementation with convenience methods

proc newBot*(botInfo: BotInfo): Bot =
  ## Create a new Bot with given bot information
  result = cast[Bot](newBaseBot(botInfo))

# Convenience movement methods
method forward*(bot: Bot, distance: float) =
  ## Move forward a specific distance
  if distance > 0:
    bot.setTargetSpeed(min(distance, MAX_SPEED))
  else:
    bot.setTargetSpeed(0.0)

method back*(bot: Bot, distance: float) =
  ## Move backward a specific distance
  if distance > 0:
    bot.setTargetSpeed(-min(distance, MAX_SPEED))
  else:
    bot.setTargetSpeed(0.0)

method turnLeft*(bot: Bot, degrees: float) =
  ## Turn left by specified degrees
  bot.setTurnRate(-min(abs(degrees), MAX_TURN_RATE))

method turnRight*(bot: Bot, degrees: float) =
  ## Turn right by specified degrees
  bot.setTurnRate(min(abs(degrees), MAX_TURN_RATE))

method turnGunLeft*(bot: Bot, degrees: float) =
  ## Turn gun left by specified degrees
  bot.setGunTurnRate(-min(abs(degrees), MAX_GUN_TURN_RATE))

method turnGunRight*(bot: Bot, degrees: float) =
  ## Turn gun right by specified degrees
  bot.setGunTurnRate(min(abs(degrees), MAX_GUN_TURN_RATE))

method turnRadarLeft*(bot: Bot, degrees: float) =
  ## Turn radar left by specified degrees
  bot.setRadarTurnRate(-min(abs(degrees), MAX_RADAR_TURN_RATE))

method turnRadarRight*(bot: Bot, degrees: float) =
  ## Turn radar right by specified degrees
  bot.setRadarTurnRate(min(abs(degrees), MAX_RADAR_TURN_RATE))

# Firing methods
method fire*(bot: Bot) =
  ## Fire with maximum firepower
  bot.setFire(MAX_FIREPOWER)

method fire*(bot: Bot, firepower: float) =
  ## Fire with specified firepower
  let clampedPower = max(MIN_FIREPOWER, min(firepower, MAX_FIREPOWER))
  bot.setFire(clampedPower)

# Main bot logic method
method run*(bot: Bot) =
  ## Main bot logic - override this method in your bot implementation
  # Default behavior: do nothing
  discard

# Utility methods for angle calculations
proc normalizeAngle*(angle: float): float =
  ## Normalize angle to [-180, 180] range
  var normalized = angle
  while normalized > 180.0:
    normalized -= 360.0
  while normalized <= -180.0:
    normalized += 360.0
  return normalized

proc distanceTo*(x1, y1, x2, y2: float): float =
  ## Calculate distance between two points
  return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))

proc angleTo*(x1, y1, x2, y2: float): float =
  ## Calculate angle from point 1 to point 2 in degrees
  return radToDeg(arctan2(y2 - y1, x2 - x1))