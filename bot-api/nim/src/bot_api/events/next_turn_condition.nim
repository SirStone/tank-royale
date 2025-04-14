import ./condition
import ../../bot_api/internal/base_bot_internals

type
  NextTurnCondition* = ref object of Condition #inherits from condition
    botInternals*: BaseBotInternals
    callback*: proc(botInternals: BaseBotInternals): bool

proc newNextTurnCondition*(callback: proc(botInternals: BaseBotInternals): bool, botInternals: BaseBotInternals): NextTurnCondition =
  new(NextTurnCondition)
  result.botInternals = botInternals
  result.callback = callback

proc test*(self: NextTurnCondition): bool =
  result = self.callback(self.botInternals)

