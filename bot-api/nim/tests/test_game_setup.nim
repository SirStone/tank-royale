nim
import unittest
import ../src/bot_api/game_setup
import ../src/bot_api/game_type

suite "GameSetup Tests":

  test "Test GameSetup constructor and accessors":
    let gameSetup = GameSetup(
      gameType: GameType.Melee,
      arenaWidth: 800,
      arenaHeight: 600,
      minNumberOfBots: 2,
      maxNumberOfBots: 4,
      numberOfRounds: 10,
      gunCoolDown: 5,
      inactivityTimeLimit: 300,
      roundTimeLimit: 60
    )
    check:
      gameSetup.gameType == GameType.Melee
      gameSetup.arenaWidth == 800
      gameSetup.arenaHeight == 600
      gameSetup.minNumberOfBots == 2
      gameSetup.maxNumberOfBots == 4
      gameSetup.numberOfRounds == 10
      gameSetup.gunCoolDown == 5
      gameSetup.inactivityTimeLimit == 300
      gameSetup.roundTimeLimit == 60

  test "Test GameSetup constructor with default values":
    let gameSetup = GameSetup(
      gameType: GameType.Classic,
      arenaWidth: 1000,
      arenaHeight: 800,
    )
    check:
      gameSetup.gameType == GameType.Classic
      gameSetup.arenaWidth == 1000
      gameSetup.arenaHeight == 800
      gameSetup.minNumberOfBots == 0
      gameSetup.maxNumberOfBots == 0
      gameSetup.numberOfRounds == 0
      gameSetup.gunCoolDown == 0
      gameSetup.inactivityTimeLimit == 0
      gameSetup.roundTimeLimit == 0

  test "Test GameSetup copy method":
    let originalGameSetup = GameSetup(
      gameType: GameType.Melee,
      arenaWidth: 800,
      arenaHeight: 600,
      minNumberOfBots: 2,
      maxNumberOfBots: 4,
      numberOfRounds: 10,
      gunCoolDown: 5,
      inactivityTimeLimit: 300,
      roundTimeLimit: 60
    )
    let copiedGameSetup = originalGameSetup.copy()

    check:
      copiedGameSetup.gameType == originalGameSetup.gameType
      copiedGameSetup.arenaWidth == originalGameSetup.arenaWidth
      copiedGameSetup.arenaHeight == originalGameSetup.arenaHeight
      copiedGameSetup.minNumberOfBots == originalGameSetup.minNumberOfBots
      copiedGameSetup.maxNumberOfBots == originalGameSetup.maxNumberOfBots
      copiedGameSetup.numberOfRounds == originalGameSetup.numberOfRounds
      copiedGameSetup.gunCoolDown == originalGameSetup.gunCoolDown
      copiedGameSetup.inactivityTimeLimit == originalGameSetup.inactivityTimeLimit
      copiedGameSetup.roundTimeLimit == originalGameSetup.roundTimeLimit

  test "Test GameSetup equality":
    let gameSetup1 = GameSetup(
      gameType: GameType.Melee,
      arenaWidth: 800,
      arenaHeight: 600,
      minNumberOfBots: 2,
      maxNumberOfBots: 4,
      numberOfRounds: 10,
      gunCoolDown: 5,
      inactivityTimeLimit: 300,
      roundTimeLimit: 60
    )
    let gameSetup2 = GameSetup(
      gameType: GameType.Melee,
      arenaWidth: 800,
      arenaHeight: 600,
      minNumberOfBots: 2,
      maxNumberOfBots: 4,
      numberOfRounds: 10,
      gunCoolDown: 5,
      inactivityTimeLimit: 300,
      roundTimeLimit: 60
    )
    let gameSetup3 = GameSetup(
      gameType: GameType.Classic,
      arenaWidth: 1000,
      arenaHeight: 800,
      minNumberOfBots: 3,
      maxNumberOfBots: 6,
      numberOfRounds: 15,
      gunCoolDown: 3,
      inactivityTimeLimit: 200,
      roundTimeLimit: 45
    )
    check:
        gameSetup1 == gameSetup2
        gameSetup1 != gameSetup3