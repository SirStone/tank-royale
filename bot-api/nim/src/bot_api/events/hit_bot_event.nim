import ./bot_event

type
  HitBotEvent* = ref object of BotEvent # A bot hit another bot.
    victimId*: int # The victim id of the bot that was hit.
    energy*: float # The energy on the bot that was hit.

proc newHitBotEvent*(turnNumber*: int, timestamp*: int, victimId*: int, energy*: float): HitBotEvent =
  ## Creates a new instance of a HitBotEvent.

  ## Args:
  ##   turnNumber: The current turn number.
  ##   timestamp: The current time stamp.
  ##   victimId: The victim id of the bot that was hit.
  ##   energy: The energy on the bot that was hit.
  HitBotEvent(BotEvent(turnNumber: turnNumber, timestamp: timestamp), victimId: victimId, energy: energy)