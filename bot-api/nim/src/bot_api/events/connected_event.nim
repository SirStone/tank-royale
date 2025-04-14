nim
import bot_api/events/event, bot_api/events/i_event

type
  ConnectedEvent* = ref object of Event ## Event sent when the bot is connected to the game server.
    ## There are no properties in this class
    

proc newConnectedEvent*(): ConnectedEvent {.inline.} =
  ## Creates a new ConnectedEvent.
  new(result)


