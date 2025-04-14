nim
import unittest
import ../src/bot_api/bot_exception

suite "BotException Tests":

  test "BotException Constructor":
    let exception = newException(BotException, "Test exception message")
    check:
      exception.msg == "Test exception message"

  test "BotException Constructor With Cause":
    let cause = newException(Defect, "Cause exception")
    let exception = newException(BotException, "Test exception message", cause)
    check:
      exception.msg == "Test exception message"
      exception.cause == cause

  test "Raise BotException":
    try:
      raise newException(BotException, "Raised exception")
    except BotException as e:
      check:
        e.msg == "Raised exception"

  test "Raise BotException With Cause":
    let cause = newException(Defect, "Cause exception")
    try:
      raise newException(BotException, "Raised exception", cause)
    except BotException as e:
      check:
        e.msg == "Raised exception"
        e.cause == cause