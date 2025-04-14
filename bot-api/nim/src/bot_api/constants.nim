diff
--- a/bot-api/nim/src/bot_api/constants.nim
+++ b/bot-api/nim/src/bot_api/constants.nim
@@ -1,26 +1,26 @@
 import strformat
 
-const
-  /** Game turn time in milliseconds */
-  GAME_TURN_TIME*: int = 100
+const 
+  ## Game turn time in milliseconds
+  GAME_TURN_TIME* = 100
 
-  /** Max forward speed */
-  MAX_FORWARD_SPEED*: float = 8.0
+  ## Max forward speed
+  MAX_FORWARD_SPEED* = 8.0
 
-  /** Max backward speed */
-  MAX_BACKWARD_SPEED*: float = 4.0
+  ## Max backward speed
+  MAX_BACKWARD_SPEED* = 4.0
 
-  /** Max turning rate in degrees per turn */
-  MAX_TURN_RATE*: float = 10.0
+  ## Max turning rate in degrees per turn
+  MAX_TURN_RATE* = 10.0
 
-  /** Max gun turning rate in degrees per turn */
-  MAX_GUN_TURN_RATE*: float = 20.0
+  ## Max gun turning rate in degrees per turn
+  MAX_GUN_TURN_RATE* = 20.0
 
-  /** Max radar turning rate in degrees per turn */
-  MAX_RADAR_TURN_RATE*: float = 45.0
+  ## Max radar turning rate in degrees per turn
+  MAX_RADAR_TURN_RATE* = 45.0
 
-  /** Max firing power */
-  MAX_FIRE_POWER*: float = 3.0
+  ## Max firing power
+  MAX_FIRE_POWER* = 3.0
 
-  /** Min firing power */
-  MIN_FIRE_POWER*: float = 0.1
+  ## Min firing power
+  MIN_FIRE_POWER* = 0.1
+  
+  ## Bot default start energy
+  DEFAULT_START_ENERGY* = 100.0

-  /** Default start energy */
-  DEFAULT_START_ENERGY*: float = 100.0
-
-  /** Max energy */
-  MAX_ENERGY*: float = 100.0
+  ## Max energy
+  MAX_ENERGY* = 100.0