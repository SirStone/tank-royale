import ./i_event, ./bot_event, ../bullet_state

type
  HitByBulletEvent* = ref object of BotEvent
    bullet*: BulletState

proc newHitByBulletEvent*(bullet: BulletState, victimId: int): HitByBulletEvent = 
  ## Constructs a new HitByBulletEvent.
  ##
  ## Params:
  ##   bullet: The bullet that hit this bot.
  ##   victimId: The victimId of the bot that was hit by the bullet.
  new result
  result.bullet = bullet