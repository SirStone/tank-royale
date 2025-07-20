## Network-enabled bot that can connect to Tank Royale server
## Extends the base Bot with networking capabilities

import asyncdispatch, json, times, strformat, strutils, random
import ./bot
import ./base_bot
import ./bot_info
import ./websocket_client
import ./bot_state
import ./bullet_state
import ./constants

type
  NetworkBot* = ref object of Bot
    client: WebSocketClient
    isRunning: bool
    currentTick: int
    gameStarted: bool
    debugMode*: bool
    logFile*: File

  BotIntent = object
    `type`: string
    targetSpeed: float
    turnRate: float
    gunTurnRate: float
    radarTurnRate: float
    firepower: float
    adjustGunForBodyTurn: bool
    adjustRadarForGunTurn: bool
    adjustRadarForBodyTurn: bool
    rescan: bool
    bodyColor: string
    turretColor: string
    radarColor: string
    bulletColor: string
    scanColor: string
    stdOut: string
    stdErr: string

proc log*(bot: NetworkBot, message: string) =
  ## Log a message with timestamp
  let now = times.now()
  let timestamp = $now.hour & ":" & $now.minute & ":" & $now.second
  let logMsg = &"[{timestamp}] {message}"
  
  echo logMsg
  if bot.debugMode and bot.logFile != nil:
    bot.logFile.writeLine(logMsg)
    bot.logFile.flushFile()

proc newNetworkBot*(botInfo: BotInfo, serverUrl: string = "ws://localhost:7654", serverSecret: string = "", debugMode: bool = true): NetworkBot =
  ## Create a new network-enabled bot
  result = cast[NetworkBot](newBot(botInfo))
  result.client = newWebSocketClient(serverUrl, serverSecret)
  result.isRunning = false
  result.currentTick = 0
  result.gameStarted = false
  result.debugMode = debugMode
  
  if debugMode:
    let now = times.now()
    let timeStr = $now.year & "-" & $now.month & "-" & $now.monthday & "-" & $now.hour & "-" & $now.minute & "-" & $now.second
    let logFileName = &"bot_log_{botInfo.name}_{timeStr}.txt"
    result.logFile = open(logFileName, fmWrite)
    result.log(&"=== Bot Debug Log Started: {now} ===")

proc getServerUrl*(bot: NetworkBot): string =
  ## Get the server URL for this network bot
  return bot.client.serverUrl

proc createBotIntent(bot: NetworkBot): BotIntent =
  ## Create bot intent message from current bot state
  result = BotIntent(
    `type`: "BotIntent",
    targetSpeed: 0.0,  # Placeholder - would get from bot state
    turnRate: 0.0,     # Placeholder - would get from bot state
    gunTurnRate: 0.0,  # Placeholder - would get from bot state
    radarTurnRate: 0.0, # Placeholder - would get from bot state
    firepower: 0.0,    # Placeholder - would get from bot state
    adjustGunForBodyTurn: false,
    adjustRadarForGunTurn: false,
    adjustRadarForBodyTurn: false,
    rescan: false,
    bodyColor: "#0000FF",      # Blue
    turretColor: "#00FF00",    # Green  
    radarColor: "#FF0000",     # Red
    bulletColor: "#FFFF00",    # Yellow
    scanColor: "#FF00FF",      # Magenta
    stdOut: "",
    stdErr: ""
  )
  ## Create bot intent message from current bot state
  result = BotIntent(
    `type`: "BotIntent",
    targetSpeed: 0.0,  # Placeholder - would get from bot state
    turnRate: 0.0,     # Placeholder - would get from bot state
    gunTurnRate: 0.0,  # Placeholder - would get from bot state
    radarTurnRate: 0.0, # Placeholder - would get from bot state
    firepower: 0.0,    # Placeholder - would get from bot state
    adjustGunForBodyTurn: false,
    adjustRadarForGunTurn: false,
    adjustRadarForBodyTurn: false,
    rescan: false,
    bodyColor: "#0000FF",      # Blue
    turretColor: "#00FF00",    # Green  
    radarColor: "#FF0000",     # Red
    bulletColor: "#FFFF00",    # Yellow
    scanColor: "#FF00FF",      # Magenta
    stdOut: "",
    stdErr: ""
  )

