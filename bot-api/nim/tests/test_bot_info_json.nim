## Test JSON configuration loading for BotInfo
## Tests the new fromJsonFile, fromJsonString, and autoLoadFromFile functions

import unittest2
import ../src/bot_api/bot_info
import os, json

suite "BotInfo JSON Loading Tests":
  
  setup:
    # Clean up any test files from previous runs
    if fileExists("TestBot.json"):
      removeFile("TestBot.json")
    if fileExists("MyFirstBot.json"):
      removeFile("MyFirstBot.json")
  
  teardown:
    # Clean up test files
    if fileExists("TestBot.json"):
      removeFile("TestBot.json")
    if fileExists("MyFirstBot.json"):
      removeFile("MyFirstBot.json")
  
  test "fromJsonString - valid complete JSON":
    let jsonStr = """
    {
      "name": "TestBot",
      "version": "1.0.0",
      "authors": ["Author 1", "Author 2"],
      "description": "A test bot",
      "homepage": "https://example.com",
      "countryCodes": ["US", "uk"],
      "gameTypes": ["classic", "melee"],
      "platform": "Nim",
      "programmingLang": "Nim 2.0",
      "initialPosition": null
    }
    """
    
    let botInfo = fromJsonString(jsonStr)
    
    check botInfo.name == "TestBot"
    check botInfo.version == "1.0.0"
    check botInfo.authors == @["Author 1", "Author 2"]
    check botInfo.description == "A test bot"
    check botInfo.homepage == "https://example.com"
    check botInfo.countryCodes == @["US", "UK"]  # Should be uppercase
    check botInfo.gameTypes == @["classic", "melee"]
    check botInfo.platform == "Nim"
    check botInfo.programmingLang == "Nim 2.0"
  
  test "fromJsonString - minimal required fields only":
    let jsonStr = """
    {
      "name": "MinimalBot",
      "version": "2.0",
      "authors": ["Solo Author"]
    }
    """
    
    let botInfo = fromJsonString(jsonStr)
    
    check botInfo.name == "MinimalBot"
    check botInfo.version == "2.0"
    check botInfo.authors == @["Solo Author"]
    check botInfo.description == ""
    check botInfo.homepage == ""
    check botInfo.countryCodes.len == 0
    check botInfo.gameTypes.len == 0
    check botInfo.platform == "Nim"  # Default value
    check botInfo.programmingLang == "Nim"  # Default value
  
  test "fromJsonString - missing required field name":
    let jsonStr = """
    {
      "version": "1.0",
      "authors": ["Author"]
    }
    """
    
    expect(ValueError):
      discard fromJsonString(jsonStr)
  
  test "fromJsonString - missing required field version":
    let jsonStr = """
    {
      "name": "TestBot",
      "authors": ["Author"]
    }
    """
    
    expect(ValueError):
      discard fromJsonString(jsonStr)
  
  test "fromJsonString - missing required field authors":
    let jsonStr = """
    {
      "name": "TestBot",
      "version": "1.0"
    }
    """
    
    expect(ValueError):
      discard fromJsonString(jsonStr)
  
  test "fromJsonString - empty authors array":
    let jsonStr = """
    {
      "name": "TestBot",
      "version": "1.0",
      "authors": []
    }
    """
    
    expect(ValueError):
      discard fromJsonString(jsonStr)
  
  test "fromJsonFile - valid file":
    # Create test JSON file
    let testJson = """
    {
      "name": "FileBot",
      "version": "3.0",
      "authors": ["File Author"],
      "description": "Bot loaded from file",
      "gameTypes": ["1v1"]
    }
    """
    writeFile("TestBot.json", testJson)
    
    let botInfo = fromJsonFile("TestBot.json")
    
    check botInfo.name == "FileBot"
    check botInfo.version == "3.0"
    check botInfo.authors == @["File Author"]
    check botInfo.description == "Bot loaded from file"
    check botInfo.gameTypes == @["1v1"]
  
  test "fromJsonFile - file not found":
    expect(IOError):
      discard fromJsonFile("NonExistent.json")
  
  test "tryFromJsonFile - valid file":
    let testJson = """
    {
      "name": "TryBot",
      "version": "1.5",
      "authors": ["Try Author"]
    }
    """
    writeFile("TestBot.json", testJson)
    
    let botInfo = tryFromJsonFile("TestBot.json")
    
    check botInfo.name == "TryBot"
    check botInfo.version == "1.5"
    check botInfo.authors == @["Try Author"]
  
  test "tryFromJsonFile - file not found returns default":
    let botInfo = tryFromJsonFile("NonExistent.json")
    
    check botInfo.name == "DefaultBot"
    check botInfo.version == "1.0"
    check botInfo.authors == @["Unknown"]
  
  test "autoLoadFromFile - file exists in current directory":
    let testJson = """
    {
      "name": "AutoBot",
      "version": "2.5",
      "authors": ["Auto Author"],
      "description": "Automatically loaded bot"
    }
    """
    writeFile("MyFirstBot.json", testJson)
    
    let botInfo = autoLoadFromFile("MyFirstBot")
    
    check botInfo.name == "AutoBot"
    check botInfo.version == "2.5"
    check botInfo.authors == @["Auto Author"]
    check botInfo.description == "Automatically loaded bot"
  
  test "autoLoadFromFile - file not found returns default":
    let botInfo = autoLoadFromFile("NonExistentBot")
    
    check botInfo.name == "NonExistentBot"
    check botInfo.version == "1.0"
    check botInfo.authors == @["Unknown"]
  
  test "fromJsonString - handles whitespace in fields":
    let jsonStr = """
    {
      "name": "  SpacedBot  ",
      "version": " 1.0 ",
      "authors": ["  Author 1  ", "Author 2"],
      "countryCodes": ["  us  ", "UK"]
    }
    """
    
    let botInfo = fromJsonString(jsonStr)
    
    check botInfo.name == "SpacedBot"  # Should be trimmed
    check botInfo.version == "1.0"     # Should be trimmed
    check botInfo.authors == @["Author 1", "Author 2"]  # Should be trimmed
    check botInfo.countryCodes == @["US", "UK"]  # Should be trimmed and uppercase

  test "JSON compatibility with Tank Royale example":
    # Test with actual Tank Royale JSON format from examples
    let tankRoyaleJson = """
    {
      "name": "MyFirstBot",
      "version": "1.0.0",
      "authors": [
        "Mathew Nelson",
        "Nim Community"
      ],
      "description": "A simple bot with basic seesaw motion pattern",
      "homepage": "https://github.com/robocode-dev/tank-royale",
      "countryCodes": [
        "US"
      ],
      "gameTypes": [
        "classic",
        "melee",
        "1v1"
      ],
      "platform": "Nim",
      "programmingLang": "Nim",
      "initialPosition": null
    }
    """
    
    let botInfo = fromJsonString(tankRoyaleJson)
    
    check botInfo.name == "MyFirstBot"
    check botInfo.version == "1.0.0"
    check botInfo.authors == @["Mathew Nelson", "Nim Community"]
    check botInfo.description == "A simple bot with basic seesaw motion pattern"
    check botInfo.homepage == "https://github.com/robocode-dev/tank-royale"
    check botInfo.countryCodes == @["US"]
    check botInfo.gameTypes == @["classic", "melee", "1v1"]
    check botInfo.platform == "Nim"
    check botInfo.programmingLang == "Nim"
