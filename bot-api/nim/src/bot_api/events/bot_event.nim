## Bot event occurring during a battle.

import i_event

type
  BotEvent* = object of IEvent
    ## Base class for all bot events
    turnNumber*: int    ## Turn number when this event occurred
    
proc newBotEvent*(turnNumber: int): BotEvent =
  ## Initializes a new instance of the BotEvent class
  result = BotEvent(turnNumber: turnNumber)

proc getTurnNumber*(event: BotEvent): int =
  ## Returns the turn number when this event occurred
  result = event.turnNumber

proc isCritical*(event: BotEvent): bool =
  ## Indicates if this event is critical, and hence should not be removed from event queue when it gets old
  result = false