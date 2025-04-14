nim
import bot_api/bullet_state
import bot_api/events/bot_event
import bot_api/droid

type
  BulletFiredEvent* = ref object of BotEvent
    bullet*: BulletState
    owner*: Droid

  proc getOwner*(this: BulletFiredEvent): Droid =
    return this.owner

proc newBulletFiredEvent*(bullet: BulletState, owner: Droid): BulletFiredEvent =
  result = BulletFiredEvent()
  result.bullet = bullet
  result.owner = owner