nim
import times
import ../default_event_priority
import ../internal/event_priorities

type
  BotEvent* = ref object of RootObj ## Represents an event occurring in the game.
    time*: Time ## Time when the event occurred.
    priority*: int ## Priority of the event

proc initBotEvent*(event: BotEvent) =
  ## Initialize a BotEvent with the current time and default event priority.
  event.time = now()
  event.priority = DefaultEventPriority.getDefaultPriority

proc getPriority*(event: BotEvent): int =
  ## Returns the priority of the event.
  return event.priority