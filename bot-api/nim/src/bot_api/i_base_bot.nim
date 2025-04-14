import ./game_setup
import ./bot_info
import ./bot_state
import ./bullet_state
import ./events/i_event
import ./events/condition

type
  IBaseBot* = concept
    `getBotId` is proc (bot: auto): int
    `getMyName` is proc (bot: auto): string
    `getEnemyNames` is proc (bot: auto): seq[string]
    `getGameSetup` is proc (bot: auto): GameSetup
    `getBotInfo` is proc (bot: auto): BotInfo
    `getBotState` is proc (bot: auto): BotState
    `getBulletStates` is proc (bot: auto): seq[BulletState]
    `isRunning` is proc (bot: auto): bool
    `start` is proc (bot: auto)
    `stop` is proc (bot: auto)
    `fire` is proc (bot: auto, power: float)
    `setTargetSpeed` is proc (bot: auto, speed: float)
    `setTurnRate` is proc (bot: auto, turnRate: float)
    `setGunTurnRate` is proc (bot: auto, gunTurnRate: float)
    `setRadarTurnRate` is proc (bot: auto, radarTurnRate: float)
    `setAdjustGunForBodyTurn` is proc (bot: auto, adjust: bool)
    `setAdjustRadarForBodyTurn` is proc (bot: auto, adjust: bool)
    `setAdjustRadarForGunTurn` is proc (bot: auto, adjust: bool)
    `setMaxTurnRate` is proc (bot: auto, maxTurnRate: float)
    `setMaxGunTurnRate` is proc (bot: auto, maxGunTurnRate: float)
    `setMaxRadarTurnRate` is proc (bot: auto, maxRadarTurnRate: float)
    `setMaxSpeed` is proc (bot: auto, maxSpeed: float)
    `sendMessage` is proc (bot: auto, recipient: string, message: string)
    `addEventListener` is proc (bot: auto, priority: int, handler: proc (event: Event))
    `removeEventListener` is proc (bot: auto, handler: proc (event: Event))
    `waitFor` is proc (bot: auto, condition: Condition)
    `nextTurn` is proc (bot: auto)

  IBaseBotRef* = ref IBaseBot

proc getBotId*(bot: IBaseBot): int
proc getMyName*(bot: IBaseBot): string
proc getEnemyNames*(bot: IBaseBot): seq[string]
proc getGameSetup*(bot: IBaseBot): GameSetup
proc getBotInfo*(bot: IBaseBot): BotInfo
proc getBotState*(bot: IBaseBot): BotState
proc getBulletStates*(bot: IBaseBot): seq[BulletState]
proc isRunning*(bot: IBaseBot): bool
proc start*(bot: IBaseBot)
proc stop*(bot: IBaseBot)
proc fire*(bot: IBaseBot, power: float)
proc setTargetSpeed*(bot: IBaseBot, speed: float)
proc setTurnRate*(bot: IBaseBot, turnRate: float)
proc setGunTurnRate*(bot: IBaseBot, gunTurnRate: float)
proc setRadarTurnRate*(bot: IBaseBot, radarTurnRate: float)
proc setAdjustGunForBodyTurn*(bot: IBaseBot, adjust: bool)
proc setAdjustRadarForBodyTurn*(bot: IBaseBot, adjust: bool)
proc setAdjustRadarForGunTurn*(bot: IBaseBot, adjust: bool)
proc setMaxTurnRate*(bot: IBaseBot, maxTurnRate: float)
proc setMaxGunTurnRate*(bot: IBaseBot, maxGunTurnRate: float)
proc setMaxRadarTurnRate*(bot: IBaseBot, maxRadarTurnRate: float)
proc setMaxSpeed*(bot: IBaseBot, maxSpeed: float)
proc sendMessage*(bot: IBaseBot, recipient: string, message: string)
proc addEventListener*(bot: IBaseBot, priority: int, handler: proc (event: Event))
proc removeEventListener*(bot: IBaseBot, handler: proc (event: Event))
proc waitFor*(bot: IBaseBot, condition: Condition)
proc nextTurn*(bot: IBaseBot)


proc getBotId*(bot: IBaseBotRef): int = 
  return bot.getBotId()

proc getMyName*(bot: IBaseBotRef): string =
  return bot.getMyName()

proc getEnemyNames*(bot: IBaseBotRef): seq[string] =
  return bot.getEnemyNames()

proc getGameSetup*(bot: IBaseBotRef): GameSetup =
  return bot.getGameSetup()

proc getBotInfo*(bot: IBaseBotRef): BotInfo =
  return bot.getBotInfo()

proc getBotState*(bot: IBaseBotRef): BotState =
  return bot.getBotState()

proc getBulletStates*(bot: IBaseBotRef): seq[BulletState] =
  return bot.getBulletStates()

proc isRunning*(bot: IBaseBotRef): bool =
  return bot.isRunning()

proc start*(bot: IBaseBotRef) =
  bot.start()

proc stop*(bot: IBaseBotRef) =
  bot.stop()

proc fire*(bot: IBaseBotRef, power: float) =
  bot.fire(power)

proc setTargetSpeed*(bot: IBaseBotRef, speed: float) =
  bot.setTargetSpeed(speed)

proc setTurnRate*(bot: IBaseBotRef, turnRate: float) =
  bot.setTurnRate(turnRate)

proc setGunTurnRate*(bot: IBaseBotRef, gunTurnRate: float) =
  bot.setGunTurnRate(gunTurnRate)

proc setRadarTurnRate*(bot: IBaseBotRef, radarTurnRate: float) =
  bot.setRadarTurnRate(radarTurnRate)

proc setAdjustGunForBodyTurn*(bot: IBaseBotRef, adjust: bool) =
  bot.setAdjustGunForBodyTurn(adjust)

proc setAdjustRadarForBodyTurn*(bot: IBaseBotRef, adjust: bool) =
  bot.setAdjustRadarForBodyTurn(adjust)

proc setAdjustRadarForGunTurn*(bot: IBaseBotRef, adjust: bool) =
  bot.setAdjustRadarForGunTurn(adjust)

proc setMaxTurnRate*(bot: IBaseBotRef, maxTurnRate: float) =
  bot.setMaxTurnRate(maxTurnRate)

proc setMaxGunTurnRate*(bot: IBaseBotRef, maxGunTurnRate: float) =
  bot.setMaxGunTurnRate(maxGunTurnRate)

proc setMaxRadarTurnRate*(bot: IBaseBotRef, maxRadarTurnRate: float) =
  bot.setMaxRadarTurnRate(maxRadarTurnRate)

proc setMaxSpeed*(bot: IBaseBotRef, maxSpeed: float) =
  bot.setMaxSpeed(maxSpeed)

proc sendMessage*(bot: IBaseBotRef, recipient: string, message: string) =
  bot.sendMessage(recipient, message)

proc addEventListener*(bot: IBaseBotRef, priority: int, handler: proc (event: Event)) =
  bot.addEventListener(priority, handler)

proc removeEventListener*(bot: IBaseBotRef, handler: proc (event: Event)) =
  bot.removeEventListener(handler)

proc waitFor*(bot: IBaseBotRef, condition: Condition) =
  bot.waitFor(condition)

proc nextTurn*(bot: IBaseBotRef) =
  bot.nextTurn()