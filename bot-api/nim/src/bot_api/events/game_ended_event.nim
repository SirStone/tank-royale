import ./event_abc, ../bot_results

type
  GameEndedEvent* = ref object of Event
    numberOfRounds*: int
    results*: seq[BotResults]

proc `==`*(a, b: GameEndedEvent): bool =
  a.numberOfRounds == b.numberOfRounds and a.results == b.results

proc initGameEndedEvent*(numberOfRounds: int, results: seq[BotResults]): GameEndedEvent =
  new(result)
  result.numberOfRounds = numberOfRounds
  result.results = results

proc toString*(self: GameEndedEvent): string =
  var resultsStr = ""
  for res in self.results:
    resultsStr.add(res.toString() & ", ")
  "GameEndedEvent[numberOfRounds=" & $self.numberOfRounds & ", results=[" & resultsStr & "]]"