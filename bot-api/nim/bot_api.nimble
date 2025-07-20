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