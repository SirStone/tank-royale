import ./event_priorities, ./event_queue
import ../bot, ../base_bot
import ../events/i_event, ./event_handler
import std/locks

type
  BotInternals* = ref object of RootObj
    bot*: Bot
    eventQueue*: EventQueue
    isStopped*: bool
    eventHandler*: EventHandler
    mutex*: Lock
    condition*: Condition

proc newBotInternals*(bot: Bot): BotInternals =
  result = BotInternals()
  result.bot = bot
  result.eventQueue = newEventQueue()
  result.isStopped = false
  result.eventHandler = newEventHandler()
  result.mutex = newLock()
  result.condition = newCondition()

proc start*(internals: BotInternals) =
  acquire(internals.mutex)
  defer: release(internals.mutex)

  internals.isStopped = false

proc stop*(internals: BotInternals) =
  acquire(internals.mutex)
  defer: release(internals.mutex)

  internals.isStopped = true
  signal(internals.condition)

proc resume*(internals: BotInternals) =
    acquire(internals.mutex)
    defer: release(internals.mutex)

    if internals.isStopped:
        internals.isStopped = false
        signal(internals.condition)

proc isStopped*(internals: BotInternals): bool =
    acquire(internals.mutex)
    defer: release(internals.mutex)

    return internals.isStopped

proc addEventHandler*(internals: BotInternals, eventHandler: proc (event: IEvent, data: pointer)) =
    internals.eventHandler.add(eventHandler)

proc handleEvent*(internals: BotInternals, event: IEvent) =
    internals.eventHandler.handleEvent(event)

proc clearEventQueue*(internals: BotInternals) =
  internals.eventQueue.clear()

proc addEventToQueue*(internals: BotInternals, event: IEvent, priority: EventPriority = DefaultEventPriority.normal) =
    internals.eventQueue.add(event, priority)
    
proc nextEvent*(internals: BotInternals): IEvent = 
  acquire(internals.mutex)
  defer: release(internals.mutex)
  while internals.eventQueue.isEmpty() and not internals.isStopped:
      wait(internals.condition, internals.mutex)
  
  return internals.eventQueue.next()