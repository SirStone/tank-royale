import ./bot_event

type
  HitBotEvent* = ref object of BotEvent # A bot hit another bot.
    victimId*: int # The victim id of the bot that was hit.
    energy*: float # The energy on the bot that was hit.
    bearing*: float # The bearing to the bot that was hit
    isRamed*: bool # True if the collision was a ramming
    rammed*: bool # Alias for isRamed (for compatibility)

proc newHitBotEvent*(turnNumber: int, timestamp: int, victimId: int, energy: float, 
                    bearing: float = 0.0, isRamed: bool = false): HitBotEvent =
  ## Creates a new instance of a HitBotEvent.
  ##
  ## Args:
  ##   turnNumber: The current turn number.
  ##   timestamp: The current time stamp.
  ##   victimId: The victim id of the bot that was hit.
  ##   energy: The energy on the bot that was hit.
  ##   bearing: The bearing to the bot that was hit.
  ##   isRamed: True if the collision was a ramming.
  result = HitBotEvent(
    turnNumber: turnNumber, 
    victimId: victimId, 
    energy: energy,
    bearing: bearing,
    isRamed: isRamed,
    rammed: isRamed  # Set alias
  )