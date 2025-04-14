

import sequtils

type
  DefaultEventPriority* = distinct int

const
  Normal* = DefaultEventPriority(0)
  High* = DefaultEventPriority(1)
  Highest* = DefaultEventPriority(2)
  Low* = DefaultEventPriority(-1)
  Lowest* = DefaultEventPriority(-2)



proc fromInt*(value: int): DefaultEventPriority =
  case value
  of 0:
    result = Normal
  of 1:
    result = High
  of 2:
    result = Highest
  of -1:
    result = Low
  of -2:
    result = Lowest
  else:
    raise newException(ValueError, "Invalid DefaultEventPriority value: " & $value)

proc toInt*(priority: DefaultEventPriority): int =
  priority.int

proc toString*(priority: DefaultEventPriority): string =
  case priority
  of Normal: "Normal"
  of High: "High"
  of Highest: "Highest"
  of Low: "Low"
  of Lowest: "Lowest"