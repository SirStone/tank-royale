nim
import bot_api/base_bot
import json
import times
import math
import random

type
  Bot* = ref object of BaseBot
    # Add bot-specific fields here if needed
    name*: string
    myId*: int
    
    energy*: float
    x*: float
    y*: float
    direction*: float
    gunDirection*: float
    radarDirection*: float
    speed*: float
    
    turnNumber*: int
    roundNumber*: int
    
    isPaused*: bool
    isResumed*: bool
    
    scanFieldWidth*: float
    scanFieldHeight*: float

proc `newBot`*(name: string): Bot =
  ## Constructor for the Bot type
  new(result)
  result.name = name
  result.myId = -1

  result.onConnected = proc (self: BaseBot) =
    echo "Connected to server"
  
  result.onDisconnected = proc (self: BaseBot) =
      echo "Disconnected from server"

  result.onGameStarted = proc (self: BaseBot) (gameStartedEvent: JsonNode)=
      echo "Game started"
      
      let gameSetup = gameStartedEvent["gameSetup"]
      self.scanFieldWidth = gameSetup["arena"]["width"].getFloat()
      self.scanFieldHeight = gameSetup["arena"]["height"].getFloat()
  
  result.onGameEnded = proc (self: BaseBot) (gameEndedEvent: JsonNode) =
    echo "Game ended"
  
  result.onRoundStarted = proc (self: BaseBot) (roundStartedEvent: JsonNode) =
    echo "Round started"
    self.roundNumber = roundStartedEvent["roundNumber"].getInt()

  result.onRoundEnded = proc (self: BaseBot) (roundEndedEvent: JsonNode) =
    echo "Round ended"

  result.onTick = proc (self: BaseBot) (tickEvent: JsonNode) =
    if self.myId < 0:
      self.myId = tickEvent["myId"].getInt()
    self.turnNumber = tickEvent["turnNumber"].getInt()

    var botStateFound: bool = false
    for botState in tickEvent["botStates"].getElems():
      if botState["id"].getInt() == self.myId:
        self.energy = botState["energy"].getFloat()
        self.x = botState["x"].getFloat()
        self.y = botState["y"].getFloat()
        self.direction = botState["direction"].getFloat()
        self.gunDirection = botState["gunDirection"].getFloat()
        self.radarDirection = botState["radarDirection"].getFloat()
        self.speed = botState["speed"].getFloat()
        botStateFound = true
    
    if not botStateFound:
        echo "Bot state not found for id: ", self.myId

  result.onScannedBot = proc (self: BaseBot) (scannedBotEvent: JsonNode) =
    echo "Scanned bot"
  
  result.onHitBot = proc (self: BaseBot) (hitBotEvent: JsonNode) =
    echo "Hit bot"

  result.onHitByBullet = proc (self: BaseBot) (hitByBulletEvent: JsonNode) =
    echo "Hit by bullet"
  
  result.onHitWall = proc (self: BaseBot) (hitWallEvent: JsonNode) =
    echo "Hit wall"

  result.onBulletFired = proc (self: BaseBot) (bulletFiredEvent: JsonNode) =
    echo "Bullet fired"

  result.onBulletHitBot = proc (self: BaseBot) (bulletHitBotEvent: JsonNode) =
    echo "Bullet hit bot"

  result.onBulletHitBullet = proc (self: BaseBot) (bulletHitBulletEvent: JsonNode) =
    echo "Bullet hit bullet"

  result.onBulletHitWall = proc (self: BaseBot) (bulletHitWallEvent: JsonNode) =
    echo "Bullet hit wall"

  result.onSkippedTurn = proc (self: BaseBot) (skippedTurnEvent: JsonNode) =
    echo "Skipped turn"

  result.onBotDeath = proc (self: BaseBot) (botDeathEvent: JsonNode) =
    echo "Bot death"

  result.onWonRound = proc (self: BaseBot) (wonRoundEvent: JsonNode) =
    echo "Won round"

  result.onTeamMessage = proc (self: BaseBot) (teamMessageEvent: JsonNode) =
    echo "Team message"

proc forward*(bot: Bot, distance: float) =
    ## Move forward by the specified distance.
    var intent: JsonNode = %* {"type":"bot-intent", "target":bot.myId}
    if intent.hasKey("target"):
      intent["move"] = %* {"distance":distance}
      bot.sendIntent(intent)
    else:
        echo "Intent don't have target"

proc backward*(bot: Bot, distance: float) =
    ## Move backward by the specified distance.
    bot.forward(-distance)

proc turnLeft*(bot: Bot, degrees: float) =
    ## Turn left by the specified degrees.
    var intent: JsonNode = %* {"type":"bot-intent", "target":bot.myId}
    if intent.hasKey("target"):
      intent["turn"] = %* {"degrees":degrees}
      bot.sendIntent(intent)
    else:
      echo "Intent don't have target"

proc turnRight*(bot: Bot, degrees: float) =
    ## Turn right by the specified degrees.
    bot.turnLeft(-degrees)

proc turnGunLeft*(bot: Bot, degrees: float) =
    ## Turn the gun left by the specified degrees.
    var intent: JsonNode = %* {"type":"bot-intent", "target":bot.myId}
    if intent.hasKey("target"):
        intent["gunTurn"] = %* {"degrees":degrees}
        bot.sendIntent(intent)
    else:
        echo "Intent don't have target"
    
proc turnGunRight*(bot: Bot, degrees: float) =
    ## Turn the gun right by the specified degrees.
    bot.turnGunLeft(-degrees)

proc turnRadarLeft*(bot: Bot, degrees: float) =
    ## Turn the radar left by the specified degrees.
    var intent: JsonNode = %* {"type":"bot-intent", "target":bot.myId}
    if intent.hasKey("target"):
        intent["radarTurn"] = %* {"degrees":degrees}
        bot.sendIntent(intent)
    else:
        echo "Intent don't have target"

proc turnRadarRight*(bot: Bot, degrees: float) =
    ## Turn the radar right by the specified degrees.
    bot.turnRadarLeft(-degrees)

proc fire*(bot: Bot, firepower: float) =
    ## Fire the gun with the specified firepower.
    var intent: JsonNode = %* {"type":"bot-intent", "target":bot.myId}
    if intent.hasKey("target"):
        intent["fire"] = %* {"power":firepower}
        bot.sendIntent(intent)
    else:
        echo "Intent don't have target"

proc stop*(bot: Bot) =
  ## Stop the bot's movement.
  bot.forward(0)

proc resume*(bot: Bot) =
    ## Resume the bot's movement after a stop.
    bot.isResumed = true

proc isResumed*(bot: Bot): bool =
    ## Check if the bot's movement is resumed.
    return bot.isResumed

proc isPaused*(bot: Bot): bool =
    ## Check if the bot's movement is paused.
    return bot.isPaused

proc pause*(bot: Bot) =
    ## Pause the bot's movement.
    bot.isPaused = true

proc waitFor*(bot: Bot, condition: proc(bot:Bot):bool, timeout: int) =
    ## Wait for a condition to be true or a timeout to occur.
    var startTime = epochTime()
    while not condition(bot) and epochTime() - startTime < timeout:
        sleep(10)
    if not condition(bot):
        echo "Timeout waiting for condition"

proc getRandom*(bot: Bot, min: float, max:float): float =
    ## Generate a random float number between min and max
    return (max - min) * rand(1.0) + min