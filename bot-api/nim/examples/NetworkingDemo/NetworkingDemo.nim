## Simple demonstration of networking functionality
## This shows the WebSocket client working without the full bot complexity

import asyncdispatch
import strformat
import bot_api/websocket_client
import bot_api/bot_info

proc demoNetworking(): Future[void] {.async.} =
  echo "=== Tank Royale Nim Bot - Networking Demo ==="
  echo "This demonstrates the WebSocket client functionality"
  echo ""
  
  # Create bot info
  let botInfo = newBotInfo(
    name = "DemoBot",
    version = "1.0.0",
    authors = @["Nim Developer"],
    description = "Demo bot for networking test",
    homepage = "https://github.com/nim-lang/tank-royale-nim",
    countryCodes = @["US"],
    gameTypes = @["classic"],
    platform = "Nim",
    programmingLang = "Nim"
  )
  
  echo &"Bot Info: {botInfo.name} v{botInfo.version}"
  
  # Create WebSocket client
  let client = newWebSocketClient("ws://localhost:7654", "")
  echo &"WebSocket client created for: {client.serverUrl}"
  
  # Set up event handlers
  client.onConnected = proc() =
    echo "Connected to Tank Royale server!"
  
  client.onDisconnected = proc() =
    echo "Disconnected from Tank Royale server"
    
  client.onError = proc(error: string) =
    echo &"Connection error: {error}"
    
  client.onMessage = proc(message: string) =
    echo &"Received message: {message[0..min(100, message.len-1)]}..."
  
  echo ""
  echo "Demo completed - WebSocket client is ready for use"
  echo "To test with a real server:"
  echo "1. Start Tank Royale server on localhost:7654"
  echo "2. Use the full NetworkBot implementation"
  echo "3. Run: nimble demo"

when isMainModule:
  waitFor demoNetworking()
