import ../bot_event

type
  ConnectionEvent* = ref object of BotEvent # No fields in the Java version, so none here.

proc newConnectionEvent*(): ConnectionEvent =
  ## Creates a new ConnectionEvent.
  result = ConnectionEvent()

