import unittest
import ../src/bot_api/initial_position

when isMainModule:
  suite "InitialPosition Tests":
    test "Test InitialPosition default constructor":
      let initialPosition = newInitialPosition()
      check initialPosition.x == 0.0
      check initialPosition.y == 0.0
      check initialPosition.direction == 0.0
      echo "✓ Default constructor test passed"

    test "Test InitialPosition constructor with values":
      let initialPosition = newInitialPosition(100.0, 200.0, 90.0)
      check initialPosition.x == 100.0
      check initialPosition.y == 200.0
      check initialPosition.direction == 90.0
      echo "✓ Constructor with values test passed"

    test "Test InitialPosition with negative values":
      let initialPosition = newInitialPosition(-50.0, -75.0, -45.0)
      check initialPosition.x == -50.0
      check initialPosition.y == -75.0
      check initialPosition.direction == -45.0
      echo "✓ Negative values test passed"
  
  echo "All InitialPosition tests completed successfully!"
