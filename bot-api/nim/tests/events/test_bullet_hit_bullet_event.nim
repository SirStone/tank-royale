nim
import unittest
import ../../src/bot_api/events/bullet_hit_bullet_event

suite "BulletHitBulletEvent":
  test "Test BulletHitBulletEvent creation":
    let event = BulletHitBulletEvent(victimId: 1, bulletId: 2, x: 10, y: 20)
    check:
      event.victimId == 1
      event.bulletId == 2
      event.x == 10
      event.y == 20

  test "Test BulletHitBulletEvent setters":
    let event = BulletHitBulletEvent(victimId: 0, bulletId: 0, x: 0, y: 0)
    event.victimId = 3
    event.bulletId = 4
    event.x = 30
    event.y = 40
    check:
      event.victimId == 3
      event.bulletId == 4
      event.x == 30
      event.y == 40

  test "Test BulletHitBulletEvent getters":
    let event = BulletHitBulletEvent(victimId: 5, bulletId: 6, x: 50, y: 60)
    check:
      event.victimId == 5
      event.bulletId == 6
      event.x == 50
      event.y == 60