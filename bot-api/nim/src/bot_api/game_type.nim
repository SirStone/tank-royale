import strutils

type
  GameType* = enum
    classic, melee, oneVsOne, freeForAll, unknown

proc toString*(gameType: GameType): string =
  case gameType
  of classic: result = "CLASSIC"
  of melee: result = "MELEE"
  of oneVsOne: result = "1V1"
  of freeForAll: result = "FREE_FOR_ALL"
  of unknown: result = "UNKNOWN"

proc fromString*(gameTypeString: string): GameType =
  let upperCase = toUpper(gameTypeString)
  if upperCase == "CLASSIC": result = classic
  elif upperCase == "MELEE": result = melee
  elif upperCase == "1V1": result = oneVsOne
  elif upperCase == "FREE_FOR_ALL": result = freeForAll
  else: result = unknown
