nim
import unittest
import ../../src/bot_api/events/game_ended_event

suite "GameEndedEvent":
  test "Constructor and Getters":
    let gameEndedEvent = GameEndedEvent()
    check gameEndedEvent.priority == DefaultEventPriority.NORMAL

  test "ToString":
    let gameEndedEvent = GameEndedEvent()
    let expectedString = "GameEndedEvent(priority: Normal)"
    check $gameEndedEvent == expectedString

  test "Priority":
    let gameEndedEvent = GameEndedEvent()
    check gameEndedEvent.priority == DefaultEventPriority.NORMAL
    gameEndedEvent.priority = DefaultEventPriority.VERY_HIGH
    check gameEndedEvent.priority == DefaultEventPriority.VERY_HIGH
    gameEndedEvent.priority = DefaultEventPriority.ABSOLUTE
    check gameEndedEvent.priority == DefaultEventPriority.ABSOLUTE
    gameEndedEvent.priority = DefaultEventPriority.LOW
    check gameEndedEvent.priority == DefaultEventPriority.LOW
    gameEndedEvent.priority = DefaultEventPriority.VERY_LOW
    check gameEndedEvent.priority == DefaultEventPriority.VERY_LOW
    gameEndedEvent.priority = DefaultEventPriority.HIGH
    check gameEndedEvent.priority == DefaultEventPriority.HIGH