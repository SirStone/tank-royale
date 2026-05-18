## Event queue for Robocode Tank Royale bot API.
## Stores pending events, sorts by priority, dispatches to handlers.

import std/[algorithm, tables]
import ./constants

type
  EventKind* = enum
    ekTick
    ekRoundStarted
    ekRoundEnded
    ekGameStarted
    ekGameEnded
    ekGameAborted
    ekSkippedTurn
    ekBotDeath
    ekBulletFired
    ekBulletHitBot
    ekBulletHitBullet
    ekBulletHitWall
    ekHitByBullet
    ekHitBot
    ekHitWall
    ekScannedBot
    ekWonRound
    ekTeamMessage
    ekCustom

  QueuedEvent* = object
    kind*:       EventKind
    turnNumber*: int
    priority*:   int
    isCritical*: bool
    data*:       pointer  # owned; caller must manage lifetime — kept as RootRef

  EventQueue* = object
    events*:   seq[QueuedEvent]
    interruptible*: Table[EventKind, bool]
    currentTopEventKind*: EventKind
    currentTopPriority*:  int

# Priority lookup table
proc priorityOf*(kind: EventKind): int =
  case kind
  of ekTick:             PRIORITY_TICK
  of ekRoundStarted:     PRIORITY_TICK        # handled immediately
  of ekRoundEnded:       PRIORITY_TICK
  of ekGameStarted:      PRIORITY_TICK
  of ekGameEnded:        PRIORITY_TICK
  of ekGameAborted:      PRIORITY_TICK
  of ekSkippedTurn:      PRIORITY_SKIPPED_TURN
  of ekBotDeath:         PRIORITY_BOT_DEATH
  of ekBulletFired:      PRIORITY_BULLET_FIRED
  of ekBulletHitBot:     PRIORITY_BULLET_HIT_BOT
  of ekBulletHitBullet:  PRIORITY_BULLET_HIT_BULLET
  of ekBulletHitWall:    PRIORITY_BULLET_HIT_WALL
  of ekHitByBullet:      PRIORITY_HIT_BY_BULLET
  of ekHitBot:           PRIORITY_HIT_BOT
  of ekHitWall:          PRIORITY_HIT_WALL
  of ekScannedBot:       PRIORITY_SCANNED_BOT
  of ekWonRound:         PRIORITY_WON_ROUND
  of ekTeamMessage:      PRIORITY_TEAM_MESSAGE
  of ekCustom:           PRIORITY_CUSTOM

proc newEventQueue*(): EventQueue =
  result.currentTopPriority = MIN_VALUE

proc addEvent*(eq: var EventQueue; kind: EventKind; turnNumber: int;
               data: pointer; isCritical: bool = false) =
  if eq.events.len >= MAX_QUEUE_SIZE: return
  eq.events.add QueuedEvent(
    kind:       kind,
    turnNumber: turnNumber,
    priority:   priorityOf(kind),
    isCritical: isCritical,
    data:       data)

proc clear*(eq: var EventQueue) =
  eq.events.setLen 0
  eq.currentTopPriority = MIN_VALUE

proc removeOldEvents*(eq: var EventQueue; turnNumber: int) =
  var i = 0
  while i < eq.events.len:
    let e = eq.events[i]
    let isOld    = e.turnNumber < turnNumber - MAX_EVENTS_AGE
    let isGameEnd = e.kind in {ekGameEnded, ekGameAborted, ekRoundEnded, ekRoundStarted}
    if isOld and not e.isCritical and not isGameEnd:
      eq.events.del i
    else:
      inc i

proc sortEvents*(eq: var EventQueue) =
  eq.events.sort(proc(a, b: QueuedEvent): int =
    # critical first
    let dc = b.isCritical.int - a.isCritical.int
    if dc != 0: return dc
    # older first
    let dt = a.turnNumber - b.turnNumber
    if dt != 0: return dt
    # higher priority first
    b.priority - a.priority
  )

proc setInterruptible*(eq: var EventQueue; kind: EventKind; v: bool) =
  eq.interruptible[kind] = v

proc isInterruptible*(eq: EventQueue; kind: EventKind): bool =
  eq.interruptible.getOrDefault(kind, false)
