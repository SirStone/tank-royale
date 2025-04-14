nim
import unittest
import ../src/bot_api/internal/event_interruption

suite "EventInterruption":
  test "Test EventInterruption creation":
    let interruption = EventInterruption.new("TestReason")
    check:
      interruption.reason == "TestReason"

  test "Test EventInterruption with empty reason":
    let interruption = EventInterruption.new("")
    check:
      interruption.reason == ""

  test "Test EventInterruption with nil reason":
    let interruption = EventInterruption.new(nil)
    check:
      interruption.reason == ""

  test "Test EventInterruption reason modification":
    var interruption = EventInterruption.new("InitialReason")
    check:
        interruption.reason == "InitialReason"

    interruption.reason = "NewReason"
    check:
        interruption.reason == "NewReason"

  test "Test EventInterruption reason modification to empty":
    var interruption = EventInterruption.new("InitialReason")
    check:
        interruption.reason == "InitialReason"

    interruption.reason = ""
    check:
        interruption.reason == ""

  test "Test EventInterruption reason modification to nil":
    var interruption = EventInterruption.new("InitialReason")
    check:
        interruption.reason == "InitialReason"

    interruption.reason = nil
    check:
        interruption.reason == ""