nim
import ./bot_event, ../bot_info

type
    DeathEvent* = ref object of BotEvent
      victim*: BotInfo

proc `$`*(event: DeathEvent): string =
  result = "DeathEvent{"
  result.add "victim=" & $event.victim & " "
  result.add "}"