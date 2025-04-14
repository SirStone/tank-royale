nim
import unittest
import ../src/bot_api/events/bot_event

suite "BotEvent":
  test "test default constructor":
    let event = BotEvent()
    check event.timeStamp != 0.0

  test "test parametrized constructor":
    let timeStamp = 1234.56
    let event = BotEvent(timeStamp)
    check event.timeStamp == timeStamp

  test "test toString":
    let timeStamp = 1234.56
    let event = BotEvent(timeStamp)
    let expectedString = "BotEvent(timeStamp=1234.56)"
    check event.toString() == expectedString

  test "test copy":
    let timeStamp = 1234.56
    let event = BotEvent(timeStamp)
    let copiedEvent = event.copy()
    check copiedEvent.timeStamp == timeStamp

  test "test copy with default constructor":
    let event = BotEvent()
    let copiedEvent = event.copy()
    check copiedEvent.timeStamp == event.timeStamp