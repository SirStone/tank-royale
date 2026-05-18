## Safe JSON-to-type parsing for Robocode Tank Royale protocol.
##
## Uses the {} accessor (returns nil on missing keys) and typed getters with
## default values so that optional schema fields never raise KeyError.

import std/json
import ./schemas

proc parseBulletState*(node: JsonNode): BulletState =
  ## Parse a BulletState from JSON; missing optional fields default to zero.
  if node.isNil: return
  result.bulletId  = node{"bulletId"}.getInt(0)
  result.ownerId   = node{"ownerId"}.getInt(0)
  result.power     = node{"power"}.getFloat(0.0)
  result.x         = node{"x"}.getFloat(0.0)
  result.y         = node{"y"}.getFloat(0.0)
  result.direction = node{"direction"}.getFloat(0.0)
  result.color     = node{"color"}.getStr("")

proc parseBotState*(node: JsonNode): BotState =
  ## Parse a BotState from JSON; optional colour/flag fields default to empty/false.
  if node.isNil: return
  result.isDroid        = node{"isDroid"}.getBool(false)
  result.energy         = node{"energy"}.getFloat(0.0)
  result.x              = node{"x"}.getFloat(0.0)
  result.y              = node{"y"}.getFloat(0.0)
  result.direction      = node{"direction"}.getFloat(0.0)
  result.gunDirection   = node{"gunDirection"}.getFloat(0.0)
  result.radarDirection = node{"radarDirection"}.getFloat(0.0)
  result.radarSweep     = node{"radarSweep"}.getFloat(0.0)
  result.speed          = node{"speed"}.getFloat(0.0)
  result.turnRate       = node{"turnRate"}.getFloat(0.0)
  result.gunTurnRate    = node{"gunTurnRate"}.getFloat(0.0)
  result.radarTurnRate  = node{"radarTurnRate"}.getFloat(0.0)
  result.gunHeat        = node{"gunHeat"}.getFloat(0.0)
  result.enemyCount     = node{"enemyCount"}.getInt(0)
  result.bodyColor      = node{"bodyColor"}.getStr("")
  result.turretColor    = node{"turretColor"}.getStr("")
  result.radarColor     = node{"radarColor"}.getStr("")
  result.bulletColor    = node{"bulletColor"}.getStr("")
  result.scanColor      = node{"scanColor"}.getStr("")
  result.tracksColor    = node{"tracksColor"}.getStr("")
  result.gunColor       = node{"gunColor"}.getStr("")
