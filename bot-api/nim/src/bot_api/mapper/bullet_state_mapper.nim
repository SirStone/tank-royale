
import ../bot_state
import ../bullet_state
import ../../../jsony/jsony
import ../../../jsony/jsony/[json]
import std/json
import std/math

type
  BulletStateMapper* = object


proc `map`*(this: BulletStateMapper, jsonString: string): BulletState =
  ## Maps a JSON string to a BulletState object.

  let json = parseJson(jsonString)
  
  let bulletId = json["bulletId"].getInt
  let ownerId = json["ownerId"].getInt
  let power = json["power"].getFloat
  let x = json["x"].getFloat
  let y = json["y"].getFloat
  let direction = json["direction"].getFloat
  let speed = json["speed"].getFloat

  result = BulletState(
    bulletId: bulletId,
    ownerId: ownerId,
    power: power,
    x: x,
    y: y,
    direction: direction,
    speed: speed
  )