proc onServerMessage(bot: NetworkBot, message: string) =
  ## Handle messages from the Tank Royale server
  try:
    let jsonMsg = parseJson(message)
    let msgType = jsonMsg["type"].getStr()
    
    bot.log(&"Received {msgType}")
    
    case msgType:
    of "GameStartedEventForBot":
      bot.gameStarted = true
      let myId = jsonMsg["myId"].getInt()
      bot.log(&"Game started! My ID: {myId}")
      
      # Send ready signal
      let readyMsg = """{"type": "BotReady"}"""
      asyncCheck bot.client.send(readyMsg)
      bot.log("Sent BotReady")
      
    of "RoundStartedEvent":
      let roundNumber = jsonMsg["roundNumber"].getInt()
      bot.log(&"Round {roundNumber} started!")
      
    of "TickEventForBot":
      bot.currentTick = jsonMsg["turnNumber"].getInt()
      
      # Parse bot state
      if jsonMsg.hasKey("botState"):
        let botStateJson = jsonMsg["botState"]
        bot.log(&"Turn {bot.currentTick}: Energy={botStateJson[\"energy\"].getFloat():.1f}, " &
                &"X={botStateJson[\"x\"].getFloat():.1f}, Y={botStateJson[\"y\"].getFloat():.1f}, " &
                &"Direction={botStateJson[\"direction\"].getFloat():.1f}°")
      
      # Parse enemy bots if any
      if jsonMsg.hasKey("enemyBots") and jsonMsg["enemyBots"].len > 0:
        for enemy in jsonMsg["enemyBots"]:
          let enemyId = enemy["id"].getInt()
          let enemyX = enemy["x"].getFloat()
          let enemyY = enemy["y"].getFloat()
          let enemyEnergy = enemy["energy"].getFloat()
          bot.log(&"  Enemy {enemyId}: Energy={enemyEnergy:.1f}, X={enemyX:.1f}, Y={enemyY:.1f}")
      
      # Parse bullet states
      if jsonMsg.hasKey("bulletStates") and jsonMsg["bulletStates"].len > 0:
        for bullet in jsonMsg["bulletStates"]:
          let bulletId = bullet["bulletId"].getInt()
          let bulletX = bullet["x"].getFloat()
          let bulletY = bullet["y"].getFloat()
          bot.log(&"  Bullet {bulletId}: X={bulletX:.1f}, Y={bulletY:.1f}")
      
      # Call bot's run method to determine next actions
      bot.run()
      
      # Send bot intent
      let intent = bot.createBotIntent()
      let intentJson = $(%intent)
      asyncCheck bot.client.send(intentJson)
      
      # Log the actions we're taking
      var actions: seq[string] = @[]
      if intent.targetSpeed != 0: actions.add(&"Speed={intent.targetSpeed:.1f}")
      if intent.turnRate != 0: actions.add(&"Turn={intent.turnRate:.1f}°")
      if intent.gunTurnRate != 0: actions.add(&"GunTurn={intent.gunTurnRate:.1f}°")
      if intent.radarTurnRate != 0: actions.add(&"RadarTurn={intent.radarTurnRate:.1f}°")
      if intent.firepower > 0: actions.add(&"Fire={intent.firepower:.1f}")
      
      if actions.len > 0:
        bot.log(&"  Actions: {actions.join(\", \")}")
      else:
        bot.log("  Actions: None (idle)")
      
    of "RoundEndedEventForBot":
      let roundNumber = jsonMsg["roundNumber"].getInt()
      if jsonMsg.hasKey("results"):
        let results = jsonMsg["results"]
        let rank = results["rank"].getInt()
        let score = results["totalScore"].getFloat()
        bot.log(&"Round {roundNumber} ended! Rank: {rank}, Score: {score:.1f}")
      
    of "GameEndedEventForBot":
      let numRounds = jsonMsg["numberOfRounds"].getInt()
      bot.log(&"Game ended after {numRounds} rounds!")
      bot.isRunning = false
      
    of "BotHitWallEvent":
      bot.log("COLLISION: Hit wall!")
      
    of "BulletHitBotEvent":
      let victimId = jsonMsg["victimId"].getInt()
      let damage = jsonMsg["damage"].getFloat()
      bot.log(&"COMBAT: Bullet hit bot {victimId} for {damage:.1f} damage!")
      
    of "BotHitBotEvent":
      let victimId = jsonMsg["victimId"].getInt()
      let damage = jsonMsg["damage"].getFloat()
      bot.log(&"COLLISION: Rammed bot {victimId} for {damage:.1f} damage!")
      
    of "BulletFiredEvent":
      let bulletId = jsonMsg["bullet"]["bulletId"].getInt()
      bot.log(&"WEAPON: Fired bullet {bulletId}")
      
    of "SkippedTurnEvent":
      bot.log("WARNING: Skipped turn (too slow)!")
      
    else:
      bot.log(&"Unhandled message type: {msgType}")
      
  except CatchableError as e:
    bot.log(&"Error parsing server message: {e.msg}")

proc onConnected(bot: NetworkBot) =
  ## Called when connected to server
  bot.log("Connected to Tank Royale server!")

proc onDisconnected(bot: NetworkBot) =
  ## Called when disconnected from server  
  bot.log("Disconnected from Tank Royale server")
  bot.isRunning = false

proc onError(bot: NetworkBot, error: string) =
  ## Called when connection error occurs
  bot.log(&"Connection error: {error}")
  bot.isRunning = false

proc start*(bot: NetworkBot): Future[void] {.async.} =
  ## Start the bot and connect to server
  bot.isRunning = true
  
  # Get bot info before setting up handlers
  let botInfo = cast[BaseBot](bot).getBotInfo()
  
  # Set up event handlers
  bot.client.onMessage = proc(msg: string) = bot.onServerMessage(msg)
  bot.client.onConnected = proc() = bot.onConnected()
  bot.client.onDisconnected = proc() = bot.onDisconnected()
  bot.client.onError = proc(err: string) = bot.onError(err)
  
  bot.log(&"Starting bot: {botInfo.name}")
  bot.log(&"Server URL: {bot.getServerUrl()}")
  
  # Connect to server
  await bot.client.connect(botInfo)
  
  # Wait for game to end
  while bot.isRunning:
    await sleepAsync(100)
  
  # Cleanup
  await bot.client.disconnect()
  if bot.debugMode and bot.logFile != nil:
    bot.log("=== Bot Debug Log Ended ===")
    bot.logFile.close()

# Override default go() to do nothing (networking handles turn management)
method go*(bot: NetworkBot) =
  ## In network mode, turn management is handled by server tick events
  discard

# Proxy methods to allow calling Bot methods on NetworkBot
method forward*(bot: NetworkBot, distance: float) =
  ## Move forward a specific distance
  cast[Bot](bot).forward(distance)

method back*(bot: NetworkBot, distance: float) =
  ## Move backward a specific distance  
  cast[Bot](bot).back(distance)

method turnLeft*(bot: NetworkBot, degrees: float) =
  ## Turn left by specified degrees
  cast[Bot](bot).turnLeft(degrees)

method turnRight*(bot: NetworkBot, degrees: float) =
  ## Turn right by specified degrees
  cast[Bot](bot).turnRight(degrees)

method turnGunLeft*(bot: NetworkBot, degrees: float) =
  ## Turn gun left by specified degrees
  cast[Bot](bot).turnGunLeft(degrees)

method turnGunRight*(bot: NetworkBot, degrees: float) =
  ## Turn gun right by specified degrees
  cast[Bot](bot).turnGunRight(degrees)

method turnRadarLeft*(bot: NetworkBot, degrees: float) =
  ## Turn radar left by specified degrees
  cast[Bot](bot).turnRadarLeft(degrees)

method turnRadarRight*(bot: NetworkBot, degrees: float) =
  ## Turn radar right by specified degrees
  cast[Bot](bot).turnRadarRight(degrees)

method fire*(bot: NetworkBot) =
  ## Fire with maximum firepower
  cast[Bot](bot).fire()

method fire*(bot: NetworkBot, firepower: float) =
  ## Fire with specified firepower
  cast[Bot](bot).fire(firepower)
