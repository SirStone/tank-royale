## Main entry-point module for Robocode Tank Royale Nim bot API.
##
## Usage:
##   import tankroyale_botapi
##
##   type MyBot = ref object of Bot
##   method run(bot: MyBot) =
##     forward(100)
##     ...
##
##   var bot = MyBot()
##   start(bot, "MyBot.json")

import std/[os, json]

import ./tankroyale_botapi/constants
import ./tankroyale_botapi/schemas
import ./tankroyale_botapi/utils
import ./tankroyale_botapi/bot_info
import ./tankroyale_botapi/ws_client
import ./tankroyale_botapi/json_parse
import ./tankroyale_botapi/bot

export constants
export schemas
export utils
export bot_info
export json_parse
export bot

# ---------------------------------------------------------------------------
# WebSocket receive loop (main thread)
# ---------------------------------------------------------------------------

proc handleServerHandshake(ws: SyncWebSocket; node: JsonNode; info: BotInfo; secret: string) =
  let sessionId = node{"sessionId"}.getStr
  setServerInfo(node{"variant"}.getStr, node{"version"}.getStr)

  # Build bot handshake
  var h = newJObject()
  h["type"]           = %"BotHandshake"
  h["sessionId"]      = %sessionId
  h["name"]           = %info.name
  h["version"]        = %info.version
  h["authors"]        = %info.authors
  h["description"]    = %info.description
  h["homepage"]       = %info.homepage
  h["countryCodes"]   = %info.countryCodes
  h["gameTypes"]      = %info.gameTypes
  h["platform"]       = %info.platform
  h["programmingLang"]= %info.programmingLang
  if secret.len > 0:
    h["secret"] = %secret
  ws.send($h)

proc parseGameSetup(node: JsonNode): GameSetup =
  if node.isNil: return
  result.gameType                      = node{"gameType"}.getStr("classic")
  result.arenaWidth                    = node{"arenaWidth"}.getInt(800)
  result.isArenaWidthLocked            = node{"isArenaWidthLocked"}.getBool(false)
  result.arenaHeight                   = node{"arenaHeight"}.getInt(600)
  result.isArenaHeightLocked           = node{"isArenaHeightLocked"}.getBool(false)
  result.numberOfRounds                = node{"numberOfRounds"}.getInt(10)
  result.isNumberOfRoundsLocked        = node{"isNumberOfRoundsLocked"}.getBool(false)
  result.minNumberOfParticipants       = node{"minNumberOfParticipants"}.getInt(2)
  result.isMinNumberOfParticipantsLocked = node{"isMinNumberOfParticipantsLocked"}.getBool(false)
  result.maxNumberOfParticipants       = node{"maxNumberOfParticipants"}.getInt(10)
  result.isMaxNumberOfParticipantsLocked = node{"isMaxNumberOfParticipantsLocked"}.getBool(false)
  result.gunCoolingRate                = node{"gunCoolingRate"}.getFloat(0.1)
  result.isGunCoolingRateLocked        = node{"isGunCoolingRateLocked"}.getBool(false)
  result.maxInactivityTurns            = node{"maxInactivityTurns"}.getInt(450)
  result.isMaxInactivityTurnsLocked    = node{"isMaxInactivityTurnsLocked"}.getBool(false)
  result.turnTimeout                   = node{"turnTimeout"}.getInt(30000)
  result.isTurnTimeoutLocked           = node{"isTurnTimeoutLocked"}.getBool(false)
  result.readyTimeout                  = node{"readyTimeout"}.getInt(1000000)
  result.isReadyTimeoutLocked          = node{"isReadyTimeoutLocked"}.getBool(false)
  result.defaultTurnsPerSecond         = node{"defaultTurnsPerSecond"}.getInt(30)

proc handleGameStarted(ws: SyncWebSocket; node: JsonNode) =
  let setup = parseGameSetup(node{"gameSetup"})

  var teammateIds: seq[int] = @[]
  if not node{"teammateIds"}.isNil and node["teammateIds"].kind == JArray:
    for id in node["teammateIds"]: teammateIds.add id.getInt

  let myId = node{"myId"}.getInt
  setGameStarted(myId, setup, teammateIds)

  # Build event object manually — GameStartedEventForBot has no turnNumber
  let e = GameStartedEventForBot(
    `type`:         "GameStartedEventForBot",
    myId:           myId,
    startX:         node{"startX"}.getFloat(0.0),
    startY:         node{"startY"}.getFloat(0.0),
    startDirection: node{"startDirection"}.getFloat(0.0),
    teammateIds:    teammateIds,
    gameSetup:      setup
  )
  gBot.onGameStarted(e)

  # Send BotReady
  ws.send("""{"type":"BotReady"}""")

