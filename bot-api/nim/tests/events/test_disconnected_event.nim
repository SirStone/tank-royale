nim
import unittest
import ../../src/bot_api/events/disconnected_event

suite "DisconnectedEvent":
  test "should create a disconnected event":
    let disconnectedEvent = DisconnectedEvent()
    check:
      disconnectedEvent.isInstanceOf DisconnectedEvent

  test "should have no properties on init":
    let disconnectedEvent = DisconnectedEvent()
    check:
      disconnectedEvent.isInstanceOf DisconnectedEvent

  test "should be a subclass of ConnectionEvent":
      let disconnectedEvent = DisconnectedEvent()
      check:
        disconnectedEvent.isInstanceOf ConnectionEvent