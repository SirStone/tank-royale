nim
import bot_api/i_base_bot, bot_api/events/i_event, bot_api/bot_state,
       bot_api/events/i_event, bot_api/internal/event_queue,
       bot_api/internal/event_handler, bot_api/internal/event_priorities


type
  BaseBotInternals* = ref object of RootObj
    baseBot*: IBaseBot
    botState*: BotState
    eventQueue*: EventQueue
    eventHandlers*: EventHandler
    isStopped*: bool
    isRunning*: bool

proc newBaseBotInternals*(baseBot: IBaseBot): BaseBotInternals =
  result = BaseBotInternals(
    baseBot: baseBot,
    botState: newBotState(),
    eventQueue: newEventQueue(),
    eventHandlers: newEventHandler(),
    isStopped: false,
    isRunning: false
  )

proc cleanup*(internals: BaseBotInternals) =
  internals.eventQueue.clear()
  internals.eventHandlers.clear()
  internals.botState.cleanup()

proc addListener*(internals: BaseBotInternals, eventType: type IEvent, handler: proc (event: IEvent)) =
  internals.eventHandlers.addEventHandler(eventType, handler, DefaultEventPriority.Normal)

proc start*(internals: BaseBotInternals) =
  internals.isRunning = true

proc stop*(internals: BaseBotInternals) =
  internals.isRunning = false
  internals.isStopped = true

proc queueEvent*(internals: BaseBotInternals, event: IEvent) =
  internals.eventQueue.add(event)

proc clearEventQueue*(internals: BaseBotInternals) =
  internals.eventQueue.clear()

proc nextEvent*(internals: BaseBotInternals): IEvent =
    result = internals.eventQueue.poll()

proc getBotState*(internals: BaseBotInternals): BotState =
  result = internals.botState

proc setBotState*(internals: BaseBotInternals, botState: BotState) =
    internals.botState = botState

