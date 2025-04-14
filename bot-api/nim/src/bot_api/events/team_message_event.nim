nim
import ../bot_state, ./bot_event, ./i_event

type
  TeamMessageEvent* = ref object of BotEvent
    recipient*: BotState # Bot that receives the message.
    message*: string # The message to send.

proc newTeamMessageEvent*(recipient: BotState, message: string): TeamMessageEvent =
  new result
  result.recipient = recipient
  result.message = message
  
proc getRecipient*(this: TeamMessageEvent): BotState = this.recipient
proc getMessage*(this: TeamMessageEvent): string = this.message