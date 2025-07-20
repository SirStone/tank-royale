import unittest
import ../src/bot_api/bot_info

suite "BotInfo Tests":
  test "BotInfo Constructor with minimal fields":
    let botInfo = newBotInfo("TestBot", "1.0", @["Test Author"])
    check:
      botInfo.name == "TestBot"
      botInfo.version == "1.0"
      botInfo.authors == @["Test Author"]
      botInfo.platform == "Nim"
      botInfo.programmingLang == "Nim"

  test "BotInfo Constructor with all fields":
    let botInfo = newBotInfo("TestBot", "2.0", @["Author1", "Author2"], 
                            "Test description", "https://example.com", 
                            @["us", "gb"], @["classic", "melee"], 
                            "Nim Platform", "Nim Language")
    check:
      botInfo.name == "TestBot"
      botInfo.version == "2.0"
      botInfo.authors == @["Author1", "Author2"]
      botInfo.description == "Test description"
      botInfo.homepage == "https://example.com"
      botInfo.countryCodes == @["us", "gb"]
      botInfo.gameTypes == @["classic", "melee"]
      botInfo.platform == "Nim Platform"
      botInfo.programmingLang == "Nim Language"
