nim
import unittest
import ../src/bot_api/events/next_turn_condition

suite "NextTurnCondition":
  test "Constructor":
    let condition = newNextTurnCondition()
    check:
      condition.nextTurn == true

  test "isMet":
    let condition = newNextTurnCondition()
    check:
      condition.isMet() == true

  test "reset":
    let condition = newNextTurnCondition()
    condition.reset()
    check:
      condition.nextTurn == true