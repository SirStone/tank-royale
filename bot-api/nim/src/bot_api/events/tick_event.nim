nim
import ../bot_state, ../bullet_state, i_event, ../../util/collection_util

type
  TickEvent* = ref object of IEvent
    turnNumber*: int
    roundNumber*: int
    botStates*: seq[BotState]
    bulletStates*: seq[BulletState]

proc newTickEvent*(turnNumber: int, roundNumber: int, botStates: seq[BotState], bulletStates: seq[BulletState]): TickEvent {.inline.} =
  result = TickEvent(turnNumber: turnNumber, roundNumber: roundNumber, botStates: botStates, bulletStates: bulletStates)

proc getBotStates*(this: TickEvent): seq[BotState] {.inline.} =
  return this.botStates

proc getBulletStates*(this: TickEvent): seq[BulletState] {.inline.} =
  return this.bulletStates