nim
import unittest
import ../../src/bot_api/events/connection_error_event

suite "ConnectionErrorEvent":

  test "Constructor and Getters":
    let exception = newException(IOError, "Test error")
    let event = ConnectionErrorEvent(exception: exception)
    check:
      event.exception == exception

  test "toString method":
    let exception = newException(IOError, "Test error")
    let event = ConnectionErrorEvent(exception: exception)
    let expectedString = "ConnectionErrorEvent(exception: Test error)"
    check:
      event.toString() == expectedString

  test "Exception message is not null":
      let exception = newException(IOError, "Error message test")
      let event = ConnectionErrorEvent(exception: exception)
      check event.exception.msg != nil

  test "toString method with an empty error":
      let exception = newException(IOError, "")
      let event = ConnectionErrorEvent(exception: exception)
      let expectedString = "ConnectionErrorEvent(exception: )"
      check event.toString() == expectedString