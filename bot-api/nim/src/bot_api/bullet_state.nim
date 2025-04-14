nim[
import math

type
  BulletState* = ref object of RootObj
    bulletId*: int
    ownerId*: int
    x*: float
    y*: float
    direction*: float
    power*: float
    speed*: float

proc newBulletState*(bulletId: int, ownerId: int, x: float, y: float, direction: float, power: float, speed: float): BulletState =
  result = BulletState()
  result.bulletId = bulletId
  result.ownerId = ownerId
  result.x = x
  result.y = y
  result.direction = direction
  result.power = power
  result.speed = speed

proc getBulletId*(bulletState: BulletState): int =
  bulletState.bulletId

proc getOwnerId*(bulletState: BulletState): int =
  bulletState.ownerId

proc getX*(bulletState: BulletState): float =
  bulletState.x

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