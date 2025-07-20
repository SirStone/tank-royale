# Bot API Project Base Knowledge

## Overview
This project provides Bot APIs for the Tank Royale game, supporting multiple programming languages and platforms. The APIs are organized into separate directories for .NET (C#), Java, Nim, and Python, each with its own implementation, documentation, and tests.

## Directory Structure
- **dotnet/**: C# implementation of the Bot API. Contains source code, tests, documentation, and build scripts.
- **java/**: Java implementation. Includes source code, build scripts, and generated files.
- **nim/**: Nim implementation. Contains source code, tests, and build scripts.
- **python/**: Python implementation. Includes source code, tests, requirements, and build scripts.
- **schema/**: Shared schema definitions and code generators for API models, used across languages.
- **docs/**, **nuget-docs-template/**, **docfx-project/**: Documentation resources and templates for publishing API docs.

## Common Concepts
- **Bot**: The main entity representing a player in the Tank Royale game. Each language implementation provides a `Bot` class/interface and related models (e.g., `BotInfo`, `BotState`, `BotResults`).
- **Events**: The API supports various game events (e.g., `BotHitWallEvent`, `BulletFiredEvent`) for bots to react to game state changes.
- **Game Setup**: Models and utilities for configuring and initializing games, such as `GameSetup`, `InitialPosition`, and `GameType`.
- **Utilities**: Helper modules for common tasks (e.g., constants, event priorities, internal logic).

## Build & Test
- Each language directory contains its own build scripts (e.g., `build.gradle.kts`, `setup.py`, `build.nim`) and test suites.
- Schemas are used to generate code for API models in each language.

## Usage
- To use the Bot API, select the appropriate language directory and follow its README for setup and usage instructions.
- Bots can be implemented by extending the provided base classes/interfaces and handling game events.

## Documentation
- Documentation is available in the `docs/`, `docfx-project/`, and `nuget-docs-template/` directories.
- Each language implementation has its own README and may provide additional usage notes.

## Extensibility
- The project is designed to be extensible for new languages and platforms by following the schema-driven approach and directory structure.

---
This file summarizes the base knowledge of the Tank Royale Bot API project and can be used as context for AI instructions or further development.

---
# MAIN GOAL

- You are a skilled nim developer, and you are in charge of fixing the nim implementation of the API.
- You want use the lastes nim 2.0 or greater
- You base the ground thruth of knowledge on the "java" implementation, ignore the "dotnet" and "pyhton" implementations
- tests comes first
- you want to use the devbox tools in order to install the required libraries locally