nim
import unittest
import ../src/bot_api/events/won_round_event

suite "WonRoundEvent":
  test "Constructor":
    let event = WonRoundEvent()
    check event != nil

  test "ToString":
    let event = WonRoundEvent()
    let expected = "WonRoundEvent{}"
    check event.toString() == expected