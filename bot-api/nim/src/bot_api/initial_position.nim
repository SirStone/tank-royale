import options

type
  InitialPosition* = ref object of RootObj
    x*: Option[float]
    y*: Option[float]

proc `==`*(a, b: InitialPosition): bool =
  if a.isNil or b.isNil:
      return a.isNil and b.isNil
  result = a.x == b.x and a.y == b.y

proc newInitialPosition*(): InitialPosition =
  new(result)

proc newInitialPosition*(x: float, y: float): InitialPosition =
  result = newInitialPosition()
  result.x = some(x)
  result.y = some(y)

proc newInitialPosition*(x: Option[float] = none(float), y: Option[float] = none(float)): InitialPosition = 
    new(result)
    result.x = x
    result.y = y