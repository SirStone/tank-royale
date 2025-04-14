nim
import unittest
import ../src/bot_api/internal/i_stop_resume_listener

suite "IStopResumeListener":
  test "stop":
    var listener = object of IStopResumeListener
    listener.stop()
    # Add assertions here if you have a way to verify that 'stop' was called and had an effect.
    check: true

  test "resume":
    var listener = object of IStopResumeListener
    listener.resume()
    # Add assertions here if you have a way to verify that 'resume' was called and had an effect.
    check: true