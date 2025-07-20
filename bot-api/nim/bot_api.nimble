# Package
version       = "1.0.0"
author        = "Tank Royale Contributors"
description   = "Bot API for Tank Royale in Nim"
license       = "MIT"
srcDir        = "src"

# Dependencies
requires "nim >= 2.0.0"
requires "unittest2 >= 0.1.0"
requires "ws >= 0.5.0"

task test, "Run tests":
  exec "nim c -r --path:src tests/test_bot_info_new.nim"
  exec "nim c -r --path:src tests/test_constants_new.nim"
  exec "nim c -r --path:src tests/test_initial_position_v2.nim"
  exec "nim c -r --path:src tests/test_bot_basic.nim"
  exec "nim c -r --path:src tests/test_inheritance.nim"
  exec "nim c -r --path:src tests/test_network_basic.nim"
  exec "nim c -r --path:src tests/test_bot_info_json.nim"
  # Clean up compiled test executables (binaries without extensions)
  echo "Cleaning up compiled test executables..."
  exec "find tests -name 'test_*' ! -name '*.nim' -type f -delete"

task demo, "Run the networking demo":
  echo "Building and running networking demo..."
  exec "nim c -r --path:src examples/networking_demo.nim"

task example, "Run the basic spinner bot example":
  echo "Building and running basic spinner bot example..."
  exec "nim c -r --path:src examples/spinner_bot.nim"

task advanced, "Run the advanced network bot example":
  echo "Building and running advanced network bot example..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  exec "nim c -r --path:src examples/advanced_network_bot.nim"

# Official Bot Example Tasks
task myfirstbot, "Run MyFirstBot - simple seesaw motion with gun spinning":
  echo "Building and running MyFirstBot (Official Tank Royale sample)..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  exec "nim c -r --path:src examples/my_first_bot.nim"

task spinbot, "Run SpinBot - continuous circular movement while firing":
  echo "Building and running SpinBot (Official Tank Royale sample)..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  exec "nim c -r --path:src examples/spin_bot.nim"

task walls, "Run Walls - navigate battlefield perimeter with gun pointed inward":
  echo "Building and running Walls (Official Tank Royale sample)..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  exec "nim c -r --path:src examples/walls_bot.nim"

task corners, "Run Corners - move to corners and scan, adaptive strategy":
  echo "Building and running Corners (Official Tank Royale sample)..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  exec "nim c -r --path:src examples/corners_bot.nim"

task crazy, "Run Crazy - zigzag movement pattern with wall bouncing":
  echo "Building and running Crazy (Official Tank Royale sample)..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  exec "nim c -r --path:src examples/crazy_bot.nim"

task velocity, "Run VelocityBot - demonstrates turn rates and target speeds":
  echo "Building and running VelocityBot (Official Tank Royale sample)..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  exec "nim c -r --path:src examples/velocity_bot.nim"

task examples, "Run all official Tank Royale sample bots":
  echo "Running all official Tank Royale sample bot examples..."
  echo "NOTE: Make sure Tank Royale server is running on localhost:7654"
  echo ""
  echo "You can run individual bots with:"
  echo "  nimble myfirstbot  - Simple seesaw motion"
  echo "  nimble spinbot     - Continuous circular movement"
  echo "  nimble walls       - Battlefield perimeter navigation"
  echo "  nimble corners     - Corner seeking with adaptive strategy"
  echo "  nimble crazy       - Zigzag movement with wall bouncing"
  echo "  nimble velocity    - Turn rates and speed demonstration"

# Build tasks for Tank Royale bot directories
task buildbots, "Build all bots and place executables in their directories":
  echo "Building all Tank Royale bots into their directories..."
  exec "nim c --path:src -o:examples/MyFirstBot/MyFirstBot examples/my_first_bot.nim"
  exec "nim c --path:src -o:examples/SpinBot/SpinBot examples/spin_bot.nim"
  exec "nim c --path:src -o:examples/WallsBot/WallsBot examples/walls_bot.nim"
  exec "nim c --path:src -o:examples/CornersBot/CornersBot examples/corners_bot.nim"
  exec "nim c --path:src -o:examples/CrazyBot/CrazyBot examples/crazy_bot.nim"
  exec "nim c --path:src -o:examples/VelocityBot/VelocityBot examples/velocity_bot.nim"
  echo "All bots built successfully!"

task buildbot, "Build a specific bot (usage: nimble buildbot --bot:BotName)":
  let botName = paramStr(paramCount())
  case botName:
    of "MyFirstBot":
      exec "nim c --path:src -o:examples/MyFirstBot/MyFirstBot examples/my_first_bot.nim"
    of "SpinBot":
      exec "nim c --path:src -o:examples/SpinBot/SpinBot examples/spin_bot.nim"
    of "WallsBot":
      exec "nim c --path:src -o:examples/WallsBot/WallsBot examples/walls_bot.nim"
    of "CornersBot":
      exec "nim c --path:src -o:examples/CornersBot/CornersBot examples/corners_bot.nim"
    of "CrazyBot":
      exec "nim c --path:src -o:examples/CrazyBot/CrazyBot examples/crazy_bot.nim"
    of "VelocityBot":
      exec "nim c --path:src -o:examples/VelocityBot/VelocityBot examples/velocity_bot.nim"
    else:
      echo "Unknown bot: " & botName
      echo "Available bots: MyFirstBot, SpinBot, WallsBot, CornersBot, CrazyBot, VelocityBot"