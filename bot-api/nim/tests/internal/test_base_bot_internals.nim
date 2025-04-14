nim
import unittest
import ../src/bot_api/internal/base_bot_internals

suite "BaseBotInternals Tests":
  var internals: BaseBotInternals

  setup:
    internals = BaseBotInternals()

  test "Test constructor":
    check:
      internals != nil

  test "Test getBot":
    check:
      internals.getBot() == nil

  test "Test setBot":
    let myBot = newBot()
    internals.setBot(myBot)
    check:
      internals.getBot() == myBot

  test "Test getRecordingTextWriter":
    check:
      internals.getRecordingTextWriter() != nil

  test "Test getBotEventHandlers":
    check:
      internals.getBotEventHandlers() != nil

  test "Test getInstantEventHandlers":
    check:
      internals.getInstantEventHandlers() != nil

  test "Test getEventQueue":
    check:
      internals.getEventQueue() != nil

  test "Test getGraphicsState":
    check:
      internals.getGraphicsState() != nil

  test "Test isRunning":
    check:
      internals.isRunning() == false
  
  test "Test isRunning - true":
    internals.start()
    check:
      internals.isRunning() == true

  test "Test start":
    internals.start()
    check:
      internals.isRunning() == true

  test "Test stop":
    internals.start()
    internals.stop()
    check:
      internals.isRunning() == false

  test "Test resume":
    internals.start()
    internals.stop()
    internals.resume()
    check:
      internals.isRunning() == true

  test "Test addStopResumeListener":
    let listener = newIStopResumeListener()
    internals.addStopResumeListener(listener)
    check:
      internals.listeners.len == 1

  test "Test removeStopResumeListener":
    let listener = newIStopResumeListener()
    internals.addStopResumeListener(listener)
    internals.removeStopResumeListener(listener)
    check:
      internals.listeners.len == 0

  test "Test getBaseBotHandshake":
    check:
      internals.getBaseBotHandshake() != nil

  test "Test getBaseBotHandshake - same bot":
    check:
      internals.getBaseBotHandshake().getBot() == internals.getBot()

  test "Test getBaseBotHandshake - same recording writer":
    check:
      internals.getBaseBotHandshake().getRecordingTextWriter() == internals.getRecordingTextWriter()

  test "Test getBaseBotHandshake - same bot event handler":
    check:
      internals.getBaseBotHandshake().getBotEventHandlers() == internals.getBotEventHandlers()

  test "Test getBaseBotHandshake - same instant event handler":
    check:
      internals.getBaseBotHandshake().getInstantEventHandlers() == internals.getInstantEventHandlers()

  test "Test getBaseBotHandshake - same event queue":
    check:
      internals.getBaseBotHandshake().getEventQueue() == internals.getEventQueue()

  test "Test getBaseBotHandshake - same graphics state":
    check:
      internals.getBaseBotHandshake().getGraphicsState() == internals.getGraphicsState()

  test "Test setBaseBotHandshake":
    let handshake = newBaseBotHandshake()
    internals.setBaseBotHandshake(handshake)
    check:
      internals.getBaseBotHandshake() == handshake