## Represents the state of a bullet in the game

import math

type
  BulletState* = object
    ## Current bullet state
    bulletId*: int      ## Unique bullet ID
    ownerId*: int       ## ID of the bot that fired this bullet
    x*: float          ## X coordinate
    y*: float          ## Y coordinate
    direction*: float  ## Direction the bullet is moving (in degrees)
    power*: float      ## Firepower of the bullet
    speed*: float      ## Speed of the bullet

proc initBulletState*(bulletId: int, ownerId: int, x: float, y: float, 
                     direction: float, power: float, speed: float): BulletState =
  ## Create a new BulletState with specified values
  result = BulletState(
    bulletId: bulletId,
    ownerId: ownerId,
    x: x,
    y: y,
    direction: direction,
    power: power,
    speed: speed
  )

proc getY*(bulletState: BulletState): float =
  bulletState.y

proc getDirection*(bulletState: BulletState): float =
  bulletState.direction

proc getPower*(bulletState: BulletState): float =
  bulletState.power

proc getSpeed*(bulletState: BulletState): float =
  bulletState.speed

proc getDx*(bulletState: BulletState): float =
  bulletState.speed * cos(bulletState.direction)

proc getDy*(bulletState: BulletState): float =
  bulletState.speed * sin(bulletState.direction)

proc toString*(bulletState: BulletState): string =
  "BulletState(bulletId=" & $bulletState.bulletId & ", ownerId=" & $bulletState.ownerId & ", x=" & $bulletState.x & ", y=" & $bulletState.y & ", direction=" & $bulletState.direction & ", power=" & $bulletState.power & ", speed=" & $bulletState.speed & ")"