nim
import unittest
import ../../src/bot_api/events/hit_by_bullet_event

suite "HitByBulletEvent":
  test "Test constructor":
    let hitByBulletEvent = HitByBulletEvent(victimName: "victim", bullet: nil)
    check hitByBulletEvent.victimName == "victim"
    check hitByBulletEvent.bullet == nil

  test "Test victimName setter and getter":
    var hitByBulletEvent = HitByBulletEvent(victimName: "", bullet: nil)
    hitByBulletEvent.victimName = "NewVictim"
    check hitByBulletEvent.victimName == "NewVictim"
  
  test "Test bullet setter and getter":
    var hitByBulletEvent = HitByBulletEvent(victimName: "", bullet: nil)
    hitByBulletEvent.bullet = nil
    check hitByBulletEvent.bullet == nil