nim
import json, strutils, sequtils

type
  JsonObject = JsonNode
  JsonArray = seq[JsonNode] #Array[JsonNode]

proc parse*(text: string): JsonNode =
  try:
    result = parseJson(text)
  except JsonError:
    raise newException(ValueError, "Invalid JSON string: " & text)

proc stringify*(json: JsonNode): string =
  result = json.pretty()

proc getJsonObject*(json: JsonNode): JsonObject =
    if json.kind == JObject:
        result = json
    else:
        raise newException(ValueError, "Not a JsonObject")

proc get*(json: JsonObject, key: string): JsonNode =
  if not json.hasKey(key):
    raise newException(KeyError, "Key '" & key & "' not found in JSON object")
  result = json[key]

proc getJsonArray*(json: JsonNode): JsonArray =
  if json.kind == JArray:
      result = json.getElems
  else:
    raise newException(ValueError, "Not a JsonArray")
    
proc get*(json: JsonArray, index: int): JsonNode = json[index]

proc getInt*(json: JsonNode): int =
    if json.kind == JInt:
      result = json.getInt
    else:
      raise newException(ValueError, "Not a integer")

proc getBool*(json: JsonNode): bool =
    if json.kind == JBool:
      result = json.getBool
    else:
      raise newException(ValueError, "Not a boolean")

proc getFloat*(json: JsonNode): float =
    if json.kind == JFloat:
      result = json.getFloat
    else:
      raise newException(ValueError, "Not a float")

proc getString*(json: JsonNode): string =
  if json.kind == JString:
    result = json.getStr
  else:
    raise newException(ValueError, "Not a String")

proc getJsonObject*(json: JsonNode): JsonObject =
  if json.kind == JObject:
    result = json
  else:
    raise newException(ValueError, "Not a JsonObject")

proc getJsonArray*(json: JsonNode): JsonArray =
    if json.kind == JArray:
        result = json.getElems
    else:
      raise newException(ValueError, "Not a JsonArray")

proc toJsonObject*(obj: openArray[(string, JsonNode)]): JsonObject =
    for k, v in obj:
        result[k] = v