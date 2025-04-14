nim
import unittest
import ../../src/bot_api/events/custom_event

suite "CustomEvent":
  test "constructor":
    let customEvent = CustomEvent("testEvent")
    check customEvent.name == "testEvent"

  test "toString":
    let customEvent = CustomEvent("testEvent")
    check customEvent.toString() == "CustomEvent(name=testEvent)"