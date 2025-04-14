nim
import unittest
import ../../src/bot_api/events/scanned_bot_event

suite "ScannedBotEvent":
  test "Constructor and Getters":
    let scannedBot = ScannedBotEvent(
      scannedBotId: 1,
      energy: 10.0,
      x: 100.0,
      y: 200.0,
      direction: 180.0,
      speed: 5.0,
      botTurn: 1
    )

    check scannedBot.scannedBotId == 1
    check scannedBot.energy == 10.0
    check scannedBot.x == 100.0
    check scannedBot.y == 200.0
    check scannedBot.direction == 180.0
    check scannedBot.speed == 5.0
    check scannedBot.botTurn == 1

  test "Default Constructor":
    let scannedBot = ScannedBotEvent()

    check scannedBot.scannedBotId == 0
    check scannedBot.energy == 0.0
    check scannedBot.x == 0.0
    check scannedBot.y == 0.0
    check scannedBot.direction == 0.0
    check scannedBot.speed == 0.0
    check scannedBot.botTurn == 0

  test "Setters":
    var scannedBot = ScannedBotEvent()
    
    scannedBot.scannedBotId = 2
    scannedBot.energy = 20.0
    scannedBot.x = 300.0
    scannedBot.y = 400.0
    scannedBot.direction = 90.0
    scannedBot.speed = 10.0
    scannedBot.botTurn = 2

    check scannedBot.scannedBotId == 2
    check scannedBot.energy == 20.0
    check scannedBot.x == 300.0
    check scannedBot.y == 400.0
    check scannedBot.direction == 90.0
    check scannedBot.speed == 10.0
    check scannedBot.botTurn == 2