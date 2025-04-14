nim
import unittest
import ../src/bot_api/events/i_event

suite "IEvent":
  test "getPriority should return DefaultEventPriority.NORMAL":
    let event = object of IEvent
    check event.getPriority() == DefaultEventPriority.NORMAL

  test "getCondition should return a Condition":
    let event = object of IEvent
    check event.getCondition() is Condition

  test "setDefaultPriority should set the priority":
    let event = object of IEvent
    event.setDefaultPriority(DefaultEventPriority.HIGH)
    check event.getPriority() == DefaultEventPriority.HIGH

  test "setCondition should set the condition":
    let event = object of IEvent
    let condition = object of Condition
    event.setCondition(condition)
    check event.getCondition() is Condition
    check event.getCondition() == condition

  test "isConditionMet should return true":
    let event = object of IEvent
    check event.isConditionMet() == true

  test "isConditionMet with condition should return true":
    let event = object of IEvent
    let condition = object of Condition
    event.setCondition(condition)
    check event.isConditionMet() == true