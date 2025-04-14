import ./default_event_priority, std/tables

type
  EventPriorities* = ref object of RootObj
    priorities*: Table[string, DefaultEventPriority]

proc initEventPriorities*(): EventPriorities =
  new(result)
  result.priorities = initTable[string, DefaultEventPriority]()

proc add*(ep: EventPriorities, eventType: string, priority: DefaultEventPriority) =
  ep.priorities[eventType] = priority

proc get*(ep: EventPriorities, eventType: string): DefaultEventPriority =
  if ep.priorities.hasKey(eventType):
    return ep.priorities[eventType]
  else:
    return DefaultEventPriority.last

proc clear*(ep: EventPriorities) =
  ep.priorities.clear()

proc isEmpty*(ep: EventPriorities): bool =
  return ep.priorities.len == 0
