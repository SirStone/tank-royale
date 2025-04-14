nim
import unittest
import ../../src/bot_api/events/connection_event

suite "ConnectionEvent":
  test "ConnectionEvent should be constructible":
    let event = ConnectionEvent()
    check event is ConnectionEvent

  test "ConnectionEvent should be assignable":
    var event = ConnectionEvent()
    var otherEvent: ConnectionEvent
    otherEvent = event
    check otherEvent is ConnectionEvent

  test "ConnectionEvent should be instantiable":
    let event = ConnectionEvent()
    check event.getType() == "ConnectionEvent"