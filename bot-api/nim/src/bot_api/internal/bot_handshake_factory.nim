import bot_info
import json_util

type
  BotHandshakeFactory* = ref object

proc newBotHandshakeFactory*(): BotHandshakeFactory =
  BotHandshakeFactory()

proc create*(factory: BotHandshakeFactory, botInfo: BotInfo): string =
  var handshake = %* {
    "type": "bot-handshake",
    "name": botInfo.name,
    "version": botInfo.version,
    "authors": botInfo.authors.toSeq,
    "description": botInfo.description,
    "url": botInfo.url,
    "countryCodes": botInfo.countryCodes.toSeq,
    "gameTypes": botInfo.gameTypes.toSeq
  }

  var jsonString: string
  jsonString = $handshake

  return jsonString