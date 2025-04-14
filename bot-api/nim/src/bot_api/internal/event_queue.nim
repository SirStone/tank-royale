nim
import sequtils, algorithm, locks
import ../events/i_event
import ../default_event_priority

type
  Event {.inheritable.} = IEvent
  EventHandler* = ref object
    priority*: DefaultEventPriority
    condition*: proc(event: Event): bool
    action*: proc(event: Event)

type
  EventQueue* = ref object
    eventHandlers*: seq[EventHandler]
    events*: seq[Event]
    lock*: Lock
    isProcessing*: bool


proc newEventQueue*(): EventQueue =
  new(result)
  result.eventHandlers = @[]
  result.events = @[]
  initLock(result.lock)
  result.isProcessing = false

proc addEventHandler*(queue: EventQueue, priority: DefaultEventPriority, condition: proc(event: Event): bool, action: proc(event: Event)) =
  ## Adds an event handler to the queue.
  ## An event handler will be executed based on its priority if the event matches the condition.
  let handler = EventHandler(priority: priority, condition: condition, action: action)
  
  withLock queue.lock:
    queue.eventHandlers.add(handler)

proc addEventHandler*(queue: EventQueue, priority: DefaultEventPriority, action: proc(event: Event)) =
  ## Adds an event handler to the queue.
  ## An event handler will be executed based on its priority.
  let handler = EventHandler(priority: priority, condition: proc(event: Event): bool = true, action: action)

  withLock queue.lock:
    queue.eventHandlers.add(handler)

proc hasHandlers*(queue: EventQueue): bool =
  ## Checks if the queue has any event handlers.
  withLock queue.lock:
    result = queue.eventHandlers.len > 0

proc hasEvents*(queue: EventQueue): bool =
  ## Checks if the queue has any events.
  withLock queue.lock:
    result = queue.events.len > 0

proc addEvent*(queue: EventQueue, event: Event) =
  ## Adds an event to the queue.
  withLock queue.lock:
    queue.events.add(event)

proc process*(queue: EventQueue) {.locks: [queue.lock].} =
  ## Processes all events in the queue.
  ## This will sort the event handlers by priority and then execute them if the event matches the condition.

  if queue.isProcessing:
    return
  
  queue.isProcessing = true

  try:
    var eventsCopy: seq[Event]
    withLock queue.lock:
      eventsCopy = queue.events
      queue.events.setLen(0)

    if eventsCopy.len == 0:
      return
    
    var handlersCopy: seq[EventHandler]
    withLock queue.lock:
      handlersCopy = queue.eventHandlers
      handlersCopy.sortIt(a.priority > b.priority)
    
    for event in eventsCopy:
      for handler in handlersCopy:
        if handler.condition(event):
          handler.action(event)
  finally:
    queue.isProcessing = false

proc clear*(queue: EventQueue) {.locks: [queue.lock].} =
  ## Clears all event handlers and events from the queue.
  withLock queue.lock:
    queue.eventHandlers.setLen(0)
    queue.events.setLen(0)


proc removeEventHandler*(queue: EventQueue, handlerToRemove: EventHandler) {.locks: [queue.lock].} =
    ## Removes a specific event handler from the queue.
    var indexToRemove = -1
    withLock queue.lock:
        for i, handler in queue.eventHandlers:
            if handler == handlerToRemove:
                indexToRemove = i
                break
        if indexToRemove != -1:
            queue.eventHandlers.del(indexToRemove)

proc removeEventHandlerByAction*(queue: EventQueue, actionToRemove: proc(event: Event)) {.locks: [queue.lock].} =
  ## Removes an event handler from the queue based on its action.
  var indexToRemove = -1
  withLock queue.lock:
    for i, handler in queue.eventHandlers:
      if handler.action == actionToRemove:
        indexToRemove = i
        break
    if indexToRemove != -1:
      queue.eventHandlers.del(indexToRemove)

proc clear*(queue: EventQueue) =
  queue.eventHandlers.setLen(0)
  queue.events.setLen(0)