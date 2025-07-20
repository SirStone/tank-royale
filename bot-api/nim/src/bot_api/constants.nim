## Constants used in the Tank Royale Bot API.

const 
  ## The radius of the bounding circle of the bot, which is a constant of 18 units.
  BOUNDING_CIRCLE_RADIUS* = 18

  ## The radius of the radar's scan beam, which is a constant of 1200 units.
  SCAN_RADIUS* = 1200

  ## The maximum possible driving turn rate, which is max. 10 degrees per turn.
  MAX_TURN_RATE* = 10

  ## The maximum gun turn rate, which is a constant of 20 degrees per turn.
  MAX_GUN_TURN_RATE* = 20

  ## The maximum radar turn rate, which is a constant of 45 degrees per turn.
  MAX_RADAR_TURN_RATE* = 45

  ## The maximum absolute speed, which is 8 units per turn.
  MAX_SPEED* = 8

  ## The minimum firepower, which is 0.1.
  MIN_FIREPOWER* = 0.1

  ## The maximum firepower, which is 3.
  MAX_FIREPOWER* = 3.0

  ## The minimum bullet speed is 11 units per turn.
  MIN_BULLET_SPEED* = 20.0 - 3.0 * MAX_FIREPOWER

  ## The maximum bullet speed is 19.7 units per turn.
  MAX_BULLET_SPEED* = 20.0 - 3.0 * MIN_FIREPOWER

  ## Acceleration is the increase in speed per turn.
  ACCELERATION* = 1

  ## Deceleration is the decrease in speed per turn.
  DECELERATION* = -2

  ## Default start energy
  DEFAULT_START_ENERGY* = 100.0

  ## Max energy
  MAX_ENERGY* = 100.0