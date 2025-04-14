import bot_api/bot_state, bot_api/droid, bot_api/internal/bot_internals, bot_api/internal/graphics_state

proc map*(source: BotInternals): BotState =
  ## Maps a BotInternals.
  var botState: BotState

  botState.energy = source.energy
  botState.x = source.x
  botState.y = source.y
  botState.direction = source.direction
  botState.gunDirection = source.gunDirection
  botState.radarDirection = source.radarDirection
  botState.speed = source.speed
  botState.turnRate = source.turnRate
  botState.gunTurnRate = source.gunTurnRate
  botState.radarTurnRate = source.radarTurnRate

  return botState

proc map*(droid: Droid): BotState =
  ## Maps a Droid.
  return map(droid.botInternals)

proc map*(graphicState: GraphicsState): BotState =
  ## Maps a GraphicsState.
  return map(graphicState.botInternals)