nim
import unittest
import ../../src/bot_api/events/hit_bot_event

suite "HitBotEvent":

  test "constructor":
    let hitBotEvent = HitBotEvent()
    check hitBotEvent.victim == ""
    check hitBotEvent.x == 0.0
    check hitBotEvent.y == 0.0
    check hitBotEvent.energy == 0.0
    check hitBotEvent.direction == 0.0
    check hitBotEvent.playerId == 0

  test "setters and getters":
    let hitBotEvent = HitBotEvent()

    hitBotEvent.victim = "BotName"
    check hitBotEvent.victim == "BotName"

    hitBotEvent.x = 10.0
    check hitBotEvent.x == 10.0

    hitBotEvent.y = 20.0
    check hitBotEvent.y == 20.0

    hitBotEvent.energy = 100.0
    check hitBotEvent.energy == 100.0

    hitBotEvent.direction = 90.0
    check hitBotEvent.direction == 90.0

    hitBotEvent.playerId = 123
    check hitBotEvent.playerId == 123