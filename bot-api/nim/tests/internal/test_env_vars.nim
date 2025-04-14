nim
import unittest
import ../src/bot_api/internal/env_vars

suite "EnvVars":
  test "test getEnvVar with existing variable":
    let key = "TEST_VAR"
    let value = "test_value"
    putEnv(key, value)
    check EnvVars.getEnvVar(key) == value

  test "test getEnvVar with non-existing variable":
    let key = "NON_EXISTING_VAR"
    check EnvVars.getEnvVar(key) == ""

  test "test getEnvVar with empty key":
    check EnvVars.getEnvVar("") == ""

  test "test getEnvVarOrDefault with existing variable":
    let key = "TEST_VAR_2"
    let value = "test_value_2"
    let defaultValue = "default_value"
    putEnv(key, value)
    check EnvVars.getEnvVarOrDefault(key, defaultValue) == value

  test "test getEnvVarOrDefault with non-existing variable":
    let key = "NON_EXISTING_VAR_2"
    let defaultValue = "default_value"
    check EnvVars.getEnvVarOrDefault(key, defaultValue) == defaultValue

  test "test getEnvVarOrDefault with empty key":
    let defaultValue = "default_value"
    check EnvVars.getEnvVarOrDefault("", defaultValue) == defaultValue

  test "test getEnvVarOrDefault with empty default value":
    let key = "NON_EXISTING_VAR_3"
    check EnvVars.getEnvVarOrDefault(key, "") == ""