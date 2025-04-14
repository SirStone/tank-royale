nim
import unittest
import ../../src/bot_api/events/round_ended_event

suite "RoundEndedEvent":

  test "Test RoundEndedEvent creation":
    let event = RoundEndedEvent()
    check:
      event.is Event

  test "Test RoundEndedEvent properties":
      let event = RoundEndedEvent()
      check:
          event.roundNumber == 0

  test "Test RoundEndedEvent roundNumber setter and getter":
      let event = RoundEndedEvent()
      event.roundNumber = 5
      check:
          event.roundNumber == 5