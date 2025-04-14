nim
import unittest
import ../src/bot_api/i_bot

suite "IBot interface tests":
  test "IBot interface methods exist":
    # Create a dummy implementation of IBot for testing purposes
    type
      DummyBot* = ref object of IBot
        name*: string

    method getMyName*(bot: DummyBot): string {.base.} =
      return bot.name

    method onRoundStarted*(bot: DummyBot, roundNumber: int) {.base.} =
      discard

    method onRoundEnded*(bot: DummyBot, roundNumber: int, turnResults: seq[string]) {.base.} =
      discard

    method onGameStarted*(bot: DummyBot, gameSetup: string) {.base.} =
      discard

    method onGameEnded*(bot: DummyBot, gameResults: string) {.base.} =
      discard
    
    method onCustomEvent*(bot: DummyBot, event: string) {.base.} =
      discard

    method onBotDeath*(bot: DummyBot) {.base.} =
      discard
    
    method onDisconnected*(bot: DummyBot) {.base.} =
      discard

    let bot = DummyBot(name: "TestBot")

    check: bot.getMyName() == "TestBot"
    bot.onRoundStarted(1)
    bot.onRoundEnded(1, @["result1", "result2"])
    bot.onGameStarted("game setup")
    bot.onGameEnded("game results")
    bot.onCustomEvent("custom event")
    bot.onBotDeath()
    bot.onDisconnected()