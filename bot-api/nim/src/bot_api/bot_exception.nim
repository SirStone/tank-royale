nim
import strutils

type
  BotException* = ref object of CatchableError
    message*: string

proc newBotException*(message: string): BotException =
  BotException(message: message)

proc `msg`(e: BotException): string = e.message