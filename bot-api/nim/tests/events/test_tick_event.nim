nim
import unittest
import ../src/bot_api/events/tick_event

suite "TickEvent":
  test "Constructor":
    let tickEvent = TickEvent()
    check:
      tickEvent.tick == 0

  test "Tick property":
    var tickEvent = TickEvent()
    tickEvent.tick = 10
    check:
      tickEvent.tick == 10

  test "toString":
    let tickEvent = TickEvent()
    check:
      tickEvent.toString() == "TickEvent(tick=0)"

  test "Tick property after set":
    var tickEvent = TickEvent()
    tickEvent.tick = 5
    check:
        tickEvent.tick == 5
    tickEvent.tick = 15
    check:
        tickEvent.tick == 15