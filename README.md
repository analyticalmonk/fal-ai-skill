# fal — Claude Code Plugin

Generate images, videos, audio, and more using [fal.ai](https://fal.ai) AI models directly from Claude Code.

## Installation

```bash
claude plugin add fal-ai/fal-ai-skill
```

## Setup

1. Get your API key at [fal.ai/dashboard/keys](https://fal.ai/dashboard/keys)
2. Run the setup script:

```
/fal setup
```

Or set your key directly:

```bash
export FAL_KEY=your_key_here
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

## License

MIT
