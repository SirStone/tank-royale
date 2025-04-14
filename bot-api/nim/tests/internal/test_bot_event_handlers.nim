nim
import unittest
import ../../src/bot_api/internal/bot_event_handlers
import ../../src/bot_api/events/i_event
import ../../src/bot_api/events/bot_event
import ../../src/bot_api/events/bot_death_event
import ../../src/bot_api/events/bullet_fired_event
import ../../src/bot_api/events/bullet_hit_bot_event
import ../../src/bot_api/events/bullet_hit_bullet_event
import ../../src/bot_api/events/bullet_hit_wall_event
import ../../src/bot_api/events/connected_event
import ../../src/bot_api/events/connection_error_event
import ../../src/bot_api/events/connection_event
import ../../src/bot_api/events/custom_event
import ../../src/bot_api/events/death_event
import ../../src/bot_api/events/disconnected_event
import ../../src/bot_api/events/game_ended_event
import ../../src/bot_api/events/game_started_event
import ../../src/bot_api/events/hit_bot_event
import ../../src/bot_api/events/hit_by_bullet_event
import ../../src/bot_api/events/hit_wall_event
import ../../src/bot_api/events/round_ended_event
import ../../src/bot_api/events/round_started_event
import ../../src/bot_api/events/scanned_bot_event
import ../../src/bot_api/events/skipped_turn_event
import ../../src/bot_api/events/team_message_event
import ../../src/bot_api/events/tick_event
import ../../src/bot_api/events/won_round_event
import ../../src/bot_api/internal/event_handler

suite "BotEventHandlers":

  test "Test registerEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = BotEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerBotDeathEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = BotDeathEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerBotDeathEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerBulletFiredEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = BulletFiredEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerBulletFiredEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerBulletHitBotEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = BulletHitBotEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerBulletHitBotEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerBulletHitBulletEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = BulletHitBulletEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerBulletHitBulletEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerBulletHitWallEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = BulletHitWallEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerBulletHitWallEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerConnectedEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = ConnectedEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerConnectedEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerConnectionErrorEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = ConnectionErrorEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerConnectionErrorEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerConnectionEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = ConnectionEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerConnectionEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerCustomEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = CustomEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerCustomEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked
  
  test "Test registerDeathEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = DeathEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerDeathEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerDisconnectedEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = DisconnectedEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerDisconnectedEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked
  
  test "Test registerGameEndedEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = GameEndedEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerGameEndedEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerGameStartedEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = GameStartedEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerGameStartedEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerHitBotEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = HitBotEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerHitBotEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerHitByBulletEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = HitByBulletEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerHitByBulletEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerHitWallEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = HitWallEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerHitWallEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerRoundEndedEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = RoundEndedEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerRoundEndedEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerRoundStartedEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = RoundStartedEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerRoundStartedEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked
  
  test "Test registerScannedBotEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = ScannedBotEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerScannedBotEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked

  test "Test registerSkippedTurnEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = SkippedTurnEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerSkippedTurnEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked
  
  test "Test registerTeamMessageEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = TeamMessageEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerTeamMessageEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked
  
  test "Test registerTickEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = TickEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerTickEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked
  
  test "Test registerWonRoundEventHandler and invoke handler":
    var eventHandlers = newBotEventHandlers()
    var event: IEvent = WonRoundEvent.new()
    var handlerInvoked = false

    proc myEventHandler(event: IEvent) =
      handlerInvoked = true

    eventHandlers.registerWonRoundEventHandler(myEventHandler)
    eventHandlers.onEvent(event)
    check handlerInvoked