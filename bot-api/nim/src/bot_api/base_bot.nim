nim
import os
import json
import strutils
import tables
import sequtils

# Dependencies (add more as needed)
# You might need to install these:
# nimble install websockets
# nimble install chronos
import websockets
import chronos

type
  BotState* = ref object of RootObj
    x*: float
    y*: float
    direction*: float
    gunDirection*: float
    radarDirection*: float
    speed*: float
    energy*: float
    bodyColor*: string
    turretColor*: string
    radarColor*: string
    bulletColor*: string
    scanColor*: string
    tracksColor*: string
    gunColor*: string
  
  BulletState* = ref object of RootObj
    bulletId*: int
    ownerId*: int
    x*: float
    y*: float
    direction*: float
    power*: float
    speed*: float
    color*: string
    
  BotResults* = ref object of RootObj
    survival*: int
    lastSurvivorBonus*: float
    bulletDamage*: float
    bulletKillBonus*: float
    ramDamage*: float
    ramKillBonus*: float
    totalScore*: float
    totalSurvivalScore*: float
    totalBulletDamageScore*: float
    totalRamDamageScore*: float
    
  InitialPosition* = ref object of RootObj
    x*: float
    y*: float
    direction*: float
    
  GameSetup* = ref object of RootObj
    gameType*: string
    arenaWidth*: int
    arenaHeight*: int
    minNumberOfParticipants*: int
    maxNumberOfParticipants*: int
    numberOfRounds*: int
    gunCoolingRate*: float
    maxInactivityTurns*: int
    turnTimeout*: int
    readyTimeout*: int
    numberOfDroid*: int
    
  BotInfo* = ref object of RootObj
    name*: string
    version*: string
    authors*: seq[string]
    description*: string
    homepage*: string
    countryCodes*: seq[string]
    gameTypes*: seq[string]
    platform*: string
    programmingLang*: string
    
  Event*[T] = ref object of RootObj
  EventTable* = Table[string, seq[Event[untyped]]]

  BaseBot* = ref object of RootObj
    botInfo*: BotInfo
    myId*: int
    gameSetup*: GameSetup
    botState*: BotState
    bulletStates*: seq[BulletState]
    
    # Internal fields for handling connection and events
    serverUrl*: string
    serverSecret*: string
    ws*: WebSocketClient
    eventQueue*: seq[Event[untyped]]
    eventHandlers*: EventTable

proc newBaseBot*(botInfo: BotInfo, serverUrl: string, serverSecret: string): BaseBot =
  result = BaseBot(
    botInfo: botInfo,
    myId: -1, # Will be set by server
    gameSetup: nil,
    botState: nil,
    bulletStates: @[],
    serverUrl: serverUrl,
    serverSecret: serverSecret,
    ws: nil,
    eventQueue: @[],
    eventHandlers: initTable[string, seq[Event[untyped]]]()
  )

proc start*(bot: var BaseBot) {.async.} =
  echo "Starting bot..."
  let url = bot.serverUrl
  echo "Connecting to url: ",url
  bot.ws = newWebSocketClient()
  try:
    await bot.ws.connect(url)
    echo "Connected to ", url
    # Implement bot logic here (e.g., sending bot handshake, etc.)
    bot.run()
  except CatchableError as e:
      echo "Error in start method: ", e.msg


proc run*(bot: var BaseBot) {.async.} =
  echo "Hello from the Nim Base Bot!"
  # await bot.start()