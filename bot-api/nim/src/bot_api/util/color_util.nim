nim
import strutils


const
  MinColorValue* = 0
  MaxColorValue* = 255

proc toColor*(colorCode: string): tuple[r: int, g: int, b: int] =
  ## Converts a hexadecimal color code to RGB color values.
  ## based on: ColorUtil.java
  ##
  ## Args:
  ##   colorCode: The color code in hexadecimal format (e.g., "#RRGGBB").
  ##
  ## Returns:
  ##   A tuple containing the red, green, and blue color values as integers.
  ##
  if colorCode.len != 7 or colorCode[0] != '#':
    raise newException(ValueError, "Invalid color code: " & colorCode)
  
  let hexR = colorCode[1..2]
  let hexG = colorCode[3..4]
  let hexB = colorCode[5..6]
  
  result.r = parseInt(hexR, 16)
  result.g = parseInt(hexG, 16)
  result.b = parseInt(hexB, 16)

proc toHexCode*(r: int, g: int, b: int): string =
  ## Converts a RGB color to hexadecimal color code.
  ## based on: ColorUtil.java
  ##
    ## Args:
    ##   r: The red color value (0-255).
    ##   g: The green color value (0-255).
    ##   b: The blue color value (0-255).
    ##
    ## Returns:
    ##   The color code in hexadecimal format (e.g., "#RRGGBB").
  ##
  if r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255:
    raise newException(ValueError, "Invalid RGB color values: r=" & $r & ", g=" & $g & ", b=" & $b)
  
  let hexR = toLower(toHex(r, 2))
  let hexG = toLower(toHex(g, 2))
  let hexB = toLower(toHex(b, 2))
  
  result = "#" & hexR & hexG & hexB