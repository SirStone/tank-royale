nim
import strutils

type
  BotInfo* = ref object of RootObj
    name*: string
    version*: string
    authors*: seq[string]
    description*: string
    homepage*: string
    countryCodes*: seq[string]
    gameTypes*: seq[string]
    platform*: string
    programmingLang*: string

proc newBotInfo*(name: string, version: string, authors: seq[string], description: string,
                homepage: string, countryCodes: seq[string], gameTypes: seq[string],
                platform: string, programmingLang: string): BotInfo =
  result = BotInfo()
  result.name = name
  result.version = version
  result.authors = authors
  result.description = description
  result.homepage = homepage
  result.countryCodes = countryCodes
  result.gameTypes = gameTypes
  result.platform = platform
  result.programmingLang = programmingLang

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