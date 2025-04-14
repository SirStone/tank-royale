nim
import bot_api/events/event_abc

type
  DisconnectedEvent* = ref object of ConnectionEvent


proc newDisconnectedEvent*(): DisconnectedEvent =
  result = new(DisconnectedEvent)

