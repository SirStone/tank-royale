## Bot information that must be provided when creating a bot.
## This information is used to identify the bot in the game.

import initial_position

type
  BotInfo* = object
    ## Information about the bot
    name*: string               ## Name of the bot (required)
    version*: string            ## Version of the bot (required) 
    authors*: seq[string]       ## Authors of the bot (required)
    description*: string        ## Description of the bot (optional)
    homepage*: string           ## Homepage URL for the bot (optional)
    countryCodes*: seq[string]  ## Country codes (ISO 3166-1 alpha-2) (optional)
    gameTypes*: seq[string]     ## Game types supported by this bot (optional)
    platform*: string          ## Platform running the bot (optional)
    programmingLang*: string    ## Programming language used (optional)
    initialPosition*: InitialPosition  ## Initial position (optional, for debugging)

proc newBotInfo*(name: string, version: string, authors: seq[string]): BotInfo =
  ## Creates a new BotInfo with required fields only
  result = BotInfo(
    name: name,
    version: version,
    authors: authors,
    description: "",
    homepage: "",
    countryCodes: @[],
    gameTypes: @[],
    platform: "Nim",
    programmingLang: "Nim"
  )

proc newBotInfo*(name: string, version: string, authors: seq[string], 
                 description: string, homepage: string, countryCodes: seq[string], 
                 gameTypes: seq[string], platform: string, programmingLang: string): BotInfo =
  ## Creates a new BotInfo with all fields
  result = BotInfo(
    name: name,
    version: version,
    authors: authors,
    description: description,
    homepage: homepage,
    countryCodes: countryCodes,
    gameTypes: gameTypes,
    platform: platform,
    programmingLang: programmingLang
  )

proc getName*(botInfo: BotInfo): string =
  botInfo.name

proc getVersion*(botInfo: BotInfo): string =
  botInfo.version

proc getAuthors*(botInfo: BotInfo): seq[string] =
  botInfo.authors

proc getDescription*(botInfo: BotInfo): string =
  botInfo.description

proc getHomepage*(botInfo: BotInfo): string =
  botInfo.homepage

proc getCountryCodes*(botInfo: BotInfo): seq[string] =
  botInfo.countryCodes

proc getGameTypes*(botInfo: BotInfo): seq[string] =
  botInfo.gameTypes

proc getPlatform*(botInfo: BotInfo): string =
  botInfo.platform
  
proc getProgrammingLang*(botInfo: BotInfo): string =
  botInfo.programmingLang

proc toString*(botInfo: BotInfo): string =
  var resultStr = ""
  resultStr.add("BotInfo {" & "\n")
  resultStr.add("  name='" & botInfo.name & "'" & "\n")
  resultStr.add("  version='" & botInfo.version & "'" & "\n")
  resultStr.add("  authors=[")
  for i, author in botInfo.authors:
    resultStr.add("'" & author & "'")
    if i < botInfo.authors.len - 1:
      resultStr.add(", ")
  resultStr.add("]" & "\n")
  resultStr.add("  description='" & botInfo.description & "'" & "\n")
  resultStr.add("  homepage='" & botInfo.homepage & "'" & "\n")
  resultStr.add("  countryCodes=[")
  for i, countryCode in botInfo.countryCodes:
    resultStr.add("'" & countryCode & "'")
    if i < botInfo.countryCodes.len - 1:
      resultStr.add(", ")
  resultStr.add("]" & "\n")
  resultStr.add("  gameTypes=[")
  for i, gameType in botInfo.gameTypes:
    resultStr.add("'" & gameType & "'")
    if i < botInfo.gameTypes.len - 1:
      resultStr.add(", ")
  resultStr.add("]" & "\n")
  resultStr.add("  platform='" & botInfo.platform & "'" & "\n")
  resultStr.add("  programmingLang='" & botInfo.programmingLang & "'" & "\n")
  resultStr.add("}")
  result = resultStr

proc equals*(a, b: BotInfo): bool =
    (a.name == b.name) and (a.version == b.version) and (a.authors == b.authors) and (a.description == b.description) and
    (a.homepage == b.homepage) and (a.countryCodes == b.countryCodes) and (a.gameTypes == b.gameTypes) and (a.platform == b.platform) and (a.programmingLang == b.programmingLang)