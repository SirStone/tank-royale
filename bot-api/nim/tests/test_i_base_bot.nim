nim
import unittest
import ../src/bot_api/i_base_bot

suite "IBaseBot Tests":
  var bot: IBaseBot

  setup:
    # Since IBaseBot is an interface, we need a concrete implementation for testing.
    # Let's create a dummy implementation here:
    type DummyBot = object of IBaseBot
    method getMyName*(self: DummyBot): string = "DummyBot"
    method setMyName*(self: DummyBot, name: string) = discard
    method initialize*(self: DummyBot) = discard
    method run*(self: DummyBot) = discard
    method close*(self: DummyBot) = discard
    method getOutputStream*(self: DummyBot): string = ""
    method getErrorStream*(self: DummyBot): string = ""
    bot = DummyBot()

  test "Test getMyName":
    check bot.getMyName() == "DummyBot"

  test "Test setMyName":
    bot.setMyName("NewName")
    # Since we use discard in the dummy implementation, we cannot test this

  test "Test initialize":
    bot.initialize()
    # Since we use discard in the dummy implementation, we cannot test this

  test "Test run":
    bot.run()
    # Since we use discard in the dummy implementation, we cannot test this

  test "Test close":
    bot.close()
    # Since we use discard in the dummy implementation, we cannot test this

  test "Test getOutputStream":
    check bot.getOutputStream() == ""

  test "Test getErrorStream":
    check bot.getErrorStream() == ""