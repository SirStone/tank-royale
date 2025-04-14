nim
import math, strutils

# Module for math utilities
#
# The math module contains methods for mathematical operations used by the API.
module math_util

  const TWO_PI* = 2.0 * PI
  # Calculates the absolute angle between two angles.
  #
  # Params:
  #   angle1: First angle.
  #   angle2: Second angle.
  #
  # Returns:
  #   The absolute angle between the two angles.
  proc calcAbsoluteAngle*(angle1: float, angle2: float): float =
    result = abs(angle1 - angle2)
    if result > 180:
      result = 360 - result

  # Calculates the shortest arc between two angles.
  #
  # Params:
  #   angle1: First angle.
  #   angle2: Second angle.
  #
  # Returns:
  #   The shortest arc between the two angles.
  proc calcShortestArc*(angle1: float, angle2: float): float =
    var
      diff = angle2 - angle1
      dist = (diff + 180.0) mod 360.0 - 180.0
    result = if dist < -180.0:
              dist + 360.0
            elif dist > 180.0:
              dist - 360.0
            else:
              dist


  # Normalizes an angle to be within the range of 0 to 360 degrees.
  #
  # Params:
  #   angle: The angle to normalize.
  #
  # Returns:
  #   The normalized angle.
  proc normalizeAngle*(angle: float): float =
      var normalized = angle mod 360.0
      if normalized < 0:
          normalized += 360.0
      return normalized


  # Normalizes an heading to be within the range of 0 to 360 degrees.
  #
  # Params:
  #   heading: The heading to normalize.
  #
  # Returns:
  #   The normalized heading.
  proc normalizeHeading*(heading: float): float =
    result = normalizeAngle(heading)

  # Calculates the distance between two points.
  #
  # Params:
  #   x1: The x-coordinate of the first point.
  #   y1: The y-coordinate of the first point.
  #   x2: The x-coordinate of the second point.
  #   y2: The y-coord   inate of the second point.
  #
  # Returns:
  #   The distance between the two points.
  proc distance*(x1: float, y1: float, x2: float, y2: float): float =
    result = sqrt(((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)))

  # Calculates the bearing from one point to another.
  #
  # Args:
  #   x1: The x-coordinate of the source point.
  #   y1: The y-coordinate of the source point.
  #   x2: The x-coordinate of the target point.
  #   y2: The y-coordinate of the target point.
  #
  # Returns:   
  #   The bearing from the starting point to the destination point.
  proc bearing*(x1: float, y1: float, x2: float, y2: float): float =
    result = normalizeHeading(toDegrees(atan2(x2 - x1, y2 - y1)))

  # Calculates the intersection point between two lines defined by a starting point and an angle.
  #
  # Params:
  #   x1: The x-coordinate of the starting point of the first line.
  #   y1: The y-coordinate of the starting point of the first line.
  #   angle1: The angle of the first line.
  #   x2: The x-coordinate of the starting point of the second line.
  #   y2: The y-coordinate of the starting point of the second line.
  #   angle2: The angle of the second line.
  #
  # Returns:
  #   A tuple containing the x and y coordinates of the intersection point.
  proc lineIntersection*(x1: float, y1: float, angle1: float, x2: float, y2: float, angle2: float): tuple[x: float, y: float] =
    var
      x: float
      y: float
      dx1 = cos(toRadians(angle1))
      dy1 = sin(toRadians(angle1))
      dx2 = cos(toRadians(angle2))
      dy2 = sin(toRadians(angle2))

      det = dy2 * dx1 - dx2 * dy1

    if det == 0:
        return (x: float.nan, y: float.nan) # Lines are parallel, no intersection

    var
        t = ((x2 - x1) * dy2 - (y2 - y1) * dx2) / det
        u = -((x2 - x1) * dy1 - (y2 - y1) * dx1) / det

    if t >= 0 and u >= 0:
      x = x1 + t * dx1
      y = y1 + t * dy1
      return (x: x, y: y)
    else:
      return (x: float.nan, y: float.nan)