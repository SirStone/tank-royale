nim
import unittest
import ../../src/bot_api/events/bullet_fired_event

suite "BulletFiredEvent Tests":
  test "Test BulletFiredEvent creation":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.bulletId == 1
      bulletFiredEvent.ownerId == 2
      bulletFiredEvent.x == 10
      bulletFiredEvent.y == 20
      bulletFiredEvent.direction == 30.0
      bulletFiredEvent.power == 1.0
      bulletFiredEvent.speed == 5.0
      bulletFiredEvent.startTick == 100

  test "Test BulletFiredEvent toString":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    let expectedString = "BulletFiredEvent(bulletId=1, ownerId=2, x=10, y=20, direction=30.0, power=1.0, speed=5.0, startTick=100)"
    check:
      $bulletFiredEvent == expectedString

  test "Test BulletFiredEvent getBulletId":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.bulletId == 1

  test "Test BulletFiredEvent getOwnerId":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.ownerId == 2

  test "Test BulletFiredEvent getX":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.x == 10

  test "Test BulletFiredEvent getY":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.y == 20

  test "Test BulletFiredEvent getDirection":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.direction == 30.0
      
  test "Test BulletFiredEvent getPower":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.power == 1.0

  test "Test BulletFiredEvent getSpeed":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.speed == 5.0

  test "Test BulletFiredEvent getStartTick":
    let bulletFiredEvent = BulletFiredEvent(
      bulletId: 1,
      ownerId: 2,
      x: 10,
      y: 20,
      direction: 30.0,
      power: 1.0,
      speed: 5.0,
      startTick: 100
    )
    check:
      bulletFiredEvent.startTick == 100