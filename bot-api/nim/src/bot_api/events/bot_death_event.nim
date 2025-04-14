nim
import bot_api/events/bot_event

type
  BotDeathEvent* = ref object of BotEvent
    victimId*: int