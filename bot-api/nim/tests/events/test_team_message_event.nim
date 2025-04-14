nim
import unittest
import ../../src/bot_api/events/team_message_event

suite "TeamMessageEvent Tests":
  test "Test TeamMessageEvent creation and getters":
    let message = "Hello Team!"
    let event = TeamMessageEvent(message: message)
    check event.message == message

  test "Test TeamMessageEvent setters":
    let initialMessage = "Initial Message"
    let newMessage = "New Message"
    var event = TeamMessageEvent(message: initialMessage)
    check event.message == initialMessage
    event.message = newMessage
    check event.message == newMessage