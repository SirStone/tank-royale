nim
import os
import strutils

type
  EnvVars = ref object
    gameType: string
    gameSetup: string
    botName: string
    botVersion: string
    botAuthors: seq[string]
    botDescription: string
    botUrl: string
    countryCodes: seq[string]
    botProgrammingLang: string
    initialPosition: string
    serverUrl: string
    serverSecret: string
    debug: bool
    tournament: bool
    
proc newEnvVars*(): EnvVars =
  result = EnvVars()

  result.gameType = getEnv("GAME_TYPE", "")
  if result.gameType.len == 0:
      raise newException(ValueError, "Missing environment variable: GAME_TYPE")
  result.gameSetup = getEnv("GAME_SETUP", "")
  if result.gameSetup.len == 0:
      raise newException(ValueError, "Missing environment variable: GAME_SETUP")
  result.botName = getEnv("BOT_NAME", "")
  if result.botName.len == 0:
      raise newException(ValueError, "Missing environment variable: BOT_NAME")
  result.botVersion = getEnv("BOT_VERSION", "")
  if result.botVersion.len == 0:
      raise newException(ValueError, "Missing environment variable: BOT_VERSION")
  result.botAuthors = split(getEnv("BOT_AUTHORS", ""), ',') # can be empty
  result.botDescription = getEnv("BOT_DESCRIPTION", "") # can be empty
  result.botUrl = getEnv("BOT_URL", "") # can be empty
  result.countryCodes = split(getEnv("COUNTRY_CODES", ""), ',') # can be empty
  result.botProgrammingLang = getEnv("BOT_PROGRAMMING_LANG", "")
  if result.botProgrammingLang.len == 0:
      raise newException(ValueError, "Missing environment variable: BOT_PROGRAMMING_LANG")
  result.initialPosition = getEnv("INITIAL_POSITION", "") # can be empty
  result.serverUrl = getEnv("SERVER_URL", "")
  if result.serverUrl.len == 0:
      raise newException(ValueError, "Missing environment variable: SERVER_URL")
  result.serverSecret = getEnv("SERVER_SECRET", "")
  if result.serverSecret.len == 0:
      raise newException(ValueError, "Missing environment variable: SERVER_SECRET")
  result.debug = getEnv("DEBUG", "false").toLowerAscii() == "true" # default is false
  result.tournament = getEnv("TOURNAMENT", "false").toLowerAscii() == "true" # default is false