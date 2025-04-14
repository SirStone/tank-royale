nim
import unittest
import ../src/bot_api/bullet_state

suite "BulletState Tests":

  test "Test constructor and getters":
    let bulletState = BulletState(
      botId: 1,
      power: 2.0,
      x: 10.0,
      y: 20.0,
      direction: 90.0,
      speed: 5.0,
      tick: 100
    )
    check bulletState.botId == 1
    check bulletState.power == 2.0
    check bulletState.x == 10.0
    check bulletState.y == 20.0
    check bulletState.direction == 90.0
    check bulletState.speed == 5.0
    check bulletState.tick == 100

  test "Test setters":
      var bulletState = BulletState(
      botId: 1,
      power: 2.0,
      x: 10.0,
      y: 20.0,
      direction: 90.0,
      speed: 5.0,
      tick: 100
    )

      bulletState.botId = 2
      bulletState.power = 3.0
      bulletState.x = 15.0
      bulletState.y = 25.0
      bulletState.direction = 45.0
      bulletState.speed = 7.0
      bulletState.tick = 105

      check bulletState.botId == 2
      check bulletState.power == 3.0
      check bulletState.x == 15.0
      check bulletState.y == 25.0
      check bulletState.direction == 45.0
      check bulletState.speed == 7.0
      check bulletState.tick == 105