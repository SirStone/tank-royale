# tankroyale_botapi — Nim Bot API for Robocode Tank Royale

This is a continuation of the [My First Bot](https://robocode.dev/tutorial/my-first-bot.html) tutorial on robocode.dev. Nim bots compile to native binaries — no VM or interpreter required.

## 1. API Reference

Docs not yet published — see source in `src/`.

## 2. Create a bot project

- Create a directory for your bot, e.g. `~/bots/MyFirstBot/` — all files share this name
- Register the directory in the Robocode GUI's **Bot Root Configuration**
- Create a `myFirstBot.nimble` file in that directory:

```nim
version     = "0.1.0"
author      = "Your Name"
description = "My first Tank Royale bot"
license     = "MIT"
bin         = @["MyFirstBot"]

requires "nim >= 2.0.0"
requires "tankroyale_botapi >= 1.0.1"
```

## 3. Create the JSON config file

`MyFirstBot.json` — required fields are `name`, `version`, `authors`:

```json
{
  "name": "My First Bot",
  "version": "1.0",
  "authors": ["Your Name"],
  "description": "My first bot",
  "homepage": "",
  "countryCodes": ["us"],
  "gameTypes": ["classic", "melee", "1v1"],
  "platform": "Nim",
  "programmingLang": "Nim"
}
```

## 4. Initial code — `MyFirstBot.nim`

```nim
import std/os
import tankroyale_botapi

const botJson = currentSourcePath().parentDir / "MyFirstBot.json"

type MyFirstBot = ref object of Bot
```

## 5. The `run` method

```nim
method run(bot: MyFirstBot) =
  while isRunning():
    forward(100)
    turnGunRight(360)
    back(100)
    turnGunRight(360)
```

## 6. Event handlers

```nim
method onScannedBot(bot: MyFirstBot, e: ScannedBotEvent) =
  fire(1)

method onHitByBullet(bot: MyFirstBot, e: HitByBulletEvent) =
  let bearing = calcBearing(e.bullet.direction)
  turnLeft(90 - bearing)
```

## 7. The main entry point

```nim
when isMainModule:
  var bot = MyFirstBot()
  start(bot, botJson)
```

## 8. Putting it all together

Full combined listing:

```nim
import std/os
import tankroyale_botapi

const botJson = currentSourcePath().parentDir / "MyFirstBot.json"

type MyFirstBot = ref object of Bot

method run(bot: MyFirstBot) =
  while isRunning():
    forward(100)
    turnGunRight(360)
    back(100)
    turnGunRight(360)

method onScannedBot(bot: MyFirstBot, e: ScannedBotEvent) =
  fire(1)

method onHitByBullet(bot: MyFirstBot, e: HitByBulletEvent) =
  let bearing = calcBearing(e.bullet.direction)
  turnLeft(90 - bearing)

when isMainModule:
  var bot = MyFirstBot()
  start(bot, botJson)
```

## 9. Install the API and build

Install the Nim bot API via [Nimble](https://github.com/nim-lang/nimble):

```sh
nimble install tankroyale_botapi
```

Then build your bot (from inside the bot directory):

```sh
nimble build
```

This produces a native binary — `MyFirstBot` on Linux/macOS, `MyFirstBot.exe` on Windows.

## 10. Startup scripts

The Robocode booter launches bots via shell scripts. Create these two files:

**`MyFirstBot.sh`** (Linux/macOS):

```sh
#!/bin/sh
cd -- "$(dirname -- "$0")"
exec "./MyFirstBot"
```

Make it executable: `chmod 755 MyFirstBot.sh`

**`MyFirstBot.cmd`** (Windows):

```
@echo off
cd /d "%~dp0"
MyFirstBot.exe
```

## 11. Packaging your bot

Compile for your target platform, then zip the following files:

- `MyFirstBot.nim`
- `MyFirstBot.json`
- `MyFirstBot.sh`
- `MyFirstBot.cmd`
- `MyFirstBot` _(compiled binary — Linux/macOS)_
- `MyFirstBot.exe` _(compiled binary — Windows)_
- `README.md` _(optional)_

Upload the zip to share your bot.

## 12. Bot Secrets

If you're connecting to a server that requires authentication, set the `BOT_SECRETS` environment variable before launching:

**bash:**

```sh
export BOT_SECRETS=my-secret
```

**cmd:**

```
set BOT_SECRETS=my-secret
```

**PowerShell:**

```powershell
$env:BOT_SECRETS = "my-secret"
```
