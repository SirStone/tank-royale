nim
import std/tables
import std/locks
import bot_api/events/tick_event
import bot_api/events/bot_event
import bot_api/events/connected_event
import bot_api/events/connection_error_event
import bot_api/events/disconnected_event
import bot_api/events/game_started_event
import bot_api/events/game_ended_event
import bot_api/events/round_started_event
import bot_api/events/round_ended_event
import bot_api/events/won_round_event
import bot_api/events/bot_death_event
import bot_api/events/hit_bot_event
import bot_api/events/hit_by_bullet_event
import bot_api/events/hit_wall_event
import bot_api/events/bullet_fired_event
import bot_api/events/bullet_hit_bot_event
import bot_api/events/bullet_hit_bullet_event
import bot_api/events/bullet_hit_wall_event
import bot_api/events/scanned_bot_event
import bot_api/events/skipped_turn_event
import bot_api/events/team_message_event
import bot_api/events/custom_event
import bot_api/default_event_priority


type
  EventHandler*[T] = ref object of RootObj
    callbacks*: seq[proc(event: T)] = @[]
    priority*: DefaultEventPriority = DefaultEventPriority.normal
    lock*: Lock

proc newEventHandler*[T](priority: DefaultEventPriority = DefaultEventPriority.normal): EventHandler[T] =
    result = EventHandler[T](lock: newLock(), priority: priority)

proc addCallback*[T](self: EventHandler[T], callback: proc(event: T)) =
  acquire(self.lock)
  defer: release(self.lock)
  self.callbacks.add(callback)

proc removeCallback*[T](self: EventHandler[T], callback: proc(event: T)) =
  acquire(self.lock)
  defer: release(self.lock)
  var index = -1
  for i, cb in self.callbacks:
    if cb == callback:
      index = i
      break
  if index != -1:
    self.callbacks.del(index)

proc fire*[T](self: EventHandler[T], event: T, instant: bool = false) =
  acquire(self.lock)
  defer: release(self.lock)
  for callback in self.callbacks:
    callback(event) 

type
  EventHandlers* = object
    onTick*: EventHandler[TickEvent]
    onConnected*: EventHandler[ConnectedEvent]
    onConnectionError*: EventHandler[ConnectionErrorEvent]
    onDisconnected*: EventHandler[DisconnectedEvent]
    onGameStarted*: EventHandler[GameStartedEvent]
    onGameEnded*: EventHandler[GameEndedEvent]
    onRoundStarted*: EventHandler[RoundStartedEvent]
    onRoundEnded*: EventHandler[RoundEndedEvent]
    onWonRound*: EventHandler[WonRoundEvent]
    onBotDeath*: EventHandler[BotDeathEvent]
    onHitBot*: EventHandler[HitBotEvent]
    onHitByBullet*: EventHandler[HitByBulletEvent]
    onHitWall*: EventHandler[HitWallEvent]
    onBulletFired*: EventHandler[BulletFiredEvent]
    onBulletHitBot*: EventHandler[BulletHitBotEvent]
    onBulletHitBullet*: EventHandler[BulletHitBulletEvent]
    onBulletHitWall*: EventHandler[BulletHitWallEvent]
    onScannedBot*: EventHandler[ScannedBotEvent]
    onSkippedTurn*: EventHandler[SkippedTurnEvent]
    onTeamMessage*: EventHandler[TeamMessageEvent]
    onCustomEvent*: EventHandler[CustomEvent]
    allHandlers*: Table[string, ref object of RootObj] = initTable[string, ref object of RootObj]()

proc initEventHandlers*(): EventHandlers =
  result = EventHandlers(
    onTick: newEventHandler[TickEvent](),
    onConnected: newEventHandler[ConnectedEvent](),
    onConnectionError: newEventHandler[ConnectionErrorEvent](),
    onDisconnected: newEventHandler[DisconnectedEvent](),
    onGameStarted: newEventHandler[GameStartedEvent](),
    onGameEnded: newEventHandler[GameEndedEvent](),
    onRoundStarted: newEventHandler[RoundStartedEvent](),
    onRoundEnded: newEventHandler[RoundEndedEvent](),
    onWonRound: newEventHandler[WonRoundEvent](),
    onBotDeath: newEventHandler[BotDeathEvent](),
    onHitBot: newEventHandler[HitBotEvent](),
    onHitByBullet: newEventHandler[HitByBulletEvent](),
    onHitWall: newEventHandler[HitWallEvent](),
    onBulletFired: newEventHandler[BulletFiredEvent](),
    onBulletHitBot: newEventHandler[BulletHitBotEvent](),
    onBulletHitBullet: newEventHandler[BulletHitBulletEvent](),
    onBulletHitWall: newEventHandler[BulletHitWallEvent](),
    onScannedBot: newEventHandler[ScannedBotEvent](),
    onSkippedTurn: newEventHandler[SkippedTurnEvent](),
    onTeamMessage: newEventHandler[TeamMessageEvent](),
    onCustomEvent: newEventHandler[CustomEvent]()
  )
  result.allHandlers["onTick"] = result.onTick
  result.allHandlers["onConnected"] = result.onConnected
  result.allHandlers["onConnectionError"] = result.onConnectionError
  result.allHandlers["onDisconnected"] = result.onDisconnected
  result.allHandlers["onGameStarted"] = result.onGameStarted
  result.allHandlers["onGameEnded"] = result.onGameEnded
  result.allHandlers["onRoundStarted"] = result.onRoundStarted
  result.allHandlers["onRoundEnded"] = result.onRoundEnded
  result.allHandlers["onWonRound"] = result.onWonRound
  result.allHandlers["onBotDeath"] = result.onBotDeath
  result.allHandlers["onHitBot"] = result.onHitBot
  result.allHandlers["onHitByBullet"] = result.onHitByBullet
  result.allHandlers["onHitWall"] = result.onHitWall
  result.allHandlers["onBulletFired"] = result.onBulletFired
  result.allHandlers["onBulletHitBot"] = result.onBulletHitBot
  result.allHandlers["onBulletHitBullet"] = result.onBulletHitBullet
  result.allHandlers["onBulletHitWall"] = result.onBulletHitWall
  result.allHandlers["onScannedBot"] = result.onScannedBot
  result.allHandlers["onSkippedTurn"] = result.onSkippedTurn
  result.allHandlers["onTeamMessage"] = result.onTeamMessage
  result.allHandlers["onCustomEvent"] = result.onCustomEvent