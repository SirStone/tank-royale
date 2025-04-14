type
  IStopResumeListener* = interface
    ## Interface for stop/resume listener.
    ##
    ## This interface is used to handle events when the bot is stopped or resumed.

  StopResumeEventHandler* = proc()


proc onStopped*(listener: IStopResumeListener, handler: StopResumeEventHandler)
  ## This method is called when the bot is stopped.
  ##
  ## Args:
  ##   handler: The handler for the stopped event.


proc onResumed*(listener: IStopResumeListener, handler: StopResumeEventHandler)
  ## This method is called when the bot is resumed.
  ##
  ## Args:
  ##   handler: The handler for the resumed event.