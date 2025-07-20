## Test for network bot compilation and basic functionality
import unittest2
import ../src/bot_api/network_bot
import ../src/bot_api/bot_info
import ../src/bot_api/websocket_client

suite "Network Bot Tests":
  test "WebSocket client creation":
    let client = newWebSocketClient("ws://localhost:7654", "test-secret")
    check:
      client.serverUrl == "ws://localhost:7654"
      client.serverSecret == "test-secret"
      client.connected == false

  test "Network bot creation":
    let botInfo = newBotInfo(
      name = "TestNetworkBot",
      version = "1.0.0",
      authors = @["Test Author"],
      description = "Test bot for networking",
      homepage = "https://example.com",
      countryCodes = @["US"],
      gameTypes = @["classic"],
      platform = "Nim",
      programmingLang = "Nim"
    )
    
    let bot = newNetworkBot(
      botInfo = botInfo,
      serverUrl = "ws://localhost:7654",
      serverSecret = "test",
      debugMode = false  # Disable file logging in tests
    )
    
    check:
      bot != nil
      bot.getBotInfo().name == "TestNetworkBot"
      bot.client.serverUrl == "ws://localhost:7654"
      bot.debugMode == false

  test "Network bot logging":
    let botInfo = newBotInfo(
      name = "LogTestBot",
      version = "1.0.0",
      authors = @["Test Author"],
      description = "Test logging functionality",
      homepage = "https://example.com",
      countryCodes = @["US"],
      gameTypes = @["classic"],
      platform = "Nim",
      programmingLang = "Nim"
    )
    
    let bot = newNetworkBot(
      botInfo = botInfo,
      debugMode = false  # No file logging for test
    )
    
    # Test logging (should not crash)
    bot.log("Test message")
    check true  # If we get here, logging worked
