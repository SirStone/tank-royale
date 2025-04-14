nim
import ./i_event, ../../bot_api/bot_state
import ../constants

type
  Condition* = ref object of RootObj
    description*: string
    priority*: int = DEFAULT_EVENT_PRIORITY

  EventCondition* = ref object of Condition
    event*: IEvent


  NextTurnCondition* = ref object of Condition
    name*: string

proc newCondition*(description: string, priority : int = DEFAULT_EVENT_PRIORITY): Condition =
  result = Condition(priority: priority)
  result.description = description

proc newNextTurnCondition*(name: string): NextTurnCondition =
  result = NextTurnCondition()
  result.name = name

proc newEventCondition*(event: IEvent, description:string = "", priority : int = DEFAULT_EVENT_PRIORITY): EventCondition =
    result = EventCondition(event:event, priority:priority)
    result.description = description


proc isMet*(c: Condition, botState: BotState): bool {.base.} =
  # Override this in subclasses to return if the condition is met or not
  return false