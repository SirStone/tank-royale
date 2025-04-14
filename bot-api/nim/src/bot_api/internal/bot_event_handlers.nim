import std/[tables, sequtils, strutils, locks]
import ./i_event, ../bot, ./event_priorities, ./event_interruption

type
  EventHandler* = ref object
    handler: proc(bot: Bot, event: IEvent)
    priority: EventPriority

  EventHandlerList* = ref object
    handlers: seq[EventHandler]
    lock: Lock


type
  BotEventHandlers* = ref object of RootObj
    handlers*: Table[string, EventHandlerList]

proc newBotEventHandlers*(): BotEventHandlers =
  result = BotEventHandlers()
  result.handlers = initTable[string, EventHandlerList]()

proc registerEventHandler*(handlers: BotEventHandlers, eventName: string,
                         handler: proc (bot: Bot, event: IEvent),
                         priority: EventPriority = EventPriority.NORMAL) =
  let eventHandler = EventHandler(handler: handler, priority: priority)
  if not handlers.handlers.hasKey(eventName):
    handlers.handlers[eventName] = EventHandlerList(handlers: @[], lock: initLock())
  
  let eventHandlerList = handlers.handlers[eventName]
  eventHandlerList.lock.acquire()
  try:
    eventHandlerList.handlers.add(eventHandler)
    eventHandlerList.handlers.sort(proc (a, b: EventHandler): int = cmp(a.priority, b.priority))
  finally:
    eventHandlerList.lock.release()

proc handleEvent*(handlers: BotEventHandlers, bot: Bot, event: IEvent) =
  let eventName = $type(event)
  
  if handlers.handlers.hasKey(eventName.toLowerAscii):
    let eventHandlerList = handlers.handlers[eventName.toLowerAscii]
    var interrupted = false
    
    eventHandlerList.lock.acquire()
    try:
      for eventHandler in eventHandlerList.handlers:
        eventHandler.handler(bot, event)
        
        if event.isNil:
            interrupted = true
            break
    finally:
        eventHandlerList.lock.release()
    
    if interrupted:
        raise newException(EventInterruption, "Event handler interrupted by a handler")


proc unregisterAll*(handlers: BotEventHandlers) =
  for key in handlers.handlers.keys:
    let eventHandlerList = handlers.handlers[key]
    eventHandlerList.lock.acquire()
    try:
      eventHandlerList.handlers.setLen(0)
    finally:
      eventHandlerList.lock.release()