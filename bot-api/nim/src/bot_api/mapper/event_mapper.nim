nim
import ../events/i_event
import ../events/bot_death_event
import ../events/bot_event
import ../events/bullet_fired_event
import ../events/bullet_hit_bot_event
import ../events/bullet_hit_bullet_event
import ../events/bullet_hit_wall_event
import ../events/connected_event
import ../events/connection_error_event
import ../events/custom_event
import ../events/death_event
import ../events/disconnected_event
import ../events/game_ended_event
import ../events/game_started_event
import ../events/hit_bot_event
import ../events/hit_by_bullet_event
import ../events/hit_wall_event
import ../events/round_ended_event
import ../events/round_started_event
import ../events/scanned_bot_event
import ../events/skipped_turn_event
import ../events/team_message_event
import ../events/tick_event
import ../events/won_round_event
import ../events/next_turn_condition
import ../events/condition
import ../bot_state
import ../bullet_state

type
  EventMapper* = object

proc map*(mapper: EventMapper, eventJson: JsonNode): IEvent =
  let type_field = eventJson["type"].getStr()

  if type_field == "BotDeathEvent":
    let victimId = eventJson["victimId"].getInt()
    return BotDeathEvent(victimId: victimId)
  elif type_field == "BulletFiredEvent":
    let bullet = BulletState(
      bulletId: eventJson["bullet"]["bulletId"].getInt(),
      ownerId: eventJson["bullet"]["ownerId"].getInt(),
      power: eventJson["bullet"]["power"].getFloat(),
      x: eventJson["bullet"]["x"].getFloat(),
      y: eventJson["bullet"]["y"].getFloat(),
      direction: eventJson["bullet"]["direction"].getFloat(),
      speed: eventJson["bullet"]["speed"].getFloat()
    )
    return BulletFiredEvent(bullet: bullet)
  elif type_field == "BulletHitBotEvent":
    let bullet = BulletState(
      bulletId: eventJson["bullet"]["bulletId"].getInt(),
      ownerId: eventJson["bullet"]["ownerId"].getInt(),
      power: eventJson["bullet"]["power"].getFloat(),
      x: eventJson["bullet"]["x"].getFloat(),
      y: eventJson["bullet"]["y"].getFloat(),
      direction: eventJson["bullet"]["direction"].getFloat(),
      speed: eventJson["bullet"]["speed"].getFloat()
    )
    let victimId = eventJson["victimId"].getInt()
    let damage = eventJson["damage"].getFloat()
    let energy = eventJson["energy"].getFloat()
    return BulletHitBotEvent(bullet: bullet, victimId: victimId, damage: damage, energy: energy)
  elif type_field == "BulletHitBulletEvent":
      let bullet = BulletState(
      bulletId: eventJson["bullet"]["bulletId"].getInt(),
      ownerId: eventJson["bullet"]["ownerId"].getInt(),
      power: eventJson["bullet"]["power"].getFloat(),
      x: eventJson["bullet"]["x"].getFloat(),
      y: eventJson["bullet"]["y"].getFloat(),
      direction: eventJson["bullet"]["direction"].getFloat(),
      speed: eventJson["bullet"]["speed"].getFloat()
    )
      let hitBullet = BulletState(
      bulletId: eventJson["hitBullet"]["bulletId"].getInt(),
      ownerId: eventJson["hitBullet"]["ownerId"].getInt(),
      power: eventJson["hitBullet"]["power"].getFloat(),
      x: eventJson["hitBullet"]["x"].getFloat(),
      y: eventJson["hitBullet"]["y"].getFloat(),
      direction: eventJson["hitBullet"]["direction"].getFloat(),
      speed: eventJson["hitBullet"]["speed"].getFloat()
    )
      return BulletHitBulletEvent(bullet: bullet,hitBullet: hitBullet)
  elif type_field == "BulletHitWallEvent":
    let bullet = BulletState(
      bulletId: eventJson["bullet"]["bulletId"].getInt(),
      ownerId: eventJson["bullet"]["ownerId"].getInt(),
      power: eventJson["bullet"]["power"].getFloat(),
      x: eventJson["bullet"]["x"].getFloat(),
      y: eventJson["bullet"]["y"].getFloat(),
      direction: eventJson["bullet"]["direction"].getFloat(),
      speed: eventJson["bullet"]["speed"].getFloat()
    )
    return BulletHitWallEvent(bullet: bullet)
  elif type_field == "ConnectedEvent":
    return ConnectedEvent()
  elif type_field == "ConnectionErrorEvent":
    let error = eventJson["error"].getStr()
    return ConnectionErrorEvent(error: error)
  elif type_field == "CustomEvent":
    let conditionName = eventJson["conditionName"].getStr()
    return CustomEvent(conditionName: conditionName)
  elif type_field == "DeathEvent":
    return DeathEvent()
  elif type_field == "DisconnectedEvent":
    return DisconnectedEvent()
  elif type_field == "GameEndedEvent":
    return GameEndedEvent()
  elif type_field == "GameStartedEvent":
    return GameStartedEvent()
  elif type_field == "HitBotEvent":
    let victimId = eventJson["victimId"].getInt()
    let energy = eventJson["energy"].getFloat()
    let bearing = eventJson["bearing"].getFloat()
    let isRamed = eventJson["isRamed"].getBool()
    return HitBotEvent(victimId: victimId, energy: energy, bearing: bearing,isRamed: isRamed)
  elif type_field == "HitByBulletEvent":
      let bullet = BulletState(
      bulletId: eventJson["bullet"]["bulletId"].getInt(),
      ownerId: eventJson["bullet"]["ownerId"].getInt(),
      power: eventJson["bullet"]["power"].getFloat(),
      x: eventJson["bullet"]["x"].getFloat(),
      y: eventJson["bullet"]["y"].getFloat(),
      direction: eventJson["bullet"]["direction"].getFloat(),
      speed: eventJson["bullet"]["speed"].getFloat()
    )
      let damage = eventJson["damage"].getFloat()
      let energy = eventJson["energy"].getFloat()
      return HitByBulletEvent(bullet: bullet,damage: damage,energy: energy)
  elif type_field == "HitWallEvent":
    let bearing = eventJson["bearing"].getFloat()
    return HitWallEvent(bearing: bearing)
  elif type_field == "RoundEndedEvent":
    let roundNum = eventJson["roundNum"].getInt()
    return RoundEndedEvent(roundNum: roundNum)
  elif type_field == "RoundStartedEvent":
    let roundNum = eventJson["roundNum"].getInt()
    return RoundStartedEvent(roundNum: roundNum)
  elif type_field == "ScannedBotEvent":
    let scannedBotId = eventJson["scannedBotId"].getInt()
    let energy = eventJson["energy"].getFloat()
    let x = eventJson["x"].getFloat()
    let y = eventJson["y"].getFloat()
    let direction = eventJson["direction"].getFloat()
    let speed = eventJson["speed"].getFloat()
    let bearing = eventJson["bearing"].getFloat()
    return ScannedBotEvent(scannedBotId: scannedBotId, energy: energy, x: x, y: y, direction: direction, speed: speed, bearing: bearing)
  elif type_field == "SkippedTurnEvent":
    return SkippedTurnEvent()
  elif type_field == "TeamMessageEvent":
      let message = eventJson["message"].getStr()
      let senderId = eventJson["senderId"].getInt()
      let receiverId = eventJson["receiverId"].getInt()
      return TeamMessageEvent(message: message,senderId: senderId,receiverId: receiverId)
  elif type_field == "TickEvent":
    if not eventJson.hasKey("turnNumber"):
      raise newException(ValueError, "TickEvent is missing the 'turnNumber' field")
    if not eventJson["turnNumber"].isNumber:
      raise newException(ValueError, "The 'turnNumber' field must be a number")
    if not eventJson.hasKey("botStates"):
      raise newException(ValueError, "TickEvent is missing the 'botStates' field")
    if not eventJson.hasKey("bulletStates"):
      raise newException(ValueError, "TickEvent is missing the 'bulletStates' field")
    let turnNumber = eventJson["turnNumber"].getInt()
    let bots = newSeq[BotState]()
    if eventJson.hasKey("botStates"):
       for item in eventJson["botStates"].items:
          let botState = BotState(
          id: item["id"].getInt(),
          energy: item["energy"].getFloat(),
          x: item["x"].getFloat(),
          y: item["y"].getFloat(),
          direction: item["direction"].getFloat(),
          gunDirection: item["gunDirection"].getFloat(),
          radarDirection: item["radarDirection"].getFloat(),
          speed: item["speed"].getFloat(),
          turnRate: item["turnRate"].getFloat(),
          gunTurnRate: item["gunTurnRate"].getFloat(),
          radarTurnRate: item["radarTurnRate"].getFloat()
        )
          bots.add(botState)
    let bullets = newSeq[BulletState]()
    if eventJson.hasKey("bulletStates"):
      for item in eventJson["bulletStates"].items:
        let bulletState = BulletState(
          bulletId: item["bulletId"].getInt(),
          ownerId: item["ownerId"].getInt(),
          power: item["power"].getFloat(),
          x: item["x"].getFloat(),
          y: item["y"].getFloat(),
          direction: item["direction"].getFloat(),
          speed: item["speed"].getFloat()
        )
        bullets.add(bulletState)
    return TickEvent(turnNumber: turnNumber, botStates: bots, bulletStates: bullets)
  elif type_field == "WonRoundEvent":
      return WonRoundEvent()
  elif type_field == "NextTurnCondition":
    if not eventJson.hasKey("condition"):
      raise newException(ValueError, "NextTurnCondition is missing the 'condition' field")
    let condition = Condition(conditionName: eventJson["condition"]["conditionName"].getStr(),
                              nextTurn: eventJson["condition"]["nextTurn"].getBool())
    return NextTurnCondition(condition: condition)
  elif type_field == "Condition":
    if not eventJson.hasKey("conditionName"):
        raise newException(ValueError, "Condition is missing the 'conditionName' field")
    if not eventJson.hasKey("nextTurn"):
        raise newException(ValueError, "Condition is missing the 'nextTurn' field")
    let conditionName = eventJson["conditionName"].getStr()
    let nextTurn = eventJson["nextTurn"].getBool()
    return Condition(conditionName: conditionName,nextTurn: nextTurn)
  else:
    raise newException(ValueError, "Unknown event type: " & type_field)