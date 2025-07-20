import unittest
import ../src/bot_api/constants

suite "Constants Tests":
  test "Test MAX_FIREPOWER":
    check MAX_FIREPOWER == 3.0

  test "Test MIN_FIREPOWER":
    check MIN_FIREPOWER == 0.1

  test "Test MAX_TURN_RATE":
    check MAX_TURN_RATE == 10

  test "Test MAX_GUN_TURN_RATE":
    check MAX_GUN_TURN_RATE == 20

  test "Test MAX_RADAR_TURN_RATE":
    check MAX_RADAR_TURN_RATE == 45

  test "Test MAX_SPEED":
    check MAX_SPEED == 8

  test "Test SCAN_RADIUS":
    check SCAN_RADIUS == 1200

  test "Test BOUNDING_CIRCLE_RADIUS":
    check BOUNDING_CIRCLE_RADIUS == 18

  test "Test ACCELERATION":
    check ACCELERATION == 1

  test "Test DECELERATION":
    check DECELERATION == -2

  test "Test MAX_ENERGY":
    check MAX_ENERGY == 100.0

  test "Test DEFAULT_START_ENERGY":
    check DEFAULT_START_ENERGY == 100.0

  test "Test MIN_BULLET_SPEED":
    check MIN_BULLET_SPEED == 11.0

  test "Test MAX_BULLET_SPEED":
    check MAX_BULLET_SPEED == 19.7
