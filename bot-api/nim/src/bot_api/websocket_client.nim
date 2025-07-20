## WebSocket client for Tank Royale Bot API
## Handles connection to Tank Royale server

import ws, asyncdispatch, json, strformat
import ./bot_info

type
  WebSocketClient* = ref object
    ws: WebSocket
    serverUrl*: string
    serverSecret*: string
    connected*: bool
    onMessage*: proc(message: string) {.closure.}
    onConnected*: proc() {.closure.}
    onDisconnected*: proc() {.closure.}
    onError*: proc(error: string) {.closure.}

  BotHandshake = object
    `type`: string
    sessionId: string
    name: string
    version: string
    authors: seq[string]
    description: string
    homepage: string
    countryCodes: seq[string]
    gameTypes: seq[string]
    platform: string
    programmingLang: string
    initialPosition: JsonNode
    secret: string

proc newWebSocketClient*(serverUrl: string, serverSecret: string = ""): WebSocketClient =
  ## Create a new WebSocket client
  result = WebSocketClient(
    serverUrl: serverUrl,
    serverSecret: serverSecret,
    connected: false
  )

proc createBotHandshake(sessionId: string, botInfo: BotInfo, secret: string): BotHandshake =
  ## Create bot handshake message
  result = BotHandshake(
    `type`: "BotHandshake",
    sessionId: sessionId,
    name: botInfo.name,
    version: botInfo.version,
    authors: botInfo.authors,
    description: botInfo.description,
    homepage: botInfo.homepage,
    countryCodes: botInfo.countryCodes,
    gameTypes: botInfo.gameTypes,
    platform: botInfo.platform,
    programmingLang: botInfo.programmingLang,
    initialPosition: newJNull(),
    secret: secret
  )

proc connect*(client: WebSocketClient, botInfo: BotInfo): Future[void] {.async.} =
  ## Connect to the Tank Royale server
  try:
    echo &"[WebSocket] Connecting to {client.serverUrl}..."
    
    # Use the ws library's newWebSocket function for client connection
    client.ws = await newWebSocket(client.serverUrl)
    client.connected = true
    
    echo "[WebSocket] Connected successfully!"
    
    if client.onConnected != nil:
      client.onConnected()
    
    # Start message handling loop
    while client.connected and client.ws.readyState == Open:
      try:
        let message = await client.ws.receiveStrPacket()
        echo &"[WebSocket] Received: {message}"
        
        # Parse message to check type
        let jsonMsg = parseJson(message)
        if jsonMsg.hasKey("type"):
          let msgType = jsonMsg["type"].getStr()
          
          case msgType:
          of "ServerHandshake":
            # Respond with bot handshake
            let sessionId = jsonMsg["sessionId"].getStr()
            let handshake = createBotHandshake(sessionId, botInfo, client.serverSecret)
            let handshakeJson = $(%handshake)
            echo &"[WebSocket] Sending handshake: {handshakeJson}"
            await client.ws.send(handshakeJson)
          else:
            # Forward message to handler
            if client.onMessage != nil:
              client.onMessage(message)
      
      except WebSocketClosedError:
        echo "[WebSocket] Connection closed by server"
        break
      except WebSocketProtocolMismatchError:
        echo "[WebSocket] Protocol mismatch error"
        break
      except WebSocketError:
        echo &"[WebSocket] WebSocket error: {getCurrentExceptionMsg()}"
        break
      except CatchableError as e:
        echo &"[WebSocket] Error receiving message: {e.msg}"
        if client.onError != nil:
          client.onError(e.msg)
        break
    
    client.connected = false
    if client.onDisconnected != nil:
      client.onDisconnected()
      
  except CatchableError as e:
    echo &"[WebSocket] Connection failed: {e.msg}"
    client.connected = false
    if client.onError != nil:
      client.onError(e.msg)

proc send*(client: WebSocketClient, message: string): Future[void] {.async.} =
  ## Send a message to the server
  if client.connected and client.ws != nil and client.ws.readyState == Open:
    try:
      echo &"[WebSocket] Sending: {message}"
      await client.ws.send(message)
    except CatchableError as e:
      echo &"[WebSocket] Send error: {e.msg}"
      if client.onError != nil:
        client.onError(e.msg)
  else:
    echo "[WebSocket] Cannot send - not connected or connection not open"

proc disconnect*(client: WebSocketClient): Future[void] {.async.} =
  ## Disconnect from the server
  if client.connected and client.ws != nil:
    try:
      echo "[WebSocket] Disconnecting..."
      client.connected = false
      client.ws.close()
    except CatchableError as e:
      echo &"[WebSocket] Disconnect error: {e.msg}"
