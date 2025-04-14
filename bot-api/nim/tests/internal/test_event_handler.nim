nim
import unittest
import ../src/bot_api/internal/event_handler
import ../src/bot_api/events/i_event
import ../src/bot_api/events/tick_event
import ../src/bot_api/events/bot_event
import ../src/bot_api/internal/event_queue
import ../src/bot_api/internal/event_priorities
import ../src/bot_api/internal/event_interruption

type
  MockEvent* = object of IEvent

  MockEventQueue* = ref object of EventQueue
    queue*: seq[IEvent]

  MockEventHandler* = ref object of EventHandler
    queue*: MockEventQueue
    priorities*: EventPriorities
    interruption*: EventInterruption

proc add*(this: MockEventQueue, event: IEvent) =
  this.queue.add(event)

proc take*(this: MockEventQueue): IEvent =
  if this.queue.len > 0:
    return this.queue.pop()
  else:
    return nil

proc createMockEventHandler*(): MockEventHandler =
  let mockEventQueue = MockEventQueue(queue: @[])
  let mockEventPriorities = EventPriorities()
  let mockEventInterruption = EventInterruption()
  return MockEventHandler(queue: mockEventQueue, priorities: mockEventPriorities, interruption: mockEventInterruption)

suite "EventHandler":
  test "Constructor":
    let eventHandler = createMockEventHandler()
    check:
      eventHandler.queue.queue.len == 0
      eventHandler.priorities.priorities.len == 0
      eventHandler.interruption.interruptions.len == 0
  
  test "addEvent":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    check:
      eventHandler.queue.queue.len == 1

  test "addEventWithPriority":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent, 10)
    check:
      eventHandler.queue.queue.len == 1
      eventHandler.priorities.priorities.len == 1
  
  test "getNextEvent":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    let nextEvent = eventHandler.getNextEvent()
    check:
      nextEvent == mockEvent
      eventHandler.queue.queue.len == 0
    
  test "getNextEventWhenEmpty":
    let eventHandler = createMockEventHandler()
    let nextEvent = eventHandler.getNextEvent()
    check:
      nextEvent == nil

  test "clear":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    eventHandler.addEvent(mockEvent)
    eventHandler.clear()
    check:
      eventHandler.queue.queue.len == 0

  test "size":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    check:
      eventHandler.size() == 1

  test "isEmpty":
    let eventHandler = createMockEventHandler()
    check:
      eventHandler.isEmpty() == true
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    check:
      eventHandler.isEmpty() == false

  test "hasEvent":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    check:
      eventHandler.hasEvent() == true
    eventHandler.getNextEvent()
    check:
      eventHandler.hasEvent() == false
  
  test "interruptEvent":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    eventHandler.interruptEvent(mockEvent)
    check:
      eventHandler.interruption.interruptions.len == 1
  
  test "isInterrupted":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    eventHandler.interruptEvent(mockEvent)
    check:
      eventHandler.isInterrupted(mockEvent) == true
    eventHandler.interruption.clear()
    check:
      eventHandler.isInterrupted(mockEvent) == false

  test "removeInterruption":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    eventHandler.interruptEvent(mockEvent)
    check:
      eventHandler.interruption.interruptions.len == 1
    eventHandler.removeInterruption(mockEvent)
    check:
      eventHandler.interruption.interruptions.len == 0
  
  test "resumeEvent":
    let eventHandler = createMockEventHandler()
    let mockEvent = MockEvent()
    eventHandler.addEvent(mockEvent)
    eventHandler.interruptEvent(mockEvent)
    eventHandler.resumeEvent(mockEvent)
    check:
      eventHandler.queue.queue.len == 1
      eventHandler.interruption.interruptions.len == 0

  test "addEventWithSamePriority":
    let eventHandler = createMockEventHandler()
    let mockEvent1 = MockEvent()
    let mockEvent2 = MockEvent()
    eventHandler.addEvent(mockEvent1, 1)
    eventHandler.addEvent(mockEvent2, 1)
    let nextEvent1 = eventHandler.getNextEvent()
    check:
      nextEvent1 == mockEvent1 or nextEvent1 == mockEvent2
    let nextEvent2 = eventHandler.getNextEvent()
    check:
      nextEvent2 == mockEvent1 or nextEvent2 == mockEvent2
    check:
      nextEvent1 != nextEvent2

  test "addEventWithDifferentPriority":
    let eventHandler = createMockEventHandler()
    let mockEvent1 = MockEvent()
    let mockEvent2 = MockEvent()
    eventHandler.addEvent(mockEvent1, 1)
    eventHandler.addEvent(mockEvent2, 2)
    let nextEvent1 = eventHandler.getNextEvent()
    check:
      nextEvent1 == mockEvent2
    let nextEvent2 = eventHandler.getNextEvent()
    check:
      nextEvent2 == mockEvent1