proc handleTick(node: JsonNode) =
  # Build TickEventForBot manually to handle optional fields safely
  var tick: TickEventForBot
  tick.`type`      = "TickEventForBot"
  tick.turnNumber  = node{"turnNumber"}.getInt(0)
  tick.roundNumber = node{"roundNumber"}.getInt(0)
  tick.botState    = parseBotState(node{"botState"})
  tick.bulletStates = @[]
  if not node{"bulletStates"}.isNil and node["bulletStates"].kind == JArray:
    for bs in node["bulletStates"]:
      tick.bulletStates.add parseBulletState(bs)
  tick.events = @[]  # not used; raw nodes passed via signalTick

  # Collect embedded events as raw JsonNode for dispatch in bot thread
  var events: seq[JsonNode] = @[]
  if node.hasKey("events") and node["events"].kind == JArray:
    for ev in node["events"]:
      events.add ev

  signalTick(tick, events)

  # Wait for bot thread to send its intent via go()
  let intentJson = recvIntent()
  gWs.send(intentJson)

proc runReceiveLoop*(ws: SyncWebSocket; info: BotInfo; secret: string) =
  ## Main WebSocket receive loop. Blocks until disconnected.
  while ws.connected:
    var msg: string
    try:
      msg = ws.receive()
    except Exception as e:
      stderr.writeLine "[ws] receive error: " & e.msg
      break

    if msg.len == 0:
      break  # connection closed

    var node: JsonNode
    try:
      node = parseJson(msg)
    except Exception as e:
      stderr.writeLine "[ws] json parse error: " & e.msg
      continue

    let msgType = node{"type"}.getStr
    case msgType
    of "ServerHandshake":
      handleServerHandshake(ws, node, info, secret)
    of "GameStartedEventForBot":
      handleGameStarted(ws, node)
    of "RoundStartedEvent":
      let e = node.to(RoundStartedEvent)
      # Start (or restart) the bot thread each round
      startRound()
      startBotThread()
      gBot.onRoundStarted(e)
    of "TickEventForBot":
      handleTick(node)
    of "RoundEndedEventForBot":
      setRunning(false)
      let e = node.to(RoundEndedEventForBot)
      drainIntentChan()
      signalStop()         # unblock bot thread blocked in go()
      waitForBotThread()
      gBot.onRoundEnded(e)
    of "GameEndedEventForBot":
      setRunning(false)
      let e = node.to(GameEndedEventForBot)
      drainIntentChan()
      gBot.onGameEnded(e)
    of "GameAbortedEvent":
      setRunning(false)
      drainIntentChan()
      signalStop()         # unblock bot thread (game aborted mid-round)
      waitForBotThread()
      gBot.onGameAborted()
    of "SkippedTurnEvent":
      let e = node.to(SkippedTurnEvent)
      gBot.onSkippedTurn(e)
    else:
      discard  # unknown message type — ignore

  gBot.onDisconnected()

# ---------------------------------------------------------------------------
# Public start() procedure
# ---------------------------------------------------------------------------

proc start*(bot: Bot; jsonFile: string = "") =
  ## Connect to the server and start the bot.
  ## jsonFile: path to bot JSON profile (optional; falls back to env vars).
  gBot = bot
  gBotInfo = loadBotInfo(jsonFile)
  initGlobals()

  let serverUrl    = getEnv("SERVER_URL", "ws://localhost:7654")
  let serverSecret = getEnv("SERVER_SECRET", "")

  try:
    gWs = newSyncWebSocket(serverUrl)
  except Exception as e:
    stderr.writeLine "[start] Cannot connect to " & serverUrl & ": " & e.msg
    quit(1)

  bot.onConnected()
  runReceiveLoop(gWs, gBotInfo, serverSecret)
