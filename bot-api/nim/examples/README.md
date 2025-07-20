# Tank Royale Nim Bot Examples

This directory contains example bot implementations based on the official Tank Royale sample bots. These examples demonstrate different strategies, patterns, and capabilities of the Tank Royale Nim Bot API.

## 🤖 Available Bot Examples

### Official Sample Bot Replicas

These bots are Nim ports of the official Tank Royale sample bots:

#### 1. **MyFirstBot** (`my_first_bot.nim`)
- **Origin**: Official Tank Royale sample by Mathew Nelson
- **Strategy**: Simple seesaw motion with gun spinning
- **Difficulty**: Beginner
- **Features**: Basic movement, simple event handling
- **Good for**: Learning the basics of Tank Royale bot development

#### 2. **SpinBot** (`spin_bot.nim`)
- **Origin**: Official Tank Royale sample by Mathew Nelson  
- **Strategy**: Continuous circular movement while firing at enemies
- **Difficulty**: Beginner
- **Features**: Spinning movement, collision handling, maximum firepower
- **Good for**: Understanding continuous movement patterns

#### 3. **Walls** (`walls_bot.nim`)
- **Origin**: Official Tank Royale sample by Mathew Nelson
- **Strategy**: Navigate around battlefield perimeter with gun pointed inward
- **Difficulty**: Intermediate
- **Features**: Wall following, tactical positioning, scanning strategy
- **Good for**: Learning battlefield navigation and positioning

#### 4. **Corners** (`corners_bot.nim`)
- **Origin**: Official Tank Royale sample by Mathew Nelson
- **Strategy**: Move to corners and scan for enemies, adapt strategy based on performance
- **Difficulty**: Intermediate
- **Features**: Corner seeking, adaptive strategy, distance-based firing
- **Good for**: Understanding adaptive AI and strategic positioning

#### 5. **Crazy** (`crazy_bot.nim`)
- **Origin**: Official Tank Royale sample by Mathew Nelson
- **Strategy**: Zigzag movement pattern with wall bouncing
- **Difficulty**: Intermediate
- **Features**: Complex movement patterns, condition-based waiting, collision handling
- **Good for**: Learning advanced movement and condition systems

#### 6. **VelocityBot** (`velocity_bot.nim`)
- **Origin**: Official Tank Royale sample by Joshua Galecki
- **Strategy**: Demonstrates turn rates and target speeds
- **Difficulty**: Advanced
- **Features**: Turn rate control, speed management, timing-based behavior
- **Good for**: Understanding advanced movement control

### Framework Examples

#### 7. **Advanced Network Bot** (`advanced_network_bot.nim`)
- **Origin**: Nim-specific example
- **Strategy**: Comprehensive strategic AI with networking
- **Difficulty**: Advanced
- **Features**: Real-time monitoring, strategic movement, radar scanning, combat analytics
- **Good for**: Understanding the full networking capabilities

#### 8. **Basic Bot Template** (`basic_bot_template.nim`)
- **Origin**: Nim-specific template
- **Strategy**: Template with common patterns and best practices
- **Difficulty**: Beginner-friendly template
- **Features**: All event handlers, customizable strategy, comprehensive comments
- **Good for**: Starting point for new bot development

### Framework Demos

#### 9. **Networking Demo** (`networking_demo.nim`)
- **Purpose**: Demonstrate WebSocket client functionality without full bot complexity
- **Good for**: Understanding the networking layer

#### 10. **Spinner Bot** (`spinner_bot.nim`)
- **Purpose**: Simple example with basic movement
- **Good for**: Testing basic bot functionality

## 🚀 Running the Examples

### Prerequisites

1. **Install Nim** (version 2.0.0 or later)
2. **Install dependencies**:
   ```bash
   nimble install ws
   ```
3. **Tank Royale Server** running on `localhost:7654`

### Quick Start

```bash
# Navigate to the nim directory
cd /path/to/tank-royale/bot-api/nim

# Run any example bot
nim c -r --path:src examples/my_first_bot.nim
nim c -r --path:src examples/spin_bot.nim
nim c -r --path:src examples/walls_bot.nim
# ... etc
```

### Using Nimble Tasks

```bash
# Run the advanced network bot
nimble advanced

# Run networking demo
nimble demo

# Run basic spinner
nimble example
```

