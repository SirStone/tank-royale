nim
import std/atomics

type
  EventInterruption* = ref object
    interrupted*: Atomic[bool]

proc newEventInterruption*(): EventInterruption =
  new(result)
  atomicStore(result.interrupted, false)

proc isInterrupted*(this: EventInterruption): bool =
  atomicLoad(this.interrupted)

proc interrupt*(this: EventInterruption) =
  atomicStore(this.interrupted, true)

proc reset*(this: EventInterruption) =
  atomicStore(this.interrupted, false)