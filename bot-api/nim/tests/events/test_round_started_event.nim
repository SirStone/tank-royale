nim
import unittest
import ../../src/bot_api/events/round_started_event

suite "RoundStartedEvent":

  test "RoundStartedEvent can be created":
    let event = RoundStartedEvent()
    check event != nil

  test "RoundStartedEvent is an IEvent":
    let event = RoundStartedEvent()
    check event is IEvent

  test "RoundStartedEvent can be converted to string":
      let event = RoundStartedEvent()
      check event.toString() != ""

  test "RoundStartedEvent id is correct":
    let event = RoundStartedEvent()
    check event.eventId == 0