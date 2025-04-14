nim
import ../bot_event
import ./i_event
import ./event_type

type
  RoundEndedEvent* = ref object of BotEvent
    roundNumber*: int


proc newRoundEndedEvent*(roundNumber: int): RoundEndedEvent =
  result = RoundEndedEvent(eventType: EventType.RoundEndedEvent)
  result.roundNumber = roundNumber

proc getRoundNumber*(event: RoundEndedEvent): int =
