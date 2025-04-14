import sequtils

type
  BotResults* = ref object of RootObj
    rank*: int
    score*: int
    survival*: float
    lastSurvivorBonus*: int
    bulletDamage*: int
    bulletKillBonus*: int
    ramDamage*: int
    ramKillBonus*: int
    firsts*: int
    seconds*: int 
    thirds*: int 

proc newBotResults*(): BotResults =
  BotResults(
    rank: -1,
    score: 0,
    survival: 0.0,
    lastSurvivorBonus: 0,
    bulletDamage: 0,
    bulletKillBonus: 0,
    ramDamage: 0,
    ramKillBonus: 0,
    firsts: 0,
    seconds: 0,
    thirds: 0
  )

proc getRank*(results: BotResults): int =
  results.rank

proc setRank*(results: BotResults, rank: int) =
  results.rank = rank

proc getScore*(results: BotResults): int =
  results.score

proc setScore*(results: BotResults, score: int) =
  results.score = score

proc getSurvival*(results: BotResults): float =
  results.survival

proc setSurvival*(results: BotResults, survival: float) =
  results.survival = survival

proc getLastSurvivorBonus*(results: BotResults): int =
  results.lastSurvivorBonus

proc setLastSurvivorBonus*(results: BotResults, lastSurvivorBonus: int) =
  results.lastSurvivorBonus = lastSurvivorBonus

proc getBulletDamage*(results: BotResults): int =
  results.bulletDamage

proc setBulletDamage*(results: BotResults, bulletDamage: int) =
  results.bulletDamage = bulletDamage

proc getBulletKillBonus*(results: BotResults): int =
  results.bulletKillBonus

proc setBulletKillBonus*(results: BotResults, bulletKillBonus: int) =
  results.bulletKillBonus = bulletKillBonus

proc getRamDamage*(results: BotResults): int =
  results.ramDamage

proc setRamDamage*(results: BotResults, ramDamage: int) =
  results.ramDamage = ramDamage

proc getRamKillBonus*(results: BotResults): int =
  results.ramKillBonus

proc setRamKillBonus*(results: BotResults, ramKillBonus: int) =
  results.ramKillBonus = ramKillBonus

proc getFirsts*(results: BotResults): int =
  results.firsts

proc setFirsts*(results: BotResults, firsts: int) =
  results.firsts = firsts

proc getSeconds*(results: BotResults): int =
  results.seconds

proc setSeconds*(results: BotResults, seconds: int) =
  results.seconds = seconds

proc getThirds*(results: BotResults): int =
  results.thirds

proc setThirds*(results: BotResults, thirds: int) =
  results.thirds = thirds

proc toString*(results: BotResults): string =
  result = &"BotResults(rank={results.rank}, score={results.score}, survival={results.survival}, " &
           $"lastSurvivorBonus={results.lastSurvivorBonus}, bulletDamage={results.bulletDamage}, " &
           $"bulletKillBonus={results.bulletKillBonus}, ramDamage={results.ramDamage}, " &
           $"ramKillBonus={results.ramKillBonus}, firsts={results.firsts}, seconds={results.seconds}, " &
           $"thirds={results.thirds})"

proc copy*(results: BotResults): BotResults =
  result = BotResults(rank: results.rank, score: results.score, survival: results.survival,
                      lastSurvivorBonus: results.lastSurvivorBonus, bulletDamage: results.bulletDamage,
                      bulletKillBonus: results.bulletKillBonus, ramDamage: results.ramDamage,
                      ramKillBonus: results.ramKillBonus, firsts: results.firsts,
                      seconds: results.seconds, thirds: results.thirds)