## 🎯 Bot Strategy Comparison

| Bot | Movement | Targeting | Difficulty | Best For |
|-----|----------|-----------|------------|----------|
| MyFirstBot | Seesaw | Gun spinning | ⭐ | Learning basics |
| SpinBot | Circular | Fire on scan | ⭐ | Movement patterns |
| Walls | Perimeter | Inward scanning | ⭐⭐ | Navigation |
| Corners | Corner seeking | Distance-based | ⭐⭐ | Adaptive AI |
| Crazy | Zigzag | Opportunistic | ⭐⭐ | Complex movement |
| VelocityBot | Rate-based | Scan and fire | ⭐⭐⭐ | Advanced control |
| AdvancedBot | Strategic | Combat analytics | ⭐⭐⭐ | Full capabilities |

## 🛠 Customizing the Examples

### 1. Basic Modifications

```nim
# Change bot colors
bot.setBodyColor("#FF0000")    # Red
bot.setTurretColor("#00FF00")  # Green

# Modify firing strategy
method onScannedBot*(bot: MyBot, event: ScannedBotEvent) =
  let distance = bot.distanceTo(event.x, event.y)
  if distance < 100.0:
    bot.fire(3.0)  # Maximum power for close targets
  else:
    bot.fire(1.0)  # Conserve energy for distant targets
```

### 2. Advanced Strategy Implementation

```nim
type
  CustomBot* = ref object of NetworkBot
    currentStrategy: Strategy
    enemyPositions: seq[Position]
    lastSeenEnemy: float

method run*(bot: CustomBot) =
  while bot.isRunning():
    case bot.currentStrategy:
    of Aggressive:
      bot.seekAndDestroy()
    of Defensive:
      bot.defendPosition()
    of Evasive:
      bot.evadeAndSurvive()
```

### 3. Creating New Bot Templates

Use `basic_bot_template.nim` as a starting point:

1. Copy the template
2. Rename the bot class and file
3. Modify the strategy in the `run()` method
4. Customize event handlers
5. Update bot info (name, description, etc.)

## 📊 Performance Tips

### Optimization Guidelines

1. **Keep turn logic simple** - Complex calculations slow down your bot
2. **Use efficient firing strategies** - Don't waste energy on impossible shots
3. **Implement smart scanning** - Focus radar on enemy-rich areas
4. **Balance aggression and survival** - Don't be too aggressive early in the game

### Debugging Features

All bots include debug logging:

```nim
# Enable debug mode
let bot = newMyBot(botInfo, debugMode = true)

# Logs are written to console and files
bot.log("Custom debug message")
```

## 🔧 Development Workflow

### 1. Testing New Bots

```bash
# Compile and test
nim c --path:src examples/your_bot.nim

# Run with server
./your_bot  # Make sure server is running first
```

### 2. Battle Testing

1. Start Tank Royale server
2. Run multiple bot instances
3. Use server GUI to start battles
4. Monitor bot logs for performance analysis

### 3. Iteration

1. Analyze battle results
2. Modify strategy in bot code
3. Test against different opponents
4. Refine and optimize

## 📚 Learning Path

### Beginner: Start Here
1. `my_first_bot.nim` - Learn basic concepts
2. `spin_bot.nim` - Understand movement
3. `basic_bot_template.nim` - Create your first custom bot

### Intermediate: Build Skills
1. `walls_bot.nim` - Learn navigation
2. `corners_bot.nim` - Understand adaptive AI
3. `crazy_bot.nim` - Master complex movement

### Advanced: Expert Level
1. `velocity_bot.nim` - Master movement control
2. `advanced_network_bot.nim` - Full-featured implementation
3. Create your own strategic innovations

## 🤝 Contributing

To add new example bots:

1. Follow the existing naming convention
2. Include comprehensive comments
3. Add event handlers with logging
4. Update this README
5. Test with Tank Royale server

## 📖 Further Reading

- [Tank Royale Official Documentation](https://robocode-dev.github.io/tank-royale/)
- [Nim Bot API Documentation](../IMPLEMENTATION_STATUS.md)
- [Testing Guide](../TESTING_GUIDE.md)
- [Networking Guide](../NETWORKING_SUCCESS.md)

---

**Happy Battling!** 🎮⚔️
