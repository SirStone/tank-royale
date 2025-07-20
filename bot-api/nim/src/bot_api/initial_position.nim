## Initial position of a bot (for debugging purposes).

type
  InitialPosition* = object
    x*: float      ## X coordinate
    y*: float      ## Y coordinate  
    direction*: float ## Direction in degrees

proc newInitialPosition*(): InitialPosition =
  ## Creates a new InitialPosition with default values
  result = InitialPosition(x: 0.0, y: 0.0, direction: 0.0)

proc newInitialPosition*(x: float, y: float, direction: float): InitialPosition =
  ## Creates a new InitialPosition with specified values
  result = InitialPosition(x: x, y: y, direction: direction)