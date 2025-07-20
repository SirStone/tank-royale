
## Event occurring whenever a new turn in a round has started.

import bot_event
import ../bot_state
import ../bullet_state

type
  TickEvent* = object of BotEvent
    ## Event occurring whenever a new turn in a round has started
    roundNumber*: int                  ## Current round number
    botState*: BotState               ## Current state of this bot
    bulletStates*: seq[BulletState]   ## Current state of the bullets fired by this bot  
    events*: seq[BotEvent]            ## Events occurring in the turn relevant for this bot

proc newTickEvent*(turnNumber: int, roundNumber: int, botState: BotState, 
                   bulletStates: seq[BulletState], events: seq[BotEvent]): TickEvent =
  ## Initializes a new instance of the TickEvent class
  result = TickEvent(
    turnNumber: turnNumber,
    roundNumber: roundNumber,
    botState: botState,
    bulletStates: bulletStates,
    events: events
  )

proc getRoundNumber*(event: TickEvent): int =
  ## Returns the current round number
  result = event.roundNumber

proc getBotState*(event: TickEvent): BotState =
  ## Returns the current state of this bot
  result = event.botState

proc getBulletStates*(event: TickEvent): seq[BulletState] =
  ## Returns the current state of the bullets fired by this bot
  result = event.bulletStates

proc getEvents*(event: TickEvent): seq[BotEvent] =
  ## Returns the events occurring in the turn relevant for this bot
  result = event.events