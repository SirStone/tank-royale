import json

type
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
    startTimeout*: int

proc newGameSetup*(
  gameType: string,
  arenaWidth: int,
  arenaHeight: int,
  minNumberOfParticipants: int,
  maxNumberOfParticipants: int,
  numberOfRounds: int,
  gunCoolingRate: float,
  maxInactivityTurns: int,
  turnTimeout: int,
  readyTimeout: int,
  startTimeout: int
): GameSetup =
  new result
  result.gameType = gameType
  result.arenaWidth = arenaWidth
  result.arenaHeight = arenaHeight
  result.minNumberOfParticipants = minNumberOfParticipants.clamp(1, int.high)
  result.maxNumberOfParticipants = maxNumberOfParticipants.clamp(1, int.high)
  result.numberOfRounds = numberOfRounds.clamp(1, int.high)
  result.gunCoolingRate = gunCoolingRate.clamp(0.0, float.high)
  result.maxInactivityTurns = maxInactivityTurns.clamp(1, int.high)
  result.turnTimeout = turnTimeout.clamp(1, int.high)
  result.readyTimeout = readyTimeout.clamp(1, int.high)
  result.startTimeout = startTimeout.clamp(1, int.high)

proc newGameSetup*(): GameSetup =
  return newGameSetup("", 0, 0, 0, 0, 0, 0.0, 0, 0, 0, 0)

proc toString*(gameSetup: GameSetup): string =
  var json = newJObject()
  json["gameType"] = toJNode(gameSetup.gameType)
  json["arenaWidth"] = toJNode(gameSetup.arenaWidth)
  json["arenaHeight"] = toJNode(gameSetup.arenaHeight)
  json["minNumberOfParticipants"] = toJNode(gameSetup.minNumberOfParticipants)
  json["maxNumberOfParticipants"] = toJNode(gameSetup.maxNumberOfParticipants)
  json["numberOfRounds"] = toJNode(gameSetup.numberOfRounds)
  json["gunCoolingRate"] = toJNode(gameSetup.gunCoolingRate)
  json["maxInactivityTurns"] = toJNode(gameSetup.maxInactivityTurns)
  json["turnTimeout"] = toJNode(gameSetup.turnTimeout)
  json["readyTimeout"] = toJNode(gameSetup.readyTimeout)
  json["startTimeout"] = toJNode(gameSetup.startTimeout)
  return $json

proc fromString*(str: string): GameSetup =
  let json = parseJson(str)
  newGameSetup(json["gameType"].getStr(), json["arenaWidth"].getInt(), json["arenaHeight"].getInt(), json["minNumberOfParticipants"].getInt(), json["maxNumberOfParticipants"].getInt(), json["numberOfRounds"].getInt(), json["gunCoolingRate"].getFloat(), json["maxInactivityTurns"].getInt(), json["turnTimeout"].getInt(), json["readyTimeout"].getInt(), json["startTimeout"].getInt())
