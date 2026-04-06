# Changelog

## [1.2.0] - 2026-04-06

### Security
- Replace `source .env` with safe grep-based `FAL_KEY` extraction to prevent arbitrary code execution
- Quote heredocs in all scripts to prevent command injection
- Validate and reject invalid API keys in `--add-fal-key` setup flow
- Add data handling boundary markers and harden credential documentation

### Changed
- Rewrite README setup section to be clear and actionable

## [1.1.0] - 2026-02-11

### Fixed
- MCP server configuration schema for fal
- Author field in SKILL.md
- Installation instructions in README

### Added
- Cinematography and storytelling reference for prompt crafting
- Version bump to 1.1.0

## [1.0.0] - 2026-02-11

### Added
- Initial release
- 14 scripts: generate, edit-image, upscale, text-to-speech, speech-to-text, search-models, get-schema, get-pricing, get-usage, estimate-cost, remove-background, list-queue, create-workflow, setup
- MCP integration with fal documentation server
- Queue mode (default) with polling for long-running tasks
- Async and sync modes for generation
- Local file upload via CDN token flow
- Model auto-routing based on model name patterns
- Reference documentation: MODELS.md, CINEMATOGRAPHY.md, PLATFORM.md, WORKFLOWS.md
- Interactive API key setup via `--add-fal-key`
