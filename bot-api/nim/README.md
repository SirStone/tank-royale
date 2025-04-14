# Nim Bot API for Robocode Tank Royale

This is the Nim language API for creating bots that can participate in battles in [Robocode Tank Royale](https://tankroyale.robocode.dev/).

## Overview

This API provides a set of classes and functions that enable you to easily create and control bots in Nim, which can then connect to a Robocode Tank Royale game server and engage in battles.

## Features

*   **Easy-to-Use:** The API is designed to be intuitive and simple to use, allowing you to focus on bot logic rather than low-level networking details.
*   **Event-Driven:** Bots react to events occurring in the game, such as being scanned by another bot, being hit by a bullet, or when a round ends.
*   **Comprehensive API:** Full access to bot actions, such as moving, turning, firing bullets, and scanning.
*   **Clear Documentation:** Well-documented code and examples to get you started quickly.

## Getting Started

### Prerequisites

*   [Nim](https://nim-lang.org/) compiler installed.
*   Robocode Tank Royale game server running.

### Installation

1.  Create a new Nim project.
2. Add this bot-api to the project.

### Basic Example
```
nim
import botapi

type MyBot = object of Bot
  # Add custom members here

proc onTick(bot: MyBot, event: TickEvent) =
  # This method is called on each game tick
  echo "Tick: ", event.turnNumber
  bot.setTurnRight(10)
  bot.setForward(10)
  bot.setFire(1.0)

proc onScannedBot(bot: MyBot, event: ScannedBotEvent) =
  # This is called when your bot scans another bot
  echo "Scanned bot: ", event.name
  bot.setTurnGunRight(event.bearing)
  bot.setFire(2.0)

proc main() =
  var botInfo = BotInfo(
    name: "MyNimBot",
    version: "1.0",
    authors: @["Your Name"],
    description: "A sample bot written in Nim",
    countryCodes: @["us"],
    gameTypes: @["melee", "1v1"],
  )

  var myBot = MyBot()

  myBot.start("ws://localhost:5000", botInfo)

main()
```
### Running the Example

1.  Save the code as `my_bot.nim`.
2.  Compile the bot: `nim c my_bot.nim`
3.  Run the bot: `./my_bot`
4. Launch the game.

## API Reference

The API provides the following main classes and interfaces:

*   **Bot**: The base class for all bots.
*   **BotInfo**: Contains information about the bot.
*   **BotState**: Represents the current state of the bot.
*   **Events**: Contains all events which your bot can receive.
* **Event Interface** The common interface for all events.

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or want to contribute code, please feel free to open an issue or pull request on the project repository.

## License

This project is licensed under the [MIT License](LICENSE).