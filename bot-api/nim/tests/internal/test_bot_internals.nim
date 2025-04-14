nim
import unittest
import ../src/bot_api/internal/bot_internals
import ../src/bot_api/events/i_event
import ../src/bot_api/events/bot_event
import ../src/bot_api/events/custom_event
import ../src/bot_api/events/bot_death_event
import ../src/bot_api/internal/event_handler
import ../src/bot_api/internal/event_queue
import ../src/bot_api/internal/event_priorities
import ../src/bot_api/bot_state
import ../src/bot_api/game_setup
import ../src/bot_api/internal/graphics_state
import ../src/bot_api/mapper/event_mapper
import ../src/bot_api/mapper/game_setup_mapper

suite "BotInternals":

  test "Test constructor":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    let botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    check botInternals.eventHandler == eventHandler
    check botInternals.eventQueue == eventQueue
    check botInternals.eventPriorities == eventPriorities
    check botInternals.myBot == nil
    check botInternals.graphicsState == nil
    check botInternals.botState == nil
    check botInternals.gameSetup == nil
    check botInternals.eventMapper == nil
    check botInternals.gameSetupMapper == nil

  test "Test setMyBot":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let myBot = "myBot"
    botInternals.myBot = myBot
    check botInternals.myBot == myBot

  test "Test setGraphicsState":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let graphicsState = GraphicsState()
    botInternals.graphicsState = graphicsState
    check botInternals.graphicsState == graphicsState

  test "Test setBotState":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let botState = BotState()
    botInternals.botState = botState
    check botInternals.botState == botState

  test "Test setGameSetup":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let gameSetup = GameSetup()
    botInternals.gameSetup = gameSetup
    check botInternals.gameSetup == gameSetup

  test "Test setEventMapper":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let eventMapper = EventMapper()
    botInternals.eventMapper = eventMapper
    check botInternals.eventMapper == eventMapper
  
  test "Test setGameSetupMapper":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let gameSetupMapper = GameSetupMapper()
    botInternals.gameSetupMapper = gameSetupMapper
    check botInternals.gameSetupMapper == gameSetupMapper

  test "Test addEvent":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let event = BotEvent()
    botInternals.addEvent(event)
    check botInternals.eventQueue.hasEvents()

  test "Test addCustomEvent":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let customEvent = CustomEvent(condition = nil, priority = 0)
    botInternals.addCustomEvent(customEvent)
    check botInternals.eventQueue.hasEvents()

  test "Test addBotDeathEvent":
    let eventHandler = EventHandler()
    let eventQueue = EventQueue()
    let eventPriorities = EventPriorities()
    var botInternals = BotInternals(eventHandler, eventQueue, eventPriorities)
    let botDeathEvent = BotDeathEvent(deadBotId = 1)
    botInternals.addBotDeathEvent(botDeathEvent)
    check botInternals.eventQueue.hasEvents()