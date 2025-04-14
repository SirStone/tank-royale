import ../bot_event, ../bot_info
import ./i_event

type
  WonRoundEvent* = ref object of BotEvent
    winner*: BotInfo

proc newWonRoundEvent*(winner: BotInfo): WonRoundEvent =
  WonRoundEvent(botEvent: newBotEvent(), winner: winner)

proc getWinner*(self: WonRoundEvent): BotInfo =
  return self.winner

