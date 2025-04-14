nim
import unittest
import ../src/bot_api/events/bot_death_event

suite "BotDeathEvent":
  test "Constructor":
    let botDeathEvent = BotDeathEvent()
    check botDeathEvent.priority == 0

  test "getPriority":
    let botDeathEvent = BotDeathEvent()
    check botDeathEvent.getPriority() == 0

  test "setPriority":
    let botDeathEvent = BotDeathEvent()
    botDeathEvent.setPriority(10)
    check botDeathEvent.getPriority() == 10

  test "Default Constructor":
      let event = BotDeathEvent()
      check event.priority == 0

  test "Priority Constructor":
      let event = BotDeathEvent(priority = 5)
      check event.priority == 5

  test "getPriority with default value":
      let event = BotDeathEvent()
      check event.getPriority() == 0

  test "getPriority with set value":
      let event = BotDeathEvent(priority = 5)
      check event.getPriority() == 5

  test "setPriority":
    var event = BotDeathEvent()
    event.setPriority(7)
    check event.priority == 7
    check event.getPriority() == 7