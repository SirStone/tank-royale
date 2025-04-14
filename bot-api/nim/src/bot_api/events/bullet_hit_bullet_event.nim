nim
import ./bot_event
import ../bullet_state

type
  BulletHitBulletEvent* = ref object of BotEvent
    bullet*: BulletState
    hitBullet*: BulletState

proc `bullet`*(this: BulletHitBulletEvent): BulletState =
  this.bullet

proc `hitBullet`*(this: BulletHitBulletEvent): BulletState =
  this.hitBullet
proc newBulletHitBulletEvent*(turnNumber: int, bullet: BulletState, hitBullet: BulletState): BulletHitBulletEvent {.inline.} =
  result = BulletHitBulletEvent(BotEvent: newBotEvent(turnNumber: turnNumber), bullet: bullet, hitBullet: hitBullet)