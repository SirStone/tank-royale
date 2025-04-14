nim
import unittest
import ../../src/bot_api/events/hit_wall_event

suite "HitWallEvent":

  test "Test HitWallEvent creation":
    let hitWallEvent = HitWallEvent()
    check:
      hitWallEvent != nil

  test "Test getTurn method":
    let hitWallEvent = HitWallEvent()
    check:
      hitWallEvent.getTurn() == 0
      
  test "Test setTurn method":
    let hitWallEvent = HitWallEvent()
    hitWallEvent.setTurn(10)
    check:
      hitWallEvent.getTurn() == 10
      
  test "Test toString method":
    let hitWallEvent = HitWallEvent()
    hitWallEvent.setTurn(10)
    check:
      hitWallEvent.toString().contains("HitWallEvent")
      hitWallEvent.toString().contains("10")