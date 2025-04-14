import bot_api/events/i_event
import bot_api/events/bot_event 
import bot_api/bullet_state

type
  BulletHitBotEvent* = ref object of BotEvent, IEvent
    bullet*: BulletState
    victimId*: int
    damage*: float
    energy*: float

  
proc getBullet*(event*: BulletHitBotEvent): BulletState =
  event.bullet

proc getVictimId*(event*: BulletHitBotEvent): int =
  event.victimId

proc getDamage*(event*: BulletHitBotEvent): float =
  event.damage

proc getEnergy*(event*: BulletHitBotEvent): float =
  event.energy

proc newBulletHitBotEvent*(turnNumber*: int, bullet*: BulletState, victimId*: int, damage*: float, energy*: float): BulletHitBotEvent =
  BulletHitBotEvent(BotEvent: BotEvent(turnNumber: turnNumber), bullet: bullet, victimId: victimId, damage: damage, energy: energy)