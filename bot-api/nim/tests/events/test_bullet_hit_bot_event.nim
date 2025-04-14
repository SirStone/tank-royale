nim
import unittest
import ../../src/bot_api/events/bullet_hit_bot_event
import ../../src/bot_api/bot_info
import ../../src/bot_api/bot_state
import ../../src/bot_api/bullet_state

suite "BulletHitBotEvent Tests":
  test "Constructor and Getters":
    let botInfo = BotInfo(id: 1, name: "Bot1", score: 0, energy: 100.0)
    let botState = BotState(x: 100, y: 200, direction: 90.0, energy: 90.0, velocity: 5.0, turnRemaining: 0, radarDirection: 0.0, radarSweep: 0.0, gunDirection: 0.0)
    let bulletState = BulletState(x: 50.0, y: 50.0, direction: 45.0, power: 2.0, velocity: 10.0, ownerId: 2, bulletId: 123)
    
    let event = BulletHitBotEvent(victim: botInfo, victimState: botState, bullet: bulletState)

    check:
      event.victim.id == 1
      event.victim.name == "Bot1"
      event.victim.score == 0
      event.victim.energy == 100.0
      event.victimState.x == 100
      event.victimState.y == 200
      event.victimState.direction == 90.0
      event.victimState.energy == 90.0
      event.victimState.velocity == 5.0
      event.victimState.turnRemaining == 0
      event.victimState.radarDirection == 0.0
      event.victimState.radarSweep == 0.0
      event.victimState.gunDirection == 0.0
      event.bullet.x == 50.0
      event.bullet.y == 50.0
      event.bullet.direction == 45.0
      event.bullet.power == 2.0
      event.bullet.velocity == 10.0
      event.bullet.ownerId == 2
      event.bullet.bulletId == 123

  test "toString":
    let botInfo = BotInfo(id: 1, name: "Bot1", score: 0, energy: 100.0)
    let botState = BotState(x: 100, y: 200, direction: 90.0, energy: 90.0, velocity: 5.0, turnRemaining: 0, radarDirection: 0.0, radarSweep: 0.0, gunDirection: 0.0)
    let bulletState = BulletState(x: 50.0, y: 50.0, direction: 45.0, power: 2.0, velocity: 10.0, ownerId: 2, bulletId: 123)
    
    let event = BulletHitBotEvent(victim: botInfo, victimState: botState, bullet: bulletState)
    let expectedString = "BulletHitBotEvent(victim=BotInfo(id=1, name=Bot1, score=0, energy=100.0), victimState=BotState(x=100.0, y=200.0, direction=90.0, energy=90.0, velocity=5.0, turnRemaining=0, radarDirection=0.0, radarSweep=0.0, gunDirection=0.0), bullet=BulletState(x=50.0, y=50.0, direction=45.0, power=2.0, velocity=10.0, ownerId=2, bulletId=123))"
    check event.toString == expectedString