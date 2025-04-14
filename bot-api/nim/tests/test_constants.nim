nim
import unittest
import ../src/bot_api/constants

suite "Constants Tests":

  test "Test MAX_BULLET_POWER":
    check constants.MAX_BULLET_POWER == 3

  test "Test MIN_BULLET_POWER":
    check constants.MIN_BULLET_POWER == 0.1

  test "Test BULLET_HIT_DAMAGE":
    check constants.BULLET_HIT_DAMAGE == 10

  test "Test MAX_BOT_ENERGY":
    check constants.MAX_BOT_ENERGY == 100

  test "Test MAX_NUMBER_OF_ROUNDS":
    check constants.MAX_NUMBER_OF_ROUNDS == 10

  test "Test MAX_NUMBER_OF_TICKS_PER_ROUND":
    check constants.MAX_NUMBER_OF_TICKS_PER_ROUND == 500

  test "Test DEFAULT_WIDTH":
    check constants.DEFAULT_WIDTH == 800

  test "Test DEFAULT_HEIGHT":
    check constants.DEFAULT_HEIGHT == 600

  test "Test MIN_SPEED":
    check constants.MIN_SPEED == 0.0

  test "Test MAX_SPEED":
    check constants.MAX_SPEED == 8.0

  test "Test TURN_RATE":
    check constants.TURN_RATE == 10.0

  test "Test MAX_RADAR_SWEEP_ANGLE":
    check constants.MAX_RADAR_SWEEP_ANGLE == 45.0

  test "Test SCAN_RADIUS":
    check constants.SCAN_RADIUS == 120.0

  test "Test BORDER_BUFFER":
    check constants.BORDER_BUFFER == 100.0