## Minimal test for network bot compilation
import unittest2
import ../src/bot_api/websocket_client
import ../src/bot_api/bot_info

suite "Network Bot Basic Tests":
  test "WebSocket client creation":
    let client = newWebSocketClient("ws://localhost:7654", "test-secret")
    check:
      client.serverUrl == "ws://localhost:7654"
      client.serverSecret == "test-secret"
      client.connected == false

  test "BotInfo creation for networking":
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
    
    check:
      botInfo.name == "TestNetworkBot"
      botInfo.version == "1.0.0"
