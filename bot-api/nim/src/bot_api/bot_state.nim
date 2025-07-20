## Represents the current bot state.

type
  BotState* = object
    ## Current bot state
    isDroid*: bool           ## Flag specifying if the bot is a droid
    energy*: float           ## Energy level
    x*: float               ## X coordinate
    y*: float               ## Y coordinate  
    direction*: float       ## Driving direction in degrees
    gunDirection*: float    ## Gun direction in degrees
    radarDirection*: float  ## Radar direction in degrees
    radarSweep*: float      ## Radar sweep angle in degrees
    speed*: float           ## Speed measured in units per turn
    turnRate*: float        ## Turn rate of the body in degrees per turn
    gunTurnRate*: float     ## Turn rate of the gun in degrees per turn
    radarTurnRate*: float   ## Turn rate of the radar in degrees per turn
    gunHeat*: float         ## Gun heat
    enemyCount*: int        ## Number of enemies

proc initBotState*(): BotState =
  ## Create a new BotState with default values
  result = BotState(
    isDroid: false,
    energy: 100.0,
    x: 250.0,
    y: 250.0,
    direction: 0.0,
    gunDirection: 0.0,
    radarDirection: 0.0,
    radarSweep: 0.0,
    speed: 0.0,
    turnRate: 0.0,
    gunTurnRate: 0.0,
    radarTurnRate: 0.0,
    gunHeat: 0.0,
    enemyCount: 0
  )