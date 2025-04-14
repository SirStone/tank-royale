nim
import unittest
import ../src/bot_api/internal/graphics_state

suite "GraphicsState":
  test "test create":
    let graphicsState = GraphicsState()
    check graphicsState.getGraphics() == nil
    check graphicsState.getRenderingHints() == nil

  test "test get and set graphics":
    let graphicsState = GraphicsState()
    var graphics: ptr UncheckedArray[byte]
    graphicsState.setGraphics(graphics)
    check graphicsState.getGraphics() == graphics

  test "test get and set rendering hints":
    let graphicsState = GraphicsState()
    var renderingHints: ptr UncheckedArray[byte]
    graphicsState.setRenderingHints(renderingHints)
    check graphicsState.getRenderingHints() == renderingHints