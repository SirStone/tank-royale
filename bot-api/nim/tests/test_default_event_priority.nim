nim
import unittest
import ../src/bot_api/default_event_priority

suite "DefaultEventPriority":
  test "Test DefaultEventPriority values":
    check(DefaultEventPriority.Normal.toInt == 0)
    check(DefaultEventPriority.VeryHigh.toInt == 100000)
    check(DefaultEventPriority.High.toInt == 10000)
    check(DefaultEventPriority.AboveNormal.toInt == 100)
    check(DefaultEventPriority.BelowNormal.toInt == -100)
    check(DefaultEventPriority.Low.toInt == -10000)
    check(DefaultEventPriority.VeryLow.toInt == -100000)

  test "Test DefaultEventPriority fromInt":
    check(DefaultEventPriority.fromInt(0) == DefaultEventPriority.Normal)
    check(DefaultEventPriority.fromInt(100000) == DefaultEventPriority.VeryHigh)
    check(DefaultEventPriority.fromInt(10000) == DefaultEventPriority.High)
    check(DefaultEventPriority.fromInt(100) == DefaultEventPriority.AboveNormal)
    check(DefaultEventPriority.fromInt(-100) == DefaultEventPriority.BelowNormal)
    check(DefaultEventPriority.fromInt(-10000) == DefaultEventPriority.Low)
    check(DefaultEventPriority.fromInt(-100000) == DefaultEventPriority.VeryLow)
    check(DefaultEventPriority.fromInt(12345) == DefaultEventPriority.Normal)
    check(DefaultEventPriority.fromInt(-12345) == DefaultEventPriority.Normal)