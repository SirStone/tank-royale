nim
import unittest
import ../src/bot_api/events/skipped_turn_event

suite "SkippedTurnEvent":

  test "testSkippedTurnEventConstructor":
    let event = newSkippedTurnEvent()
    check event.turnSkipped

  test "testSkippedTurnEventGettersAndSetters":
    let event = newSkippedTurnEvent()
    event.turnSkipped = false
    check not event.turnSkipped
    event.turnSkipped = true
    check event.turnSkipped

  test "testSkippedTurnEventToString":
      let event = newSkippedTurnEvent()
      check event.toString() == "SkippedTurnEvent(turnSkipped: true)"
      event.turnSkipped = false
      check event.toString() == "SkippedTurnEvent(turnSkipped: false)"