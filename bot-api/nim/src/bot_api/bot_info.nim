## Bot information that must be provided when creating a bot.
## This information is used to identify the bot in the game.

import initial_position, json, os, strutils

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

proc fromJsonFile*(filePath: string): BotInfo =
  ## Reads bot information from a JSON configuration file
  ## Similar to .NET BotInfo.FromFile() and Java BotInfo.fromFile()
  ##
  ## Example JSON format:
  ## {
  ##   "name": "MyFirstBot",
  ##   "version": "1.0.0",
  ##   "authors": ["Author 1", "Author 2"],
  ##   "description": "Bot description",
  ##   "homepage": "https://example.com",
  ##   "countryCodes": ["US", "UK"],
  ##   "gameTypes": ["classic", "melee"],
  ##   "platform": "Nim",
  ##   "programmingLang": "Nim",
  ##   "initialPosition": null
  ## }
  if not fileExists(filePath):
    raise newException(IOError, "Bot configuration file not found: " & filePath)
  
  let jsonContent = readFile(filePath)
  let jsonNode = parseJson(jsonContent)
  
  # Validate required fields
  if not jsonNode.hasKey("name") or jsonNode["name"].kind != JString or jsonNode["name"].getStr().strip() == "":
    raise newException(ValueError, "Required field 'name' is missing or empty in JSON configuration")
  
  if not jsonNode.hasKey("version") or jsonNode["version"].kind != JString or jsonNode["version"].getStr().strip() == "":
    raise newException(ValueError, "Required field 'version' is missing or empty in JSON configuration")
  
  if not jsonNode.hasKey("authors") or jsonNode["authors"].kind != JArray or jsonNode["authors"].len == 0:
    raise newException(ValueError, "Required field 'authors' is missing or empty in JSON configuration")
  
  # Extract required fields
  let name = jsonNode["name"].getStr().strip()
  let version = jsonNode["version"].getStr().strip()
  
  var authors: seq[string] = @[]
  for authorNode in jsonNode["authors"]:
    if authorNode.kind == JString:
      let author = authorNode.getStr().strip()
      if author.len > 0:
        authors.add(author)
  
  if authors.len == 0:
    raise newException(ValueError, "At least one non-empty author is required in JSON configuration")
  
  # Extract optional fields with defaults
  let description = if jsonNode.hasKey("description") and jsonNode["description"].kind == JString: 
                     jsonNode["description"].getStr() else: ""
  
  let homepage = if jsonNode.hasKey("homepage") and jsonNode["homepage"].kind == JString: 
                  jsonNode["homepage"].getStr() else: ""
  
  var countryCodes: seq[string] = @[]
  if jsonNode.hasKey("countryCodes") and jsonNode["countryCodes"].kind == JArray:
    for countryNode in jsonNode["countryCodes"]:
      if countryNode.kind == JString:
        let country = countryNode.getStr().strip()
        if country.len > 0:
          countryCodes.add(country.toUpperAscii())
  
  var gameTypes: seq[string] = @[]
  if jsonNode.hasKey("gameTypes") and jsonNode["gameTypes"].kind == JArray:
    for gameTypeNode in jsonNode["gameTypes"]:
      if gameTypeNode.kind == JString:
        let gameType = gameTypeNode.getStr().strip()
        if gameType.len > 0:
          gameTypes.add(gameType)
  
  let platform = if jsonNode.hasKey("platform") and jsonNode["platform"].kind == JString: 
                  jsonNode["platform"].getStr() else: "Nim"
  
  let programmingLang = if jsonNode.hasKey("programmingLang") and jsonNode["programmingLang"].kind == JString: 
                        jsonNode["programmingLang"].getStr() else: "Nim"
  
  # Handle initialPosition (currently just set to default)
  var initialPos: InitialPosition
  if jsonNode.hasKey("initialPosition") and jsonNode["initialPosition"].kind != JNull:
    # For now, we'll just use default. Could be enhanced later.
    initialPos = InitialPosition()
  else:
    initialPos = InitialPosition()
  
  result = BotInfo(
    name: name,
    version: version,
    authors: authors,
    description: description,
    homepage: homepage,
    countryCodes: countryCodes,
    gameTypes: gameTypes,
    platform: platform,
    programmingLang: programmingLang,
    initialPosition: initialPos
  )

proc fromJsonString*(jsonContent: string): BotInfo =
  ## Reads bot information from a JSON string
  ## Useful for testing or when JSON content is provided directly
  let jsonNode = parseJson(jsonContent)
  
  # Use same validation logic as fromJsonFile but with string input
  if not jsonNode.hasKey("name") or jsonNode["name"].kind != JString or jsonNode["name"].getStr().strip() == "":
    raise newException(ValueError, "Required field 'name' is missing or empty in JSON configuration")
  
  if not jsonNode.hasKey("version") or jsonNode["version"].kind != JString or jsonNode["version"].getStr().strip() == "":
    raise newException(ValueError, "Required field 'version' is missing or empty in JSON configuration")
  
  if not jsonNode.hasKey("authors") or jsonNode["authors"].kind != JArray or jsonNode["authors"].len == 0:
    raise newException(ValueError, "Required field 'authors' is missing or empty in JSON configuration")
  
  # Extract fields using same logic as fromJsonFile
  let name = jsonNode["name"].getStr().strip()
  let version = jsonNode["version"].getStr().strip()
  
  var authors: seq[string] = @[]
  for authorNode in jsonNode["authors"]:
    if authorNode.kind == JString:
      let author = authorNode.getStr().strip()
      if author.len > 0:
        authors.add(author)
  
  if authors.len == 0:
    raise newException(ValueError, "At least one non-empty author is required in JSON configuration")
  
  let description = if jsonNode.hasKey("description") and jsonNode["description"].kind == JString: 
                     jsonNode["description"].getStr() else: ""
  
  let homepage = if jsonNode.hasKey("homepage") and jsonNode["homepage"].kind == JString: 
                  jsonNode["homepage"].getStr() else: ""
  
  var countryCodes: seq[string] = @[]
  if jsonNode.hasKey("countryCodes") and jsonNode["countryCodes"].kind == JArray:
    for countryNode in jsonNode["countryCodes"]:
      if countryNode.kind == JString:
        let country = countryNode.getStr().strip()
        if country.len > 0:
          countryCodes.add(country.toUpperAscii())
  
  var gameTypes: seq[string] = @[]
  if jsonNode.hasKey("gameTypes") and jsonNode["gameTypes"].kind == JArray:
    for gameTypeNode in jsonNode["gameTypes"]:
      if gameTypeNode.kind == JString:
        let gameType = gameTypeNode.getStr().strip()
        if gameType.len > 0:
          gameTypes.add(gameType)
  
  let platform = if jsonNode.hasKey("platform") and jsonNode["platform"].kind == JString: 
                  jsonNode["platform"].getStr() else: "Nim"
  
  let programmingLang = if jsonNode.hasKey("programmingLang") and jsonNode["programmingLang"].kind == JString: 
                        jsonNode["programmingLang"].getStr() else: "Nim"
  
  var initialPos: InitialPosition
  if jsonNode.hasKey("initialPosition") and jsonNode["initialPosition"].kind != JNull:
    initialPos = InitialPosition()
  else:
    initialPos = InitialPosition()
  
  result = BotInfo(
    name: name,
    version: version,
    authors: authors,
    description: description,
    homepage: homepage,
    countryCodes: countryCodes,
    gameTypes: gameTypes,
    platform: platform,
    programmingLang: programmingLang,
    initialPosition: initialPos
  )

proc tryFromJsonFile*(filePath: string): BotInfo =
  ## Attempts to read bot information from JSON file
  ## Returns a default BotInfo if file is not found or invalid
  ## Similar to .NET BaseBot constructor behavior
  try:
    result = fromJsonFile(filePath)
  except IOError, ValueError:
    # Return default BotInfo if JSON loading fails
    # This matches .NET behavior where it falls back to environment variables
    result = newBotInfo("DefaultBot", "1.0", @["Unknown"])

proc autoLoadFromFile*(botTypeName: string): BotInfo =
  ## Automatically loads bot configuration from {botTypeName}.json
  ## Similar to .NET BaseBot() constructor automatic loading
  ## 
  ## Searches in:
  ## 1. Current directory: {botTypeName}.json
  ## 2. Same directory as bot executable (if different)
  let jsonFileName = botTypeName & ".json"
  
  # Try current directory first
  if fileExists(jsonFileName):
    return fromJsonFile(jsonFileName)
  
  # Try same directory as the current executable
  let exeDir = getCurrentDir()
  let exePath = joinPath(exeDir, jsonFileName)
  if fileExists(exePath):
    return fromJsonFile(exePath)
  
  # Return default if no configuration found
  return newBotInfo(botTypeName, "1.0", @["Unknown"])