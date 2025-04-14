nim
import unittest
import ../../src/bot_api/events/game_started_event

suite "GameStartedEvent":
  test "Constructor and Getters":
    let gameStartedEvent = GameStartedEvent()
    check gameStartedEvent.isNil == false

  test "Serialization and Deserialization (basic)":
    let gameStartedEvent = GameStartedEvent()
    let serialized = gameStartedEvent.toJson
    let deserialized = GameStartedEvent.fromJson(serialized)
    check deserialized.isNil == false

  test "Serialization and Deserialization (with data)":
    let gameStartedEvent = GameStartedEvent()
    let serialized = gameStartedEvent.toJson
    let deserialized = GameStartedEvent.fromJson(serialized)
    check deserialized.isNil == false