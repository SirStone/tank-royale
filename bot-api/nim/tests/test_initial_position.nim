nim
import unittest
import ../src/bot_api/initial_position

suite "InitialPosition":
  test "Test InitialPosition constructor":
    let initialPosition = InitialPosition(x: 100, y: 200, direction: 90)
    check initialPosition.x == 100
    check initialPosition.y == 200
    check initialPosition.direction == 90

  test "Test InitialPosition copy constructor":
    let initialPosition1 = InitialPosition(x: 100, y: 200, direction: 90)
    let initialPosition2 = InitialPosition(initialPosition1)
    check initialPosition2.x == 100
    check initialPosition2.y == 200
    check initialPosition2.direction == 90

  test "Test InitialPosition equals method - equal":
    let initialPosition1 = InitialPosition(x: 100, y: 200, direction: 90)
    let initialPosition2 = InitialPosition(x: 100, y: 200, direction: 90)
    check initialPosition1 == initialPosition2

  test "Test InitialPosition equals method - not equal":
    let initialPosition1 = InitialPosition(x: 100, y: 200, direction: 90)
    let initialPosition2 = InitialPosition(x: 150, y: 200, direction: 90)
    check initialPosition1 != initialPosition2

  test "Test InitialPosition hash method - equal":
    let initialPosition1 = InitialPosition(x: 100, y: 200, direction: 90)
    let initialPosition2 = InitialPosition(x: 100, y: 200, direction: 90)
    check initialPosition1.hash == initialPosition2.hash

  test "Test InitialPosition hash method - not equal":
    let initialPosition1 = InitialPosition(x: 100, y: 200, direction: 90)
    let initialPosition2 = InitialPosition(x: 150, y: 200, direction: 90)
    check initialPosition1.hash != initialPosition2.hash