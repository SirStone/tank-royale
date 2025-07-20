# Tank Royale Nim Bot API - Bot Directory Structure

## 🏗️ Directory Structure Overview

The Tank Royale Nim Bot API now provides a complete directory structure for each bot, following the official Tank Royale requirements. Each bot has its own directory containing all necessary files for deployment.

```
nim/examples/
├── MyFirstBot/
│   ├── MyFirstBot          # Compiled executable (created after compilation)
│   ├── MyFirstBot.nim      # Source code
│   ├── MyFirstBot.json     # Bot configuration
│   ├── MyFirstBot.sh       # Linux/macOS startup script
│   └── MyFirstBot.cmd      # Windows startup script
├── SpinBot/
│   ├── SpinBot             # Compiled executable (created after compilation)
│   ├── SpinBot.nim         # Source code
│   ├── SpinBot.json        # Bot configuration
│   ├── SpinBot.sh          # Linux/macOS startup script
│   └── SpinBot.cmd         # Windows startup script
├── WallsBot/
│   ├── WallsBot            # Compiled executable (created after compilation)
│   ├── WallsBot.nim        # Source code
│   ├── WallsBot.json       # Bot configuration
│   ├── WallsBot.sh         # Linux/macOS startup script
│   └── WallsBot.cmd        # Windows startup script
├── CornersBot/
│   ├── CornersBot          # Compiled executable (created after compilation)
│   ├── CornersBot.nim      # Source code
│   ├── CornersBot.json     # Bot configuration
│   ├── CornersBot.sh       # Linux/macOS startup script
│   └── CornersBot.cmd      # Windows startup script
├── CrazyBot/
│   ├── CrazyBot            # Compiled executable (created after compilation)
│   ├── CrazyBot.nim        # Source code
│   ├── CrazyBot.json       # Bot configuration
│   ├── CrazyBot.sh         # Linux/macOS startup script
│   └── CrazyBot.cmd        # Windows startup script
└── VelocityBot/
    ├── VelocityBot         # Compiled executable (created after compilation)
    ├── VelocityBot.nim     # Source code
    ├── VelocityBot.json    # Bot configuration
    ├── VelocityBot.sh      # Linux/macOS startup script
    └── VelocityBot.cmd     # Windows startup script
```

## 📋 File Types Explained

### 1. **Source Code Files** (`BotName.nim`)
- Contains the actual bot logic and behavior
- Uses proper import paths for the bot API: `import bot_api/network_bot`
- Can be edited and customized for your own bot development
- **This is the main file you'll work with when developing bots**

### 2. **Executable Files** (`BotName`) 
- Compiled Nim binaries for Linux/macOS (created after compilation)
- These are the actual bot programs that connect to Tank Royale server
- Generated using the `--compile` flag with the startup scripts
- Will be automatically created when you run `./BotName.sh --compile`

### 3. **JSON Configuration Files** (`BotName.json`)
- Contains bot metadata required by Tank Royale
- Includes bot name, version, authors, description, game types, etc.
- Example structure:
```json
{
  "name": "MyFirstBot",
  "version": "1.0",
  "authors": ["Tank Royale Team"],
  "description": "A simple bot that moves in a seesaw motion and spins the gun",
  "url": "",
  "countryCode": "US",
  "gameTypes": ["classic", "melee", "1v1"],
  "platform": "Nim",
  "programmingLang": "Nim",
  "initialPosition": "x=50,y=50,angle=0"
}
```

### 4. **Shell Scripts** (`BotName.sh`)
- Startup scripts for Linux/macOS systems
- Handle compilation (with `--compile` flag) and execution
- Automatically compile source code when `--compile` is passed
- Run compiled executable when no flags are passed
- Made executable with `chmod +x`

### 5. **Batch Scripts** (`BotName.cmd`)
- Startup scripts for Windows systems
- Equivalent functionality to shell scripts for Windows users
- Support both compilation and execution modes

## 🛠️ Building Bots

### Build Individual Bot (Recommended)
```bash
cd examples/MyFirstBot
./MyFirstBot.sh --compile
```

**Windows:**
```cmd
cd examples\MyFirstBot
MyFirstBot.cmd --compile
```

### Build All Bots (Legacy Method)
```bash
cd /path/to/tank-royale/bot-api/nim
nim c --path:src -o:examples/MyFirstBot/MyFirstBot examples/MyFirstBot/MyFirstBot.nim
nim c --path:src -o:examples/SpinBot/SpinBot examples/SpinBot/SpinBot.nim
nim c --path:src -o:examples/WallsBot/WallsBot examples/WallsBot/WallsBot.nim
nim c --path:src -o:examples/CornersBot/CornersBot examples/CornersBot/CornersBot.nim
nim c --path:src -o:examples/CrazyBot/CrazyBot examples/CrazyBot/CrazyBot.nim
nim c --path:src -o:examples/VelocityBot/VelocityBot examples/VelocityBot/VelocityBot.nim
```

## 🚀 Running Bots

### Method 1: Using Startup Scripts (Recommended)

**First, compile the bot:**
```bash
cd examples/MyFirstBot
./MyFirstBot.sh --compile
```

**Then run the compiled bot:**
```bash
./MyFirstBot.sh
```

**Windows:**
```cmd
cd examples\MyFirstBot
MyFirstBot.cmd --compile
MyFirstBot.cmd
```

### Method 2: Direct Execution (After Compilation)
```bash
cd examples/MyFirstBot
./MyFirstBot
```

### Method 3: From Tank Royale GUI
1. Start Tank Royale application
2. Go to "Bots" menu
3. "Add Bot Directory"
4. Select any of the bot directories (e.g., `examples/MyFirstBot`)
5. Tank Royale will automatically detect the bot configuration

## 🎮 Bot Descriptions

### MyFirstBot
- **Strategy**: Simple seesaw motion pattern
- **Movement**: Back and forth movement
- **Combat**: Spinning gun for target acquisition
- **Difficulty**: Beginner

### SpinBot  
- **Strategy**: Continuous circular movement
- **Movement**: Circular motion pattern
- **Combat**: Spinning gun while moving
- **Difficulty**: Beginner

### WallsBot
- **Strategy**: Battlefield perimeter navigation
- **Movement**: Follows arena walls
- **Combat**: Gun pointed inward while patrolling
- **Difficulty**: Intermediate

### CornersBot
- **Strategy**: Corner seeking with adaptive strategy
- **Movement**: Seeks and occupies corners
- **Combat**: Scanning and shooting from corners
- **Difficulty**: Intermediate

### CrazyBot
- **Strategy**: Zigzag movement with wall bouncing
- **Movement**: Erratic zigzag patterns
- **Combat**: Aggressive ramming and shooting
- **Difficulty**: Advanced

### VelocityBot
- **Strategy**: Turn rates and speed demonstration
- **Movement**: Variable speed patterns
- **Combat**: Speed-based tactical positioning
- **Difficulty**: Advanced

## 🔧 Customization

### Creating Your Own Bot Directory

1. **Create Directory Structure**:
```bash
mkdir examples/MyCustomBot
```

2. **Write Your Bot** (`MyCustomBot.nim`):
```nim
import bot_api/network_bot

type MyCustomBot = ref object of NetworkBot

method run(self: MyCustomBot) =
  # Your bot logic here
  while true:
    self.forward(100)
    self.turnGunRight(360)
    self.go()

when isMainModule:
  let bot = MyCustomBot()
  bot.start()
```

3. **Create Startup Scripts**:
- Copy and modify startup scripts from existing examples
- Update bot name in `MyCustomBot.sh` and `MyCustomBot.cmd`

4. **Create Configuration File**:
- Copy and modify `MyCustomBot.json` from existing examples

5. **Compile and Test**:
```bash
cd examples/MyCustomBot
./MyCustomBot.sh --compile
./MyCustomBot.sh
```

## 📦 Distribution

Bot directories are self-contained and can be:
- **Zipped and shared** with other users
- **Added to Tank Royale** bot directories
- **Deployed on different systems** with proper executable compilation

## 🔍 Troubleshooting

### Bot Won't Compile
- Check that you're in the correct bot directory
- Ensure Nim is properly installed and accessible
- Verify that `../../src/` directory exists and contains the bot API
- Check for syntax errors in your bot source code

### Bot Won't Start
- First compile the bot with `./BotName.sh --compile`
- Ensure Tank Royale server is running on `localhost:7654`
- Check that executable has proper permissions
- Verify JSON configuration is valid

### Connection Issues
- Confirm Tank Royale server is accessible
- Check firewall settings
- Verify WebSocket connectivity on port 7654

### Import Errors
- Ensure imports use `bot_api/network_bot` format (not `../src/bot_api/network_bot`)
- Verify the `src/` directory structure is intact

## 🎯 Success Indicators

When working correctly, you should see:

**During compilation:**
```bash
$ ./MyFirstBot.sh --compile
Compiling MyFirstBot...
Compilation successful!
```

**When running:**
```
=== Tank Royale Nim Bot - BotName Example ===
Starting BotName...
Make sure Tank Royale server is running on localhost:7654
Connected to Tank Royale server!
```

The source-based bot directory structure is now complete and ready for development and Tank Royale integration!
