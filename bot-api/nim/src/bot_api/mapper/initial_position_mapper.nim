nim
import ../../bot_api/initial_position
import ../../util/json_util
import json

proc map*(jsonString: string): InitialPosition =
  """
  Maps a JSON string to a InitialPosition object.

  Args:
    jsonString: The JSON string to map.

  Returns:
    The InitialPosition object.
  """
  let j = parseJson(jsonString)
  
  if j.kind != JObject:
    raise newException(ValueError, "Invalid JSON object for InitialPosition")

  let
    x = j.getOrDefault("x", -1.0).getFloat()
    y = j.getOrDefault("y", -1.0).getFloat()
    direction = j.getOrDefault("direction", -1.0).getFloat()

  if x == -1.0:
      raise newException(ValueError, "Missing required field: x")

  if y == -1.0:
      raise newException(ValueError, "Missing required field: y")

  if direction == -1.0:
      raise newException(ValueError, "Missing required field: direction")

  result = InitialPosition(x: x, y: y, direction: direction)