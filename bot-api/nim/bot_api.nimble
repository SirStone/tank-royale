nim
# Package

name          = "bot_api"
version       = "1.0.0"
author        = "AI Generated"
description   = "Bot-API in Nim (AI Generated)"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.0"

# Sources

bin           = @["bot_api"]

# Tests

testfiles     = @["tests"]
requires "unittest2 >= 0.1.0"