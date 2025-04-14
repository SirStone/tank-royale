nim
import std/[sequtils, sets]

proc toSeq*[T](items: varargs[T]): seq[T] =
  ## Converts varargs items to a seq.
  result = items

proc toSeq*[T](items: openArray[T]): seq[T] =
  ## Converts openArray items to a seq.
  result = @items

proc firstOrNil*[T](items: seq[T]): Option[T] =
  ## Returns the first element of a seq or nil if the seq is empty.
  if items.len > 0:
    return some(items[0])
  else:
    return none(T)

proc firstOrNil*[T](items: openArray[T]): Option[T] =
  ## Returns the first element of an openArray or nil if the openArray is empty.
  if items.len > 0:
    return some(items[0])
  else:
    return none(T)

proc toSet*[T](items: varargs[T]): set[T] =
  ## Converts varargs items to a set.
  result = items.toSeq.toHashSet

proc toSet*[T](items: openArray[T]): set[T] =
  ## Converts openArray items to a set.
  result = items.toSeq.toHashSet
