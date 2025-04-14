import bot_api/events/event_abc

type
  ConnectionErrorEvent* = ref object of EventABC
    message*: string

proc getMessage*(self: ConnectionErrorEvent): string =
  ## Returns the error message.
  return self.message

proc newConnectionErrorEvent*(message: string): ConnectionErrorEvent =
  result = ConnectionErrorEvent()
  result.message = message


