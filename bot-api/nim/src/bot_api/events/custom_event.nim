import bot_api/events/event_abc, bot_api/events/condition

type
  CustomEvent* = ref object of BotEvent
    condition*: Condition # Condition for triggering this event
    customEvent*: string # Custom event message (used to distinct the different custom events)

proc newCustomEvent*(condition: Condition, customEvent: string): CustomEvent =
  ## Creates a new CustomEvent.
  result = CustomEvent()
  result.customEvent = customEvent
  result.condition = condition

proc getCondition*(event: CustomEvent): Condition =
  ## Returns the condition of this custom event.
  result = event.condition

proc getCustomEvent*(event: CustomEvent): string =
    ## Gets the custom event message.
    result = event.customEvent
