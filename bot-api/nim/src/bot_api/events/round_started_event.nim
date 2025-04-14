nim
import ./bot_event
import ./i_event

type
  RoundStartedEvent* = ref object of BotEvent ## Represents an event that occurs when a new round has started.
    roundNumber*: int


proc initRoundStartedEvent*(roundNumber: int): RoundStartedEvent =
    new(result)
    result.roundNumber = roundNumber

proc getRoundNumber*(this: RoundStartedEvent): int =
    this.roundNumber

