nim
import unittest
import ../src/bot_api/bot_results

suite "BotResults Tests":

  test "Test constructor and getters":
    let botResults = newBotResults(100, 50, 25, 10, 5)
    check botResults.numberOfRounds == 100
    check botResults.totalScore == 50
    check botResults.rank == 25
    check botResults.survival == 10
    check botResults.lastSurvivorBonus == 5

  test "Test setter for numberOfRounds":
    var botResults = newBotResults(100, 50, 25, 10, 5)
    botResults.numberOfRounds = 200
    check botResults.numberOfRounds == 200

  test "Test setter for totalScore":
    var botResults = newBotResults(100, 50, 25, 10, 5)
    botResults.totalScore = 100
    check botResults.totalScore == 100

  test "Test setter for rank":
    var botResults = newBotResults(100, 50, 25, 10, 5)
    botResults.rank = 1
    check botResults.rank == 1
    
  test "Test setter for survival":
    var botResults = newBotResults(100, 50, 25, 10, 5)
    botResults.survival = 1
    check botResults.survival == 1
    
  test "Test setter for lastSurvivorBonus":
    var botResults = newBotResults(100, 50, 25, 10, 5)
    botResults.lastSurvivorBonus = 1
    check botResults.lastSurvivorBonus == 1