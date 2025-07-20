## Network-enabled bot that can connect to Tank Royale server
## Extends the base Bot with networking capabilities

import asyncdispatch, json, times, strformat, strutils, random, math
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
    # Bot state fields
    x*: float
    y*: float
    direction*: float
    gunDirection*: float
    radarDirection*: float
    speed*: float
    energy*: float
    # Arena size (received from server when game starts)
    arenaWidth*: int
    arenaHeight*: int

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
  # Initialize arena dimensions (will be updated when game starts)
  result.arenaWidth = 800  # Default arena size
  result.arenaHeight = 600
  
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
      
      # Extract arena dimensions from the game setup
      if jsonMsg.hasKey("gameSetup"):
        let gameSetup = jsonMsg["gameSetup"]
        bot.arenaWidth = gameSetup["arenaWidth"].getInt()
        bot.arenaHeight = gameSetup["arenaHeight"].getInt()
        bot.log(&"Arena size: {bot.arenaWidth}x{bot.arenaHeight}")
      
      # Send ready signal
      let readyMsg = """{"type": "BotReady"}"""
      asyncCheck bot.client.send(readyMsg)
      bot.log("Sent BotReady")
      
    of "RoundStartedEvent":
      let roundNumber = jsonMsg["roundNumber"].getInt()
      bot.log(&"Round {roundNumber} started!")
      
    of "TickEventForBot":
      bot.currentTick = jsonMsg["turnNumber"].getInt()
      
      # Parse and update bot state
      if jsonMsg.hasKey("botState"):
        let botStateJson = jsonMsg["botState"]
        bot.x = botStateJson["x"].getFloat()
        bot.y = botStateJson["y"].getFloat()
        bot.direction = botStateJson["direction"].getFloat()
        bot.gunDirection = botStateJson["gunDirection"].getFloat()
        bot.radarDirection = botStateJson["radarDirection"].getFloat()
        bot.speed = botStateJson["speed"].getFloat()
        bot.energy = botStateJson["energy"].getFloat()
        
        bot.log(&"Turn {bot.currentTick}: Energy={bot.energy:.1f}, " &
                &"X={bot.x:.1f}, Y={bot.y:.1f}, " &
                &"Direction={bot.direction:.1f}°")
      
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

proc normalizeRelativeAngle*(angle: float): float =
  ## Normalizes an angle to a relative angle in the range [-180, 180)
  var normalizedAngle = angle mod 360.0
  if normalizedAngle >= 180.0:
    normalizedAngle -= 360.0
  elif normalizedAngle < -180.0:
    normalizedAngle += 360.0
  return normalizedAngle

proc calcBearing*(bot: NetworkBot, direction: float): float =
  ## Calculates the bearing (delta angle) between the input direction and the bot's direction
  ## bearing = calcBearing(direction) = normalizeRelativeAngle(direction - getDirection())
  return normalizeRelativeAngle(direction - bot.direction)

proc bearingTo*(bot: NetworkBot, x: float, y: float): float =
  ## Calculates the bearing to a point (x, y)
  let directionToPoint = math.arctan2(y - bot.y, x - bot.x) * 180.0 / math.PI
  return bot.calcBearing(directionToPoint)

proc distanceTo*(bot: NetworkBot, x: float, y: float): float =
  ## Calculates the distance to a point (x, y)
  let dx = x - bot.x
  let dy = y - bot.y
  return math.sqrt(dx * dx + dy * dy)

# Arena and state access methods
method getArenaWidth*(bot: NetworkBot): int =
  ## Get the arena width
  return bot.arenaWidth

method getArenaHeight*(bot: NetworkBot): int =
  ## Get the arena height
  return bot.arenaHeight

method getDirection*(bot: NetworkBot): float =
  ## Get current body direction
  return bot.direction

method getGunDirection*(bot: NetworkBot): float =
  ## Get current gun direction
  return bot.gunDirection

method getRadarDirection*(bot: NetworkBot): float =
  ## Get current radar direction
  return bot.radarDirection

method getEnemyCount*(bot: NetworkBot): int =
  ## Get number of enemies remaining
  # This would typically be updated from the server tick events
  # For now, return a placeholder value
  return 1

# Color setting methods (these set colors in the bot intent)
method setBodyColor*(bot: NetworkBot, color: string) =
  ## Set body color
  # Color setting is handled in the BotIntent creation
  discard

method setTurretColor*(bot: NetworkBot, color: string) =
  ## Set gun turret color
  # Color setting is handled in the BotIntent creation
  discard

method setRadarColor*(bot: NetworkBot, color: string) =
  ## Set radar color
  # Color setting is handled in the BotIntent creation
  discard

method setBulletColor*(bot: NetworkBot, color: string) =
  ## Set bullet color
  # Color setting is handled in the BotIntent creation
  discard

method setScanColor*(bot: NetworkBot, color: string) =
  ## Set scan arc color
  # Color setting is handled in the BotIntent creation
  discard

# Radar control method
method rescan*(bot: NetworkBot) =
  ## Force the radar to rescan
  # This should trigger an immediate radar scan
  # In the current implementation, we'll set a flag to trigger rescan in the next intent
  discard

# Movement control methods
method stop*(bot: NetworkBot) =
  ## Stop all movement
  cast[Bot](bot).setTargetSpeed(0.0)

method resume*(bot: NetworkBot) =
  ## Resume previous movement
  # This would typically resume from a previously stopped state
  # For now, just allow movement again
  discard

method isRunning*(bot: NetworkBot): bool =
  ## Check if the bot is still running
  return bot.isRunning

# Movement and turning methods with remaining tracking
method setForward*(bot: NetworkBot, distance: float) =
  ## Set the bot to move forward a specific distance
  # Set target speed based on distance
  if distance > 0:
    cast[Bot](bot).setTargetSpeed(8.0)  # Move forward at max speed
  else:
    cast[Bot](bot).setTargetSpeed(-8.0)  # Move backward
  
method setBack*(bot: NetworkBot, distance: float) =
  ## Set the bot to move backward a specific distance
  bot.setForward(-distance)

method getTurnRemaining*(bot: NetworkBot): float =
  ## Get remaining turn degrees
  # For now, return 0 since we don't track turn remaining in NetworkBot
  # This would need proper implementation with turn tracking
  return 0.0

method setTurnLeft*(bot: NetworkBot, degrees: float) =
  ## Set the bot to turn left by specified degrees
  cast[Bot](bot).setTurnRate(-abs(degrees))

method setTurnRight*(bot: NetworkBot, degrees: float) =
  ## Set the bot to turn right by specified degrees  
  cast[Bot](bot).setTurnRate(abs(degrees))

# Condition-based waiting
method waitFor*(bot: NetworkBot, condition: proc(): bool) =
  ## Wait for a condition to become true
  # This is a simplified implementation that just calls go() once
  # A proper implementation would loop until condition is true
  # For now, just advance one turn
  cast[Bot](bot).go()

# Speed accessor method
method getTargetSpeed*(bot: NetworkBot): float =
  ## Get the current target speed
  return cast[BaseBot](bot).getTargetSpeed()
