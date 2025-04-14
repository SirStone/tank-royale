nim
import unittest
import ../../src/bot_api/events/connected_event

suite "ConnectedEvent":
  test "ConnectedEvent should be created":
    let connectedEvent = ConnectedEvent()
    check connectedEvent is not nil

  test "ConnectedEvent should have type connection":
    let connectedEvent = ConnectedEvent()
    check connectedEvent.type == "connection"

  test "ConnectedEvent should be of ConnectedEvent type":
      let connectedEvent = ConnectedEvent()
      check connectedEvent.connectedEventType == ConnectedEventType.Connected