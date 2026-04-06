# fal - Claude Code Plugin

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.2.0-blue.svg)](.claude-plugin/plugin.json)

Generate images, videos, audio, and more using [fal.ai](https://fal.ai) AI models directly from Claude Code.

## Installation

```
/plugin marketplace add analyticalmonk/fal-ai-skill
/plugin install fal@fal-ai-skill
```

## Setup

1. Get your API key at [fal.ai/dashboard/keys](https://fal.ai/dashboard/keys)
2. The setup script is interactive - it prompts for your key directly. Run it yourself in the Claude Code prompt:

```
! bash skills/fal/scripts/setup.sh --add-fal-key
```

This saves your key to a `.env` file in your current working directory. The plugin reads it automatically from there.

If you already have a key, you can also create the `.env` file manually:

```
echo 'FAL_KEY="your-key-here"' > .env
```

## Capabilities

| Category | Examples |
|----------|----------|
| **Image Generation** | Text-to-image with Flux, NanoBanana, Ideogram |
| **Video Generation** | Text-to-video with Veo, image-to-video with Kling |
| **Audio** | Text-to-speech (MiniMax, ElevenLabs), speech-to-text (Whisper) |
| **Image Editing** | Style transfer, object removal, background replacement, inpainting |
| **Upscaling** | Image and video upscaling (Aura SR, Clarity, Topaz) |
| **Workflows** | Chain multiple models into pipelines |
| **Platform** | Pricing, usage tracking, cost estimation |

## Quick Start

Just ask Claude naturally:

- "Generate an image of a mountain landscape"
- "Create a video of ocean waves"
- "Convert this text to speech"
- "Remove the background from this image"
- "What fal models are available for video generation?"

## Model Discovery

The plugin includes the fal MCP server for searching documentation and discovering models. It also provides scripts for fetching exact OpenAPI schemas:

```
/fal search models for text-to-video
/fal get schema for fal-ai/flux/dev
```

## Troubleshooting

**FAL_KEY not set:** Run `! bash skills/fal/scripts/setup.sh --add-fal-key` in the Claude Code prompt to interactively set your key. It saves to `.env` in your working directory.

**Video generation timeout:** Video models can take several minutes. The plugin uses queue mode by default with a 10-minute timeout. For very long tasks, use async mode: `/fal generate --mode async --prompt "..."` and check status later.

**Unknown model parameters:** Use `/fal get schema for MODEL_ID` to see the exact parameters a model accepts. Not all models support all options (e.g., `image_size`, `num_images`).

## License

MIT
