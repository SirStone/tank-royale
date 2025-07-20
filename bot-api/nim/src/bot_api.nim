# Tank Royale Bot API for Nim
# Main module that exports all public interfaces

import bot_api/[
  bot_info,
  bot_state, 
  bullet_state,
  bot_results,
  game_setup,
  game_type,
  initial_position,
  constants,
  i_base_bot,
  i_bot,
  base_bot,
  bot,
  bot_exception
]

import bot_api/events/[
  ievent,
  bot_event,
  tick_event,
  scanned_bot_event,
  hit_by_bullet_event,
  hit_bot_event,
  hit_wall_event,
  bullet_fired_event,
  bullet_hit_bot_event,
  bullet_hit_wall_event,
  bullet_hit_bullet_event,
  bot_death_event,
  death_event,
  won_round_event,
  skipped_turn_event,
  connected_event,
  disconnected_event,
  connection_error_event,
  game_started_event,
  game_ended_event,
  round_started_event,
  round_ended_event
]

export bot_info, bot_state, bullet_state, bot_results, game_setup, 
       game_type, initial_position, constants, i_base_bot, i_bot, 
       base_bot, bot, bot_exception

export ievent, bot_event, tick_event, scanned_bot_event, hit_by_bullet_event,
       hit_bot_event, hit_wall_event, bullet_fired_event, bullet_hit_bot_event,
       bullet_hit_wall_event, bullet_hit_bullet_event, bot_death_event, death_event,
       won_round_event, skipped_turn_event, connected_event, disconnected_event,
       connection_error_event, game_started_event, game_ended_event,
       round_started_event, round_ended_event
