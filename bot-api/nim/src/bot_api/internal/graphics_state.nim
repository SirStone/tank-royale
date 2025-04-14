import bot_api/util/color_util

type
  GraphicsState* = ref object of RootObj
    x*: float
    y*: float
    width*: float
    height*: float
    energy*: float
    velocity*: float
    direction*: float
    gunHeading*: float
    radarHeading*: float
    distanceRemaining*: float
    turnRemaining*: float
    gunTurnRemaining*: float
    radarTurnRemaining*: float
    name*: string
    botColor*: Color
    gunColor*: Color
    radarColor*: Color
    scanColor*: Color
    bulletColor*: Color

proc newGraphicsState*(): GraphicsState =
  result = GraphicsState(
    x: 0.0, y: 0.0, width: 0.0, height: 0.0, energy: 0.0, velocity: 0.0,
    direction: 0.0, gunHeading: 0.0, radarHeading: 0.0, distanceRemaining: 0.0,
    turnRemaining: 0.0, gunTurnRemaining: 0.0, radarTurnRemaining: 0.0,
    name: "", botColor: defaultBotColor(), gunColor: defaultGunColor(),
    radarColor: defaultRadarColor(), scanColor: defaultScanColor(),
    bulletColor: defaultBulletColor()
  )
