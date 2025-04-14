nim
import ./bot_state
import ./bullet_state
import ./game_setup
import ./default_event_priority
import ./bot_results
import ./events/i_event
import ./events/bot_death_event
import ./events/bullet_fired_event
import ./events/bullet_hit_bot_event
import ./events/bullet_hit_bullet_event
import ./events/bullet_hit_wall_event
import ./events/custom_event
import ./events/hit_bot_event
import ./events/hit_by_bullet_event
import ./events/hit_wall_event
import ./events/scanned_bot_event
import ./events/skipped_turn_event
import ./events/team_message_event

type
  IBot* = ref object of RootObj
    getBotName*: proc(): string {.gcsafe, raises: [].}
    getBotVersion*: proc(): string {.gcsafe, raises: [].}
    getBotAuthors*: proc(): seq[string] {.gcsafe, raises: [].}
    getBotDescription*: proc(): string {.gcsafe, raises: [].}
    getBotHomepage*: proc(): string {.gcsafe, raises: [].}
    getSupportedCountryCodes*: proc(): seq[string] {.gcsafe, raises: [].}
    getSupportedGameTypes*: proc(): seq[string] {.gcsafe, raises: [].}
    getPlatform*: proc(): string {.gcsafe, raises: [].}

    onConnected*: proc () {.gcsafe, raises: [].}
    onDisconnected*: proc () {.gcsafe, raises: [].}
    onGameStarted*: proc (gameSetup: GameSetup) {.gcsafe, raises: [].}
    onGameEnded*: proc () {.gcsafe, raises: [].}
    onRoundStarted*: proc (roundNumber: int) {.gcsafe, raises: [].}
    onRoundEnded*: proc (roundNumber: int) {.gcsafe, raises: [].}
    onTick*: proc (botState: BotState) {.gcsafe, raises: [].}
    onBotDeath*: proc(event: BotDeathEvent) {.gcsafe, raises: [].}
    onSkippedTurn*: proc(event: SkippedTurnEvent) {.gcsafe, raises: [].}
    onHitBot*: proc(event: HitBotEvent) {.gcsafe, raises: [].}
    onHitByBullet*: proc(event: HitByBulletEvent) {.gcsafe, raises: [].}
    onHitWall*: proc(event: HitWallEvent) {.gcsafe, raises: [].}
    onScannedBot*: proc(event: ScannedBotEvent) {.gcsafe, raises: [].}
    onBulletFired*: proc(event: BulletFiredEvent) {.gcsafe, raises: [].}
    onBulletHitBot*: proc(event: BulletHitBotEvent) {.gcsafe, raises: [].}
    onBulletHitBullet*: proc(event: BulletHitBulletEvent) {.gcsafe, raises: [].}
    onBulletHitWall*: proc(event: BulletHitWallEvent) {.gcsafe, raises: [].}
    onCustomEvent*: proc(event: CustomEvent) {.gcsafe, raises: [].}
    onTeamMessage*: proc(event: TeamMessageEvent) {.gcsafe, raises: [].}

    setFire*: proc(power: float)
    setTurnGunRight*: proc(degrees: float)
    setTurnRight*: proc(degrees: float)
    setMaxTurnRate*: proc (value: float)
    setMaxGunTurnRate*: proc (value: float)
    setForward*: proc (distance: float)
    setBack*: proc (distance: float)
    setMaxVelocity*: proc (value: float)
    setBodyColor*: proc (color: string)
    setTurretColor*: proc (color: string)
    setRadarColor*: proc (color: string)
    setBulletColor*: proc(color: string)
    setScanColor*: proc(color: string)
    sendMessage*: proc(teamMateId: int, message: string)
    stop*: proc()
    resume*: proc()
    getResults*: proc(): BotResults
    addCondition*: proc(conditionName: string, priority: DefaultEventPriority, condition: proc(): bool) {.gcsafe, raises: [].}
    