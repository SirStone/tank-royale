nim
import ./i_event, ../bullet_state

type
  BulletHitWallEvent* = ref object of Event
    bullet*: BulletState
    wallX*: int
    wallY*: int
    
proc initBulletHitWallEvent*(bullet: BulletState, wallX: int, wallY: int): BulletHitWallEvent =
  result = BulletHitWallEvent()
  result.bullet = bullet
  result.wallX = wallX
  result.wallY = wallY