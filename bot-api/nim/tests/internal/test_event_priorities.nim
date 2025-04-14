nim
import unittest
import ../src/bot_api/internal/event_priorities

suite "EventPriorities":
  test "Test get and set priority":
    let eventPriorities = newEventPriorities()
    check eventPriorities.getPriority("event1") == 0
    eventPriorities.setPriority("event1", 10)
    check eventPriorities.getPriority("event1") == 10
    eventPriorities.setPriority("event1", 5)
    check eventPriorities.getPriority("event1") == 5

  test "Test getPriority with non-existing event":
    let eventPriorities = newEventPriorities()
    check eventPriorities.getPriority("non_existing_event") == 0

  test "Test getSortedEvents":
    let eventPriorities = newEventPriorities()
    eventPriorities.setPriority("event1", 10)
    eventPriorities.setPriority("event2", 5)
    eventPriorities.setPriority("event3", 15)
    let sortedEvents = eventPriorities.getSortedEvents()
    check sortedEvents == @["event3", "event1", "event2"]

  test "Test getSortedEvents with empty events":
    let eventPriorities = newEventPriorities()
    let sortedEvents = eventPriorities.getSortedEvents()
    check sortedEvents == @[]

  test "Test getSortedEvents with same priority":
    let eventPriorities = newEventPriorities()
    eventPriorities.setPriority("event1", 10)
    eventPriorities.setPriority("event2", 10)
    eventPriorities.setPriority("event3", 10)
    let sortedEvents = eventPriorities.getSortedEvents()
    check sortedEvents.len == 3

  test "Test removePriority":
    let eventPriorities = newEventPriorities()
    eventPriorities.setPriority("event1", 10)
    check eventPriorities.getPriority("event1") == 10
    eventPriorities.removePriority("event1")
    check eventPriorities.getPriority("event1") == 0

  test "Test removePriority with non-existing event":
    let eventPriorities = newEventPriorities()
    eventPriorities.removePriority("non_existing_event")
    check eventPriorities.getPriority("non_existing_event") == 0