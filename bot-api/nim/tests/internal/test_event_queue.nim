nim
import unittest
import ../src/bot_api/internal/event_queue
import ../src/bot_api/events/i_event

suite "EventQueue":
  test "enqueue":
    var queue = newEventQueue()
    var event1 = newBotEvent()
    var event2 = newBotEvent()
    queue.enqueue(event1)
    queue.enqueue(event2)
    check queue.size == 2

  test "dequeue":
    var queue = newEventQueue()
    var event1 = newBotEvent()
    var event2 = newBotEvent()
    queue.enqueue(event1)
    queue.enqueue(event2)
    check queue.dequeue() == event1
    check queue.dequeue() == event2
    check queue.size == 0

  test "peek":
    var queue = newEventQueue()
    var event1 = newBotEvent()
    var event2 = newBotEvent()
    queue.enqueue(event1)
    queue.enqueue(event2)
    check queue.peek() == event1
    check queue.size == 2

  test "clear":
    var queue = newEventQueue()
    var event1 = newBotEvent()
    var event2 = newBotEvent()
    queue.enqueue(event1)
    queue.enqueue(event2)
    queue.clear()
    check queue.size == 0
    check queue.dequeue() == nil

  test "isEmpty":
    var queue = newEventQueue()
    check queue.isEmpty()
    var event1 = newBotEvent()
    queue.enqueue(event1)
    check not queue.isEmpty()
    queue.dequeue()
    check queue.isEmpty()