import bot_api/events/bot_event

type
  HitWallEvent* = ref object of BotEvent # Implementación de la clase HitWallEvent
    victimId*: int # ID del robot que golpeó la pared
    energy*: float # Energía del robot cuando golpeó la pared

  HitWallEventObj* = object # Implementación del objeto HitWallEventObj
    victimId*: int # ID del robot que golpeó la pared
    energy*: float # Energía del robot cuando golpeó la pared

proc `init`*(HitWallEvent: typedesc[HitWallEvent], victimId: int, energy: float): HitWallEvent = # Constructor para la clase HitWallEvent
  result = HitWallEvent()
  result.victimId = victimId
  result.energy = energy

proc `init`*(HitWallEventObj: typedesc[HitWallEventObj], victimId: int, energy: float): HitWallEventObj = # Constructor para el objeto HitWallEventObj
  result = HitWallEventObj()
  result.energy = energy