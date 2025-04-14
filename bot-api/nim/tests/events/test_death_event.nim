nim
import unittest
import ../../src/bot_api/events/death_event

suite "DeathEvent":
  test "DeathEvent creation and getters":
    let event = DeathEvent(time = 1000, turn = 10)
    check:
      event.time == 1000
      event.turn == 10