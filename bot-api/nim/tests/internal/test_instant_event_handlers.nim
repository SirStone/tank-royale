nim
import unittest
import ../src/bot_api/internal/instant_event_handlers
import ../src/bot_api/events/i_event
import ../src/bot_api/events/game_started_event
import ../src/bot_api/events/game_ended_event
import ../src/bot_api/events/round_started_event
import ../src/bot_api/events/round_ended_event
import ../src/bot_api/events/tick_event
import ../src/bot_api/events/bot_death_event
import ../src/bot_api/events/scanned_bot_event
import ../src/bot_api/events/skipped_turn_event
import ../src/bot_api/events/won_round_event

suite "InstantEventHandlers Tests":

  test "test handleGameStarted":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = GameStartedEvent.newGameStartedEvent()
    handlers.handleGameStarted(event)
    # Add assertions here to check if the event was handled correctly

  test "test handleGameEnded":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = GameEndedEvent.newGameEndedEvent()
    handlers.handleGameEnded(event)
    # Add assertions here to check if the event was handled correctly

  test "test handleRoundStarted":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = RoundStartedEvent.newRoundStartedEvent()
    handlers.handleRoundStarted(event)
    # Add assertions here to check if the event was handled correctly

  test "test handleRoundEnded":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = RoundEndedEvent.newRoundEndedEvent()
    handlers.handleRoundEnded(event)
    # Add assertions here to check if the event was handled correctly

  test "test handleTickEvent":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = TickEvent.newTickEvent(1)
    handlers.handleTickEvent(event)
    # Add assertions here to check if the event was handled correctly
  
  test "test handleBotDeathEvent":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = BotDeathEvent.newBotDeathEvent(0, 0)
    handlers.handleBotDeathEvent(event)

  test "test handleScannedBotEvent":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = ScannedBotEvent.newScannedBotEvent(0, 0, 0.0, 0.0, 0, false)
    handlers.handleScannedBotEvent(event)
    
  test "test handleSkippedTurnEvent":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = SkippedTurnEvent.newSkippedTurnEvent()
    handlers.handleSkippedTurnEvent(event)
    
  test "test handleWonRoundEvent":
    var handlers = InstantEventHandlers.newInstantEventHandlers()
    var event = WonRoundEvent.newWonRoundEvent()
    handlers.handleWonRoundEvent(event)