# Testing the Nim Bot in a Real Tank Royale Environment

## Overview

The Nim Tank Royale Bot API now includes full networking capabilities that allow your bot to connect to a real Tank Royale server and participate in actual battles. This guide shows you how to test your bot and monitor its behavior.

## Prerequisites

1. **Tank Royale Server**: Download and run the Tank Royale server from [Tank Royale Releases](https://github.com/robocode-dev/tank-royale/releases)
2. **Nim Dependencies**: Ensure you have the WebSocket library installed:
   ```bash
   nimble install ws
   ```

## Quick Start

### 1. Start the Tank Royale Server

```bash
# Download Tank Royale server (replace with latest version)
wget https://github.com/robocode-dev/tank-royale/releases/download/0.12.4/tank-royale-server-0.12.4.zip
unzip tank-royale-server-0.12.4.zip
cd tank-royale-server-0.12.4

# Start the server
java -jar tank-royale-server-0.12.4.jar
```

The server will start on `localhost:7654` by default.

### 2. Run the Advanced Network Bot Example

```bash
cd /home/davide/Projects/tank-royale/bot-api/nim
nim c -r examples/advanced_network_bot.nim
```

### 3. Monitor Bot Output

The bot provides comprehensive logging with timestamps:

```
=== Tank Royale Nim Bot - Advanced Networked Example ===
Created bot: MyTankBot v1.0.0
Server URL: ws://localhost:7654
Debug mode: true

[14:32:15.123] Starting bot: MyTankBot
[14:32:15.124] Server URL: ws://localhost:7654
[14:32:15.125] [WebSocket] Connecting to ws://localhost:7654...
[14:32:15.130] [WebSocket] Connected successfully!
[14:32:15.131] Connected to Tank Royale server!
[14:32:15.145] [WebSocket] Received: {"type":"ServerHandshake","sessionId":"abc123",...}
[14:32:15.146] [WebSocket] Sending handshake: {"type":"BotHandshake",...}
[14:32:15.200] Received GameStartedEventForBot
[14:32:15.201] Game started! My ID: 1
[14:32:15.202] Sent BotReady
[14:32:16.000] Received RoundStartedEvent
[14:32:16.001] Round 1 started!
[14:32:16.050] Received TickEventForBot
[14:32:16.051] Turn 1: Energy=100.0, X=400.0, Y=300.0, Direction=0.0°
[14:32:16.052] New target: (567.3, 234.7)
[14:32:16.053]   Actions: Speed=50.0, Turn=5.0°, RadarTurn=10.0°
```

## Log Files

When debug mode is enabled, the bot creates detailed log files:

- **Filename**: `bot_log_MyTankBot_2025-07-20_14-32-15.txt`
- **Location**: Same directory as the bot executable
- **Content**: All console output plus additional debug information

## Available Monitoring Features

### 1. Real-time Console Output

- **Connection status**: WebSocket connection events
- **Game events**: Game/round start/end notifications
- **Turn information**: Current turn, bot position, energy, direction
- **Enemy detection**: Positions and status of enemy bots
- **Combat events**: Bullet hits, collisions, firing events
- **Strategy decisions**: Bot's movement and targeting choices

### 2. Detailed Log Files

The log files contain:
```
[14:32:16.051] Turn 1: Energy=100.0, X=400.0, Y=300.0, Direction=0.0°
[14:32:16.052]   Enemy 2: Energy=95.0, X=600.0, Y=200.0
[14:32:16.053]   Bullet 15: X=450.0, Y=280.0
[14:32:16.054]   Actions: Speed=50.0, Turn=5.0°, RadarTurn=10.0°, Fire=2.0
[14:32:16.155] COMBAT: Bullet hit bot 2 for 8.0 damage!
[14:32:16.200] WEAPON: Fired bullet 16
```

### 3. Network Protocol Monitoring

See raw WebSocket messages between bot and server:
```
[14:32:15.145] [WebSocket] Received: {"type":"TickEventForBot","turnNumber":1,...}
[14:32:15.200] [WebSocket] Sending: {"type":"BotIntent","targetSpeed":50.0,...}
```

## Testing Different Scenarios

### 1. Multi-Bot Battles

Create multiple bot instances:

```bash
# Terminal 1
nim c -r examples/advanced_network_bot.nim

# Terminal 2 (modify the bot name first)
nim c -r examples/advanced_network_bot_2.nim
```

### 2. Custom Server Configuration

Modify the server URL in your bot:

```nim
result = cast[MyTankBot](newNetworkBot(
  botInfo = botInfo,
  serverUrl = "ws://your-server:7654",  # Custom server
  serverSecret = "your-secret",         # If server requires authentication
  debugMode = true
))
```

### 3. Different Game Types

Configure your bot for different game modes:

```nim
let botInfo = newBotInfo(
  name = "MyTankBot",
  gameTypes = @["classic", "melee", "1v1", "team"],  # Support multiple types
  # ... other properties
)
```

## Debugging Features

### 1. Turn-by-Turn Analysis

Each turn shows:
- **Bot state**: Position, energy, direction, speed
- **Sensor data**: Enemy positions, bullet locations
- **Decision making**: What actions the bot chooses
- **Action results**: Success/failure of commands

### 2. Combat Monitoring

Track combat effectiveness:
- Shots fired vs. hits landed
- Damage dealt vs. damage received
- Collision events and their consequences

### 3. Strategy Validation

Monitor strategy execution:
- Movement patterns and target selection
- Radar scanning effectiveness  
- Energy management decisions

## Performance Monitoring

### 1. Turn Timing

Watch for performance issues:
```
[14:32:16.200] WARNING: Skipped turn (too slow)!
```

### 2. Connection Health

Monitor network stability:
```
[14:32:20.500] [WebSocket] Connection closed by server
[14:32:20.501] Disconnected from Tank Royale server
```

## Example Use Cases

### 1. Algorithm Testing

Test pathfinding, targeting, or evasion algorithms:

```nim
method run*(bot: MyTankBot) =
  # Your algorithm here
  let targetAngle = bot.calculateOptimalAngle()
  bot.turnRight(targetAngle)
  bot.forward(bot.calculateOptimalSpeed())
  
  # Log decision rationale
  bot.log(&"Target angle: {targetAngle:.1f}°, reasoning: {bot.getDecisionReasoning()}")
```

### 2. Machine Learning Training

Collect training data:

```nim
method run*(bot: MyTankBot) =
  # Collect state information
  let gameState = bot.getCurrentGameState()
  let action = bot.decideAction(gameState)
  
  # Log for ML training
  bot.log(&"STATE: {gameState}, ACTION: {action}")
  
  # Execute action
  bot.executeAction(action)
```

### 3. Tournament Preparation

Test bot performance against different opponents:
- Configure different bot personalities
- Run multiple rounds to gather statistics
- Analyze win/loss patterns

## Troubleshooting

### Connection Issues

```bash
# Check if server is running
curl -i -N -H "Connection: Upgrade" -H "Upgrade: websocket" \
     -H "Sec-WebSocket-Key: test" -H "Sec-WebSocket-Version: 13" \
     http://localhost:7654/

# Or check with netstat
netstat -an | grep 7654
```

### Debug Mode Issues

If logging isn't working:
```nim
# Ensure debug mode is enabled
let bot = newNetworkBot(debugMode = true)

# Check file permissions
# Log files are created in current working directory
```

### Performance Issues

If bot is skipping turns:
```nim
method run*(bot: MyTankBot) =
  # Keep AI logic simple and fast
  # Avoid heavy calculations or I/O operations
  # Use pre-computed lookup tables where possible
```

## Next Steps

1. **Create your own bot strategy** by modifying the `run()` method
2. **Implement advanced features** like team communication or machine learning
3. **Participate in tournaments** by connecting to public Tank Royale servers
4. **Contribute improvements** to the Nim Bot API

The Nim Tank Royale Bot API now provides a complete environment for testing, debugging, and deploying competitive tank bots!
