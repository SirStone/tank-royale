# bot-api/nim/build.nim

import os

# Define project name
let projectName = "bot_api"

# Define project version (optional)
let projectVersion = "0.1.0"

# Define source files
let srcFiles = @[
  "src/bot_api/base_bot.nim",
  "src/bot_api/bot.nim",
  "src/bot_api/bot_exception.nim",
  "src/bot_api/bot_info.nim",
  "src/bot_api/bot_results.nim",
  "src/bot_api/bot_state.nim",
  "src/bot_api/bullet_state.nim",
  "src/bot_api/constants.nim",
  "src/bot_api/default_event_priority.nim",
  "src/bot_api/droid.nim",
  "src/bot_api/game_setup.nim",
  "src/bot_api/game_type.nim",
  "src/bot_api/ibot.nim",
  "src/bot_api/ibot_base.nim",
  "src/bot_api/initial_position.nim",
  "src/bot_api/events/bot_death_event.nim",
  "src/bot_api/events/bot_event.nim",
  "src/bot_api/events/bullet_fired_event.nim",
  "src/bot_api/events/bullet_hit_bot_event.nim",
  "src/bot_api/events/bullet_hit_bullet_event.nim",
  "src/bot_api/events/bullet_hit_wall_event.nim",
  "src/bot_api/events/condition.nim",
  "src/bot_api/events/connected_event.nim",
  "src/bot_api/events/connection_error_event.nim",
  "src/bot_api/events/connection_event.nim",
  "src/bot_api/events/custom_event.nim",
  "src/bot_api/events/death_event.nim",
  "src/bot_api/events/disconnected_event.nim",
  "src/bot_api/events/game_ended_event.nim",
  "src/bot_api/events/game_started_event.nim",
  "src/bot_api/events/hit_bot_event.nim",
  "src/bot_api/events/hit_by_bullet_event.nim",
  "src/bot_api/events/hit_wall_event.nim",
  "src/bot_api/events/ievent.nim",
  "src/bot_api/events/next_turn_condition.nim",
  "src/bot_api/events/round_ended_event.nim",
  "src/bot_api/events/round_started_event.nim",
  "src/bot_api/events/scanned_bot_event.nim",
  "src/bot_api/events/skipped_turn_event.nim",
  "src/bot_api/events/team_message_event.nim",
  "src/bot_api/events/tick_event.nim",
  "src/bot_api/events/won_round_event.nim",
  "src/bot_api/internal/base_bot_internals.nim",
  "src/bot_api/internal/bot_event_handlers.nim",
  "src/bot_api/internal/bot_handshake_factory.nim",
  "src/bot_api/internal/bot_internals.nim",
  "src/bot_api/internal/env_vars.nim",
  "src/bot_api/internal/event_handler.nim",
  "src/bot_api/internal/event_interruption.nim",
  "src/bot_api/internal/event_priorities.nim",
  "src/bot_api/internal/event_queue.nim",
  "src/bot_api/internal/graphics_state.nim",
  "src/bot_api/internal/istop_resume_listener.nim",
  "src/bot_api/internal/instant_event_handlers.nim",
  "src/bot_api/internal/recording_text_writer.nim",
  "src/bot_api/mapper/bot_state_mapper.nim",
  "src/bot_api/mapper/bullet_state_mapper.nim",
  "src/bot_api/mapper/event_mapper.nim",
  "src/bot_api/mapper/game_setup_mapper.nim",
  "src/bot_api/mapper/initial_position_mapper.nim",
  "src/bot_api/mapper/results_mapper.nim",
  "src/bot_api/util/collection_util.nim",
  "src/bot_api/util/color_util.nim",
  "src/bot_api/util/country_code.nim",
  "src/bot_api/util/enum_util.nim",
  "src/bot_api/util/enumerable_extensions.nim",
  "src/bot_api/util/platform_util.nim",
  "src/bot_api/util/web_socket_client.nim"
]

# Define test files
let testFiles = @[
  "test/abstract_bot_test.nim",
  "test/base_bot_constructor_test.nim",
  "test/bot_info_test.nim",
  "test/initial_position_test.nim",
  "test/internal/env_vars_test.nim",
  "test/test_utils/environment_variables.nim",
  "test/test_utils/mocked_server.nim",
  "test/util/color_util_test.nim",
  "test/util/country_code_test.nim"
]

# Define compiler options
let compilerOptions = @[
  "-d:release", # Compile in release mode
  "-o:build/" & projectName, # Output file
  "-I:src",
  "-I:test" # Include the src directory
]

# Compile the project
proc compileProject() =
  echo "Compiling project: ", projectName
  var cmd = "nim c " & join(compilerOptions, " ") & " " & join(srcFiles, " ")
  echo "Executing: ", cmd
  execShellCmd(cmd)

# Run tests
proc runTests() =
    echo "Running tests"
    for file in testFiles:
        var cmd = "nim c -r " & file
        echo "Running: ", cmd
        execShellCmd(cmd)

# Main entry point
when isMainModule:
  createDir("build")
  compileProject()
  runTests()
  echo "Build completed."