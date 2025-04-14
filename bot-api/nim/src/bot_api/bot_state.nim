nim
import math

type
  BotState* = ref object of RootObj
    energy*: float
    x*: float
    y*: float
    direction*: float
    gunDirection*: float
    radarDirection*: float
    speed*: float
    turnRate*: float
    gunTurnRate*: float
    radarTurnRate*: float
    width*: float
    height*: float
    groundSpeed*: float
    maxTurnRate*: float
    maxGunTurnRate*: float
    maxRadarTurnRate*: float    
    acceleration*: float
    deceleration*: float
    maxSpeed*: float
    backwardsSpeed*: float
    maxEnergy*: float
    maxBulletEnergy*: float
    minBulletEnergy*: float

proc initBotState*(): BotState =
  new(result)
  result.energy = 100.0
  result.x = 250.0
  result.y = 250.0
  result.direction = 0.0
  result.gunDirection = 0.0
  result.radarDirection = 0.0
  result.speed = 0.0
  result.turnRate = 0.0
  result.gunTurnRate = 0.0
  result.radarTurnRate = 0.0
  result.width = 36.0
  result.height = 36.0
  result.groundSpeed = 0.0
  result.maxTurnRate = 10.0
  result.maxGunTurnRate = 20.0
  result.maxRadarTurnRate = 45.0
  result.acceleration = 1.0
  result.deceleration = 2.0
  result.maxSpeed = 8.0
  result.backwardsSpeed = 4.0
  result.maxEnergy = 100.0
  result.maxBulletEnergy = 3.0
  result.minBulletEnergy = 0.1


proc getEnergy*(botState: BotState): float =
    botState.energy

proc getX*(botState: BotState): float =
    botState.x

proc getY*(botState: BotState): float =
    botState.y

proc getDirection*(botState: BotState): float =
    botState.direction

proc getGunDirection*(botState: BotState): float =
    botState.gunDirection

proc getRadarDirection*(botState: BotState): float =
    botState.radarDirection

proc getSpeed*(botState: BotState): float =
    botState.speed

proc getTurnRate*(botState: BotState): float =
    botState.turnRate

proc getGunTurnRate*(botState: BotState): float =
    botState.gunTurnRate

proc getRadarTurnRate*(botState: BotState): float =
    botState.radarTurnRate

proc getWidth*(botState: BotState): float =
    botState.width

proc getHeight*(botState: BotState): float =
    botState.height

proc getGroundSpeed*(botState: BotState): float =
    botState.groundSpeed

proc getMaxTurnRate*(botState: BotState): float =
    botState.maxTurnRate

proc getMaxGunTurnRate*(botState: BotState): float =
    botState.maxGunTurnRate

proc getMaxRadarTurnRate*(botState: BotState): float =
    botState.maxRadarTurnRate
    
proc getAcceleration*(botState: BotState): float =
  botState.acceleration

proc getDeceleration*(botState: BotState): float =
  botState.deceleration

proc getMaxSpeed*(botState: BotState): float =
  botState.maxSpeed

proc getBackwardsSpeed*(botState: BotState): float =
  botState.backwardsSpeed

proc getMaxEnergy*(botState: BotState): float =
  botState.maxEnergy

proc getMaxBulletEnergy*(botState: BotState): float =
  botState.maxBulletEnergy

proc getMinBulletEnergy*(botState: BotState): float =
  botState.minBulletEnergy

proc calcX*(botState: BotState, speed: float, direction: float): float =
    botState.x + speed * cos(direction.degToRad())

proc calcY*(botState: BotState, speed: float, direction: float): float =
    botState.y + speed * sin(direction.degToRad())

proc setEnergy*(botState: BotState, energy: float) =
  botState.energy = energy

proc setX*(botState: BotState, x: float) =
  botState.x = x

proc setY*(botState: BotState, y: float) =
  botState.y = y

proc setDirection*(botState: BotState, direction: float) =
  botState.direction = direction

proc setGunDirection*(botState: BotState, gunDirection: float) =
  botState.gunDirection = gunDirection

proc setRadarDirection*(botState: BotState, radarDirection: float) =
  botState.radarDirection = radarDirection

proc setSpeed*(botState: BotState, speed: float) =
  botState.speed = speed

proc setTurnRate*(botState: BotState, turnRate: float) =
  botState.turnRate = turnRate

proc setGunTurnRate*(botState: BotState, gunTurnRate: float) =
  botState.gunTurnRate = gunTurnRate

proc setRadarTurnRate*(botState: BotState, radarTurnRate: float) =
  botState.radarTurnRate = radarTurnRate