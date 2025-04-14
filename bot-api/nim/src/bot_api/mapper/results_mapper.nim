nim
import bot_api/bot_results, bot_api/util/json_util
import json


proc fromJson*(jsonString: string): BotResults =
  ## Creates a BotResults instance from a JSON string.
  let parsedJson = parseJson(jsonString)

  if not parsedJson.hasKey("rankings") or not parsedJson.hasKey("wins"):
    raise newException(ValueError, "Invalid JSON format for BotResults: missing 'rankings' or 'wins'")

  var rankings: seq[string] = @[]
  if parsedJson["rankings"].kind == JArray:
    for item in parsedJson["rankings"].elems:
      if item.kind == JString:
        rankings.add(item.str)
      else:
        raise newException(ValueError, "Invalid JSON format for BotResults: 'rankings' must be an array of strings")
  else:
    raise newException(ValueError, "Invalid JSON format for BotResults: 'rankings' must be an array")

  var wins: seq[string] = @[]
  if parsedJson["wins"].kind == JArray:
    for item in parsedJson["wins"].elems:
      if item.kind == JString:
        wins.add(item.str)
      else:
        raise newException(ValueError, "Invalid JSON format for BotResults: 'wins' must be an array of strings")
  else:
    raise newException(ValueError, "Invalid JSON format for BotResults: 'wins' must be an array")

  return BotResults(rankings: rankings, wins: wins)

proc toJson*(results: BotResults): string =
  ## Converts a BotResults instance to a JSON string.
  var jsonObject = %* {"rankings": results.rankings, "wins": results.wins}
  return $jsonObject
