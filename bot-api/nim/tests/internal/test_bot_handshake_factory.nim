nim
import unittest
import ../src/bot_api/internal/bot_handshake_factory
import ../src/bot_api/bot_info
import ../src/bot_api/droid
import ../src/bot_api/game_type
import ../src/bot_api/game_setup

suite "BotHandshakeFactory Tests":
  test "Create Handshake String - No Droid":
    let botInfo = BotInfo(name: "TestBot", version: "1.0", authors: ["Test Author"], countryCodes: ["US"])
    let gameSetup = GameSetup(gameType: GameType.Classic, arenaWidth: 800, arenaHeight: 600, minNumberOfBots: 2, maxNumberOfBots: 4, numberOfRounds: 10)
    let handshakeFactory = BotHandshakeFactory()

    let handshakeString = handshakeFactory.createHandshakeString(botInfo, gameSetup, @[])
    check handshakeString == "TestBot;1.0;Test Author;US;Classic;800;600;2;4;10;"

  test "Create Handshake String - With Droids":
    let botInfo = BotInfo(name: "TestBot", version: "1.0", authors: ["Test Author"], countryCodes: ["US"])
    let gameSetup = GameSetup(gameType: GameType.Classic, arenaWidth: 800, arenaHeight: 600, minNumberOfBots: 2, maxNumberOfBots: 4, numberOfRounds: 10)
    let droids = @[
      Droid(name: "Droid1", version: "1.1", authors: ["Droid Author 1"], countryCodes: ["CA"], programmingLang: "Nim", description: "Test Droid 1"),
      Droid(name: "Droid2", version: "1.2", authors: ["Droid Author 2"], countryCodes: ["GB"], programmingLang: "Java", description: "Test Droid 2")
    ]
    let handshakeFactory = BotHandshakeFactory()

    let handshakeString = handshakeFactory.createHandshakeString(botInfo, gameSetup, droids)
    check handshakeString == "TestBot;1.0;Test Author;US;Classic;800;600;2;4;10;Droid1;1.1;Droid Author 1;CA;Nim;Test Droid 1;;Droid2;1.2;Droid Author 2;GB;Java;Test Droid 2;"

  test "Create Handshake String - Empty Values":
    let botInfo = BotInfo(name: "", version: "", authors: [], countryCodes: [])
    let gameSetup = GameSetup(gameType: GameType.Melee, arenaWidth: 0, arenaHeight: 0, minNumberOfBots: 0, maxNumberOfBots: 0, numberOfRounds: 0)
    let handshakeFactory = BotHandshakeFactory()

    let handshakeString = handshakeFactory.createHandshakeString(botInfo, gameSetup, @[])
    check handshakeString == ";;;;Melee;0;0;0;0;0;"

  test "Create Handshake String - Long Values":
    let botInfo = BotInfo(name: "ThisIsALongBotName", version: "999.999.999", authors: ["Author1", "Author2", "Author3"], countryCodes: ["US", "CA", "GB", "AU"])
    let gameSetup = GameSetup(gameType: GameType.Classic, arenaWidth: 9999, arenaHeight: 9999, minNumberOfBots: 99, maxNumberOfBots: 999, numberOfRounds: 9999)
    let droids = @[
      Droid(name: "LongDroid1", version: "1.1", authors: ["Droid Author A"], countryCodes: ["CA"], programmingLang: "Nim", description: "Test Droid A"),
      Droid(name: "LongDroid2", version: "1.2", authors: ["Droid Author B"], countryCodes: ["GB"], programmingLang: "Java", description: "Test Droid B. This is a long description.")
    ]
    let handshakeFactory = BotHandshakeFactory()

    let handshakeString = handshakeFactory.createHandshakeString(botInfo, gameSetup, droids)
    check handshakeString == "ThisIsALongBotName;999.999.999;Author1, Author2, Author3;US,CA,GB,AU;Classic;9999;9999;99;999;9999;LongDroid1;1.1;Droid Author A;CA;Nim;Test Droid A;;LongDroid2;1.2;Droid Author B;GB;Java;Test Droid B. This is a long description.;"