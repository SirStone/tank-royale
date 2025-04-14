nim
import unittest
import ../src/bot_api/droid

suite "Droid Tests":
  test "Test Droid Constructor and Getters":
    let droid = Droid(id: 1, name: "TestDroid", energy: 100.0, x: 10.0, y: 20.0, direction: 90.0, gunDirection: 45.0, radarDirection: 0.0, speed: 5.0, gunHeat: 0.0, gunCoolRate: 0.1, scannedBots: @[])
    check droid.id == 1
    check droid.name == "TestDroid"
    check droid.energy == 100.0
    check droid.x == 10.0
    check droid.y == 20.0
    check droid.direction == 90.0
    check droid.gunDirection == 45.0
    check droid.radarDirection == 0.0
    check droid.speed == 5.0
    check droid.gunHeat == 0.0
    check droid.gunCoolRate == 0.1
    check droid.scannedBots == @[]

  test "Test Droid Setters":
    var droid = Droid(id: 1, name: "TestDroid", energy: 100.0, x: 10.0, y: 20.0, direction: 90.0, gunDirection: 45.0, radarDirection: 0.0, speed: 5.0, gunHeat: 0.0, gunCoolRate: 0.1, scannedBots: @[])
    droid.energy = 50.0
    droid.x = 15.0
    droid.y = 25.0
    droid.direction = 180.0
    droid.gunDirection = 90.0
    droid.radarDirection = 10.0
    droid.speed = 2.5
    droid.gunHeat = 0.5
    droid.gunCoolRate = 0.2
    droid.scannedBots = @[1,2]
    check droid.energy == 50.0
    check droid.x == 15.0
    check droid.y == 25.0
    check droid.direction == 180.0
    check droid.gunDirection == 90.0
    check droid.radarDirection == 10.0
    check droid.speed == 2.5
    check droid.gunHeat == 0.5
    check droid.gunCoolRate == 0.2
    check droid.scannedBots == @[1, 2]