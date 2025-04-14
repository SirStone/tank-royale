import bot_api/events/i_event, bot_api/game_setup

type
  GameStartedEvent* = ref object of Event
    gameSetup*: GameSetup

  GameStartedEventObj* = object
    event*: GameStartedEvent


proc newGameStartedEvent*(gameSetup*: GameSetup): GameStartedEvent =
  result = GameStartedEvent(gameSetup: gameSetup)