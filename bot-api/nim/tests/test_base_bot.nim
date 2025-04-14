nim
import unittest
import ../bot_api/base_bot
import ../bot_api/internal/bot_internals
import ../bot_api/internal/base_bot_internals
import ../bot_api/internal/event_queue
import ../bot_api/events/i_event
import ../bot_api/events/tick_event
import ../bot_api/events/round_started_event
import ../bot_api/events/game_started_event
import ../bot_api/events/bot_event
import ../bot_api/events/bot_death_event
import ../bot_api/events/scanned_bot_event
import ../bot_api/events/connection_event
import ../bot_api/events/custom_event
import ../bot_api/events/connection_error_event
import ../bot_api/events/disconnected_event
import ../bot_api/events/death_event
import ../bot_api/events/game_ended_event
import ../bot_api/events/hit_by_bullet_event
import ../bot_api/events/hit_wall_event
import ../bot_api/events/hit_bot_event
import ../bot_api/events/round_ended_event
import ../bot_api/events/won_round_event
import ../bot_api/events/skipped_turn_event
import ../bot_api/events/team_message_event
import ../bot_api/events/bullet_fired_event
import ../bot_api/events/bullet_hit_bot_event
import ../bot_api/events/bullet_hit_bullet_event
import ../bot_api/events/bullet_hit_wall_event
import ../bot_api/events/connected_event
import ../bot_api/internal/recording_text_writer
import ../bot_api/bot_info
import ../bot_api/bot_results
import ../bot_api/bot_exception
import ../bot_api/constants
import ../bot_api/util/math_util

suite "BaseBot Tests":
  var bot: BaseBot

  setup:
    bot = BaseBot()

  test "Test run method":
    bot.run()

  test "Test onBotDeath":
    let event = BotDeathEvent(botId: 1)
    bot.onBotDeath(event)

  test "Test onScannedBot":
    let event = ScannedBotEvent(scannedByBotId: 1, scannedBotId: 2, energy: 10.0, x: 100.0, y: 200.0, direction: 90.0, velocity: 5.0)
    bot.onScannedBot(event)

  test "Test onTick":
    let event = TickEvent(tick: 1)
    bot.onTick(event)

  test "Test onRoundStarted":
    let event = RoundStartedEvent(roundNumber: 1)
    bot.onRoundStarted(event)

  test "Test onGameStarted":
    let event = GameStartedEvent(gameSetup: defaultGameSetup)
    bot.onGameStarted(event)

  test "Test onConnection":
    let event = ConnectionEvent()
    bot.onConnection(event)

  test "Test onCustomEvent":
    let event = CustomEvent(key: "test", value: "test value")
    bot.onCustomEvent(event)

  test "Test onConnectionError":
    let event = ConnectionErrorEvent()
    bot.onConnectionError(event)

  test "Test onDisconnected":
    let event = DisconnectedEvent()
    bot.onDisconnected(event)

  test "Test onDeath":
    let event = DeathEvent()
    bot.onDeath(event)

  test "Test onGameEnded":
    let event = GameEndedEvent(gameResults: BotResults())
    bot.onGameEnded(event)

  test "Test onHitByBullet":
    let event = HitByBulletEvent(bullet: defaultBulletState, energy: 10.0)
    bot.onHitByBullet(event)

  test "Test onHitWall":
    let event = HitWallEvent(x: 10.0, y: 10.0)
    bot.onHitWall(event)

  test "Test onHitBot":
    let event = HitBotEvent(botId: 1, energy: 10.0, x: 100.0, y: 200.0, direction: 90.0, velocity: 5.0)
    bot.onHitBot(event)

  test "Test onRoundEnded":
    let event = RoundEndedEvent(roundNumber: 1)
    bot.onRoundEnded(event)

  test "Test onWonRound":
    let event = WonRoundEvent(roundNumber: 1)
    bot.onWonRound(event)

  test "Test onSkippedTurn":
    let event = SkippedTurnEvent()
    bot.onSkippedTurn(event)

  test "Test onTeamMessage":
    let event = TeamMessageEvent(message: "hello", senderId: 1)
    bot.onTeamMessage(event)

  test "Test onBulletFired":
    let event = BulletFiredEvent(bullet: defaultBulletState)
    bot.onBulletFired(event)

  test "Test onBulletHitBot":
    let event = BulletHitBotEvent(bullet: defaultBulletState, botId: 1, damage: 10.0, energy: 10.0)
    bot.onBulletHitBot(event)

  test "Test onBulletHitBullet":
    let event = BulletHitBulletEvent(bullet: defaultBulletState, hitBullet: defaultBulletState)
    bot.onBulletHitBullet(event)

  test "Test onBulletHitWall":
    let event = BulletHitWallEvent(bullet: defaultBulletState)
    bot.onBulletHitWall(event)
  
  test "Test onConnected":
    let event = ConnectedEvent()
    bot.onConnected(event)

  test "Test start":
      bot.start()