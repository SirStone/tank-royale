# Nim Bot API for Robocode Tank Royale

This is the Nim language API for creating bots that can participate in battles in [Robocode Tank Royale](https://tankroyale.robocode.dev/).

## 🎯 Status: Production Ready

✅ **All 6 official Tank Royale bot examples are working**  
✅ **Complete API implementation**  
✅ **Tank Royale-compatible bot directories**  
✅ **WebSocket networking established**  

## Overview

This API provides a complete set of classes and functions that enable you to easily create and control bots in Nim, which can then connect to a Robocode Tank Royale game server and engage in battles.

## Features

*   **Complete API Coverage:** All essential bot programming methods implemented
*   **Event-Driven:** Bots react to events occurring in the game, such as being scanned, hit by bullets, or when rounds end
*   **Tank Royale Compatible:** Follows official Tank Royale bot directory structure
*   **6 Working Examples:** Complete implementations of all official sample bots
*   **Easy Deployment:** Ready-to-use bot directories with executables and configuration

## 🚀 Quick Start

### Prerequisites

*   [Nim](https://nim-lang.org/) compiler installed
*   Robocode Tank Royale game server running on `localhost:7654`

### Running Pre-built Examples

All official Tank Royale examples are ready to compile and run:

```bash
# First, compile any bot you want to test:
cd examples/MyFirstBot && ./MyFirstBot.sh --compile

# Then run the compiled bot:
./MyFirstBot.sh

# Other examples (compile first, then run):
cd examples/SpinBot && ./SpinBot.sh --compile && ./SpinBot.sh          # Circular movement  
cd examples/WallsBot && ./WallsBot.sh --compile && ./WallsBot.sh        # Wall-following
cd examples/CornersBot && ./CornersBot.sh --compile && ./CornersBot.sh  # Corner strategy
cd examples/CrazyBot && ./CrazyBot.sh --compile && ./CrazyBot.sh        # Aggressive ramming
cd examples/VelocityBot && ./VelocityBot.sh --compile && ./VelocityBot.sh # Speed demonstration
```

### Building Your Own Bot

Create a new bot in its own directory:

```bash
mkdir examples/MyBot
cd examples/MyBot
```

Create `MyBot.nim`:
```nim
import bot_api/network_bot

type MyBot = ref object of NetworkBot

method run(self: MyBot) =
  # Your bot logic here
  while true:
    self.forward(100)
    self.turnGunRight(360) 
    self.go()

when isMainModule:
  let bot = MyBot()
  bot.start()
```

Create startup scripts (copy from existing examples), then compile and run:
```bash
./MyBot.sh --compile
./MyBot.sh
```

## 📁 Bot Directory Structure

Each bot has its own directory with source code and configuration:

```
examples/MyFirstBot/
├── MyFirstBot.nim      # Source code
├── MyFirstBot          # Executable (after compilation)
├── MyFirstBot.json     # Bot configuration
├── MyFirstBot.sh       # Linux/macOS startup script
└── MyFirstBot.cmd      # Windows startup script
```

**Key Features:**
- **Source-based**: Edit `.nim` files directly in bot directories
- **Compile on demand**: Use `--compile` flag to build
- **Tank Royale compatible**: Ready for official tournament use

See [BOT_DIRECTORY_GUIDE.md](BOT_DIRECTORY_GUIDE.md) for complete details.

## 🎮 Available Examples
## 🎮 Available Examples

| Bot | Strategy | Difficulty | Description |
|-----|----------|------------|-------------|
| **MyFirstBot** | Seesaw Motion | Beginner | Simple back-and-forth movement with gun spinning |
| **SpinBot** | Circular Movement | Beginner | Continuous circular motion while firing |
| **WallsBot** | Perimeter Patrol | Intermediate | Follows arena walls with inward-facing gun |
| **CornersBot** | Corner Strategy | Intermediate | Seeks corners and scans for enemies |
| **CrazyBot** | Aggressive Ramming | Advanced | Zigzag movement with wall bouncing |
| **VelocityBot** | Speed Control | Advanced | Demonstrates variable speed and turn rates |

## 🛠️ API Reference

### Core Classes

- **`NetworkBot`**: Main bot class for creating tank behaviors
- **`BaseBot`**: Base functionality and state management  
- **Event System**: Complete event handling for game interactions

### Key Methods

```nim
# Movement
self.forward(distance)
self.back(distance) 
self.turnLeft(degrees)
self.turnRight(degrees)

# Combat
self.fire(power)
self.turnGunLeft(degrees)
self.turnGunRight(degrees)

# Sensors
self.scan()
self.getX(), self.getY()  # Position
self.getEnergy()          # Current energy
self.getEnemyCount()      # Number of enemies
```

### Event Handling

```nim
method onScannedBot(self: MyBot, event: ScannedBotEvent) =
  # React to scanning another bot
  self.turnGunRight(event.bearing)
  self.fire(2.0)

method onHitByBullet(self: MyBot, event: HitByBulletEvent) =
  # React to being hit
  self.turnLeft(90)
  self.forward(100)
```

## 📚 Documentation

- **[BOT_DIRECTORY_GUIDE.md](BOT_DIRECTORY_GUIDE.md)**: Complete guide to bot directory structure
- **[COMPLETION_SUMMARY.md](COMPLETION_SUMMARY.md)**: Implementation status and achievements
- **[examples/README.md](examples/README.md)**: Detailed example descriptions

## 🔧 Development

### Building All Examples
```bash
# Individual builds
nim c --path:src -o:examples/MyFirstBot/MyFirstBot examples/my_first_bot.nim
nim c --path:src -o:examples/SpinBot/SpinBot examples/spin_bot.nim
# ... etc for other bots
```

### Testing
```bash
nim c -r --path:src tests/test_bot_basic.nim
nim c -r --path:src tests/test_network_basic.nim
```

## 🎯 Integration with Tank Royale

1. **Start Tank Royale Server**: Ensure server is running on `localhost:7654`
2. **Add Bot Directory**: In Tank Royale GUI, add any `examples/BotName/` directory  
3. **Create Battle**: Select your Nim bots for battles
4. **Watch and Learn**: Observe different bot strategies in action

## ✅ Verification

To verify everything works:

```bash
cd examples/MyFirstBot
./MyFirstBot.sh
```

Expected output:
```
=== Tank Royale Nim Bot - MyFirstBot Example ===
Starting MyFirstBot...
Connected to Tank Royale server!
```

## 🤝 Contributing

Contributions are welcome! The API is now feature-complete, but improvements and additional examples are always appreciated.

## 📄 License

This project is licensed under the [MIT License](LICENSE).