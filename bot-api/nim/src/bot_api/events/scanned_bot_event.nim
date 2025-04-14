import bot_state
import i_event

type 
  ScannedBotEvent* = ref object of RootObj
    scannedBotId*: int
    energy*: float
    x*: float
    y*: float
    direction*: float
    speed*: float
    time*: int

  ScannedBotEventObj* = object of ScannedBotEvent
    eventType*: string
    scannedBotId*: int
    energy*: float
    x*: float
    y*: float
    direction*: float
    speed*: float
    time*: int  

proc initScannedBotEvent*(scannedBotId: int, energy: float, x: float, y: float, direction: float, speed: float, time: int): ScannedBotEvent =
  var scannedBotEvent = ScannedBotEventObj(eventType: "ScannedBotEvent", scannedBotId: scannedBotId, energy: energy, x: x, y: y, direction: direction, speed: speed, time: time)
  return cast[ScannedBotEvent](addr scannedBotEvent)

proc getScannedBotId*(event: ScannedBotEvent): int {.inline.} =
  return event.scannedBotId

proc getEventType*(event: ScannedBotEvent): string {.inline.} =
  return event.eventType

proc isCritical*(event: ScannedBotEvent): bool {.inline.} =
  return false

proc getEnergy*(event: ScannedBotEvent): float =
  return event.energy

proc getX*(event: ScannedBotEvent): float =
  return event.x

proc getY*(event: ScannedBotEvent): float =
  return event.y

proc getDirection*(event: ScannedBotEvent): float =
  return event.direction

proc getSpeed*(event: ScannedBotEvent): float =
  return event.speed

proc getTime*(event: ScannedBotEvent): int =
  return event.time