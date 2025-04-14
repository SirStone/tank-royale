nim
import unittest
import ../src/bot_api/bot

suite "Bot Tests":
  var bot: Bot

  setup:
    bot = newBot()

  test "Test getMyBotId":
    # Assuming you have a way to set the bot ID internally
    # For example, a setBotId method in the Bot class
    # bot.setBotId(123)
    # check bot.getMyBotId() == 123
    discard

  test "Test getGameSetup":
    # Similar to getMyBotId, you might need a way to set the game setup
    # bot.setGameSetup(someGameSetupObject)
    # check bot.getGameSetup() == someGameSetupObject
    discard

  test "Test getBotInfo":
    #  bot.setBotInfo(someBotInfoObject)
    #  check bot.getBotInfo() == someBotInfoObject
    discard
  
  test "Test getEvents":
    # add some events to test
    # Check if events are returned correctly
    discard

  test "Test getMyBotName":
    # Assuming you have a setMyBotName method
    # bot.setMyBotName("TestBot")
    # check bot.getMyBotName() == "TestBot"
    discard

  test "Test startNewRound":
    # Test the behavior of startNewRound
    discard
    
  test "Test getRoundNumber":
    # bot.setRoundNumber(1)
    # check bot.getRoundNumber() == 1
    discard
  
  test "Test getEnemies":
    # Assuming you have a way to add enemies
    # bot.addEnemy(someEnemyBotInfoObject)
    # check contains(bot.getEnemies(), someEnemyBotInfoObject)
    discard

  test "Test getTeammates":
    # Similar to enemies
    # bot.addTeammate(someTeammateBotInfoObject)
    # check contains(bot.getTeammates(), someTeammateBotInfoObject)
    discard
  
  test "Test onEvent":
    # Test the event dispatch
    discard
  
  test "Test addEventListener":
    # test if it add correctly to the list
    discard
  
  test "Test addCondition":
    # test if it add correctly to the list
    discard
  
  test "Test isAlive":
    # test if the bot is alive
    discard
  
  test "Test isDead":
    # test if the bot is dead
    discard

  test "Test getTurnNumber":
    # bot.setTurnNumber(1)
    # check bot.getTurnNumber() == 1
    discard

  test "Test getBotState":
    # bot.setBotState(someBotStateObject)
    # check bot.getBotState() == someBotStateObject
    discard
  
  test "Test getCustomEvents":
    # add some custom events to test
    # Check if events are returned correctly
    discard

  test "Test clearEvents":
    # add some events and then clear it to test
    discard

  test "Test clearCustomEvents":
    # add some custom events and then clear it to test
    discard