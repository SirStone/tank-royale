nim
import ../game_setup, json, strutils

proc map*(gameSetup: GameSetup): JsonNode =
  let result = newJObject(
    "arenaWidth": newJInt(gameSetup.arenaWidth),
    "arenaHeight": newJInt(gameSetup.arenaHeight),
    "minNumberOfParticipants": newJInt(gameSetup.minNumberOfParticipants),
    "maxNumberOfParticipants": newJInt(gameSetup.maxNumberOfParticipants),
    "numberOfRounds": newJInt(gameSetup.numberOfRounds),
    "gunCoolingRate": newJFloat(gameSetup.gunCoolingRate),
    "maxInactivityTurns": newJInt(gameSetup.maxInactivityTurns),
    "gameType": newJString(gameSetup.gameType)
  )
  return result

proc map*(jsonNode: JsonNode): GameSetup =
  var result: GameSetup
  if not jsonNode.hasKeyOrNull("arenaWidth").isNull:
    result.arenaWidth = jsonNode["arenaWidth"].getInt()
  else:
    raise newException(ValueError, "arenaWidth not found in JSON")

  if not jsonNode.hasKeyOrNull("arenaHeight").isNull:
    result.arenaHeight = jsonNode["arenaHeight"].getInt()
  else:
    raise newException(ValueError, "arenaHeight not found in JSON")

  if not jsonNode.hasKeyOrNull("minNumberOfParticipants").isNull:
    result.minNumberOfParticipants = jsonNode["minNumberOfParticipants"].getInt()
  else:
    raise newException(ValueError, "minNumberOfParticipants not found in JSON")

  if not jsonNode.hasKeyOrNull("maxNumberOfParticipants").isNull:
    result.maxNumberOfParticipants = jsonNode["maxNumberOfParticipants"].getInt()
  else:
    raise newException(ValueError, "maxNumberOfParticipants not found in JSON")

  if not jsonNode.hasKeyOrNull("numberOfRounds").isNull:
    result.numberOfRounds = jsonNode["numberOfRounds"].getInt()
  if not jsonNode.hasKeyOrNull("gunCoolingRate").isNull:
    result.gunCoolingRate = jsonNode["gunCoolingRate"].getFloat()
  if not jsonNode.hasKeyOrNull("maxInactivityTurns").isNull:
    result.maxInactivityTurns = jsonNode["maxInactivityTurns"].getInt()
  if not jsonNode.hasKeyOrNull("gameType").isNull:
    result.gameType = jsonNode["gameType"].getString()

  return result