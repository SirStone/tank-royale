nim
import ./event_handler
import ../events/i_event
import ../events/bot_event
import ../events/tick_event
import ../events/round_started_event
import ../events/game_started_event
import ../events/game_ended_event
import ../events/round_ended_event
import ../events/bot_death_event
import ../events/connected_event
import ../events/disconnected_event
import ../events/connection_error_event
import ../default_event_priority

type
  InstantEventHandlers* = ref object of EventHandler
    onTick*: proc(event: TickEvent) {.nimcall.}
    onRoundStarted*: proc(event: RoundStartedEvent) {.nimcall.}
    onGameStarted*: proc(event: GameStartedEvent) {.nimcall.}
    onGameEnded*: proc(event: GameEndedEvent) {.nimcall.}
    onRoundEnded*: proc(event: RoundEndedEvent) {.nimcall.}
    onBotDeath*: proc(event: BotDeathEvent) {.nimcall.}
    onConnected*: proc(event: ConnectedEvent) {.nimcall.}
    onDisconnected*: proc(event: DisconnectedEvent) {.nimcall.}
    onConnectionError*: proc(event: ConnectionErrorEvent) {.nimcall.}

proc newInstantEventHandlers*(): InstantEventHandlers =
  new(result)
  result.onTick = proc(event: TickEvent) = discard
  result.onRoundStarted = proc(event: RoundStartedEvent) = discard
  result.onGameStarted = proc(event: GameStartedEvent) = discard
  result.onGameEnded = proc(event: GameEndedEvent) = discard
  result.onRoundEnded = proc(event: RoundEndedEvent) = discard
  result.onBotDeath = proc(event: BotDeathEvent) = discard
  result.onConnected = proc(event: ConnectedEvent) = discard
  result.onDisconnected = proc(event: DisconnectedEvent) = discard
  result.onConnectionError = proc(event: ConnectionErrorEvent) = discard

proc registerTickHandler*(self: InstantEventHandlers, handler: proc(event: TickEvent) {.nimcall.}) =
  self.onTick = handler

proc registerRoundStartedHandler*(self: InstantEventHandlers, handler: proc(event: RoundStartedEvent) {.nimcall.}) =
  self.onRoundStarted = handler

proc registerGameStartedHandler*(self: InstantEventHandlers, handler: proc(event: GameStartedEvent) {.nimcall.}) =
  self.onGameStarted = handler

proc registerGameEndedHandler*(self: InstantEventHandlers, handler: proc(event: GameEndedEvent) {.nimcall.}) =
  self.onGameEnded = handler

proc registerRoundEndedHandler*(self: InstantEventHandlers, handler: proc(event: RoundEndedEvent) {.nimcall.}) =
  self.onRoundEnded = handler

proc registerBotDeathHandler*(self: InstantEventHandlers, handler: proc(event: BotDeathEvent) {.nimcall.}) =
  self.onBotDeath = handler
  
proc registerConnectedHandler*(self: InstantEventHandlers, handler: proc(event: ConnectedEvent) {.nimcall.}) =
  self.onConnected = handler

proc registerDisconnectedHandler*(self: InstantEventHandlers, handler: proc(event: DisconnectedEvent) {.nimcall.}) =
  self.onDisconnected = handler

proc registerConnectionErrorHandler*(self: InstantEventHandlers, handler: proc(event: ConnectionErrorEvent) {.nimcall.}) =
  self.onConnectionError = handler

proc fire*(self: InstantEventHandlers, event: IEvent) =
  if event is TickEvent:
    self.onTick(TickEvent(event))
  elif event is RoundStartedEvent:
    self.onRoundStarted(RoundStartedEvent(event))
  elif event is GameStartedEvent:
    self.onGameStarted(GameStartedEvent(event))
  elif event is GameEndedEvent:
    self.onGameEnded(GameEndedEvent(event))
  elif event is RoundEndedEvent:
    self.onRoundEnded(RoundEndedEvent(event))
  elif event is BotDeathEvent:
    self.onBotDeath(BotDeathEvent(event))
  elif event is ConnectedEvent:
    self.onConnected(ConnectedEvent(event))
  elif event is DisconnectedEvent:
    self.onDisconnected(DisconnectedEvent(event))
  elif event is ConnectionErrorEvent:
    self.onConnectionError(ConnectionErrorEvent(event))


proc registerEventHandler*(self: InstantEventHandlers, eventType: typedesc[BotEvent], 
                         priority: DefaultEventPriority = DefaultEventPriority.Normal, 
                         handler: proc(event: BotEvent) {.nimcall.}) =
  discard
  
proc registerEventHandler*(self: InstantEventHandlers, eventType: typedesc[IEvent], 
                         priority: DefaultEventPriority = DefaultEventPriority.Normal, 
                         handler: proc(event: IEvent) {.nimcall.}) = discard