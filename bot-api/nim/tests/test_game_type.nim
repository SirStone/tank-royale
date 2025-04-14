nim
import unittest
import ../src/bot_api/game_type

suite "GameType":
  test "Test GameType values":
    check GameType.CLASSIC == GameType.CLASSIC
    check GameType.MELEE == GameType.MELEE
    check GameType.ONE_VS_ONE == GameType.ONE_VS_ONE
    check GameType.SURVIVAL == GameType.SURVIVAL
    check GameType.TANK == GameType.TANK

  test "Test GameType string values":
    check $GameType.CLASSIC == "CLASSIC"
    check $GameType.MELEE == "MELEE"
    check $GameType.ONE_VS_ONE == "ONE_VS_ONE"
    check $GameType.SURVIVAL == "SURVIVAL"
    check $GameType.TANK == "TANK"

  test "Test GameType from string values":
    check GameType.fromString("CLASSIC") == GameType.CLASSIC
    check GameType.fromString("MELEE") == GameType.MELEE
    check GameType.fromString("ONE_VS_ONE") == GameType.ONE_VS_ONE
    check GameType.fromString("SURVIVAL") == GameType.SURVIVAL
    check GameType.fromString("TANK") == GameType.TANK

  test "Test GameType from string values incorrect":
    try:
      discard GameType.fromString("INVALID")
      failed("Expected an exception")
    except ValueError:
      check true