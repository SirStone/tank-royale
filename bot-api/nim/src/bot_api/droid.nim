import bot_api/base_bot, bot_api/i_base_bot, bot_api/bot_info, bot_api/events/i_event, bot_api/events/tick_event,
    bot_api/events/game_started_event, bot_api/events/game_ended_event, bot_api/events/round_ended_event,
    bot_api/events/round_started_event, bot_api/events/bot_event, bot_api/events/death_event,
    bot_api/events/connected_event, bot_api/events/disconnected_event, bot_api/events/custom_event, 
    bot_api/events/connection_error_event

type
  Droid* = ref object of BaseBot
    # Add any specific fields for Droid if needed

proc newDroid*(botInfo: BotInfo, serverUri: string, autoRun: bool = false): Droid =
    ## Constructor for creating a new Droid instance.
    new(result)
    result.initBaseBot(botInfo, serverUri)
    if autoRun:
        result.run()

proc run*(droid: Droid) =
  ## Starts the droid.
  droid.start()

proc onTick*(droid: Droid, event: TickEvent) {.base.} =
    # To be overwritten
    discard

proc onGameStarted*(droid: Droid, event: GameStartedEvent) {.base.} =
    # To be overwritten
    discard

proc onGameEnded*(droid: Droid, event: GameEndedEvent) {.base.} =
    # To be overwritten
    discard

proc onRoundStarted*(droid: Droid, event: RoundStartedEvent) {.base.} =
    # To be overwritten
    discard

proc onRoundEnded*(droid: Droid, event: RoundEndedEvent) {.base.} =
    # To be overwritten
    discard

proc start*(droid: Droid) =
    echo "Droid started"