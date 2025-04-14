nim
import ./i_event

type
  SkippedTurnEvent* = ref object of BotEvent
    turnNumber*: int # Current turn number

proc initSkippedTurnEvent*(turnNumber: int): SkippedTurnEvent =
  ## Initializes a new instance of the `SkippedTurnEvent` object.
  ##
  ## Args:
  ##   turnNumber: The current turn number.
  result = SkippedTurnEvent(turnNumber: turnNumber)

