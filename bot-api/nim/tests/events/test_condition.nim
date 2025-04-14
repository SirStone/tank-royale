nim
import unittest
import ../src/bot_api/events/condition

suite "Condition":
  test "Test Condition default values":
    let condition = Condition()
    check condition.maxTries == 0
    check condition.priority == 0
    check condition.name == ""

  test "Test Condition constructor with parameters":
    let condition = Condition(maxTries = 5, priority = 2, name = "MyCondition")
    check condition.maxTries == 5
    check condition.priority == 2
    check condition.name == "MyCondition"
  
  test "Test setMaxTries":
    var condition = Condition()
    condition.maxTries = 10
    check condition.maxTries == 10

  test "Test setPriority":
    var condition = Condition()
    condition.priority = 3
    check condition.priority == 3

  test "Test setName":
    var condition = Condition()
    condition.name = "NewName"
    check condition.name == "NewName"