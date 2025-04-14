nim
import unittest
import ../../src/bot_api/events/bullet_hit_wall_event

suite "BulletHitWallEvent":
  test "Test BulletHitWallEvent creation":
    let event = BulletHitWallEvent()
    check:
      event.type == "BulletHitWallEvent"
      
  test "Test BulletHitWallEvent toString":
    let event = BulletHitWallEvent()
    check:
      event.toString() == "BulletHitWallEvent"