# Recommended Models by Category

## Text-to-Image

| Model | Notes |
|-------|-------|
| `fal-ai/nano-banana-pro` | **Best overall** - T2I and editing |
| `fal-ai/flux-2-turbo` | Open source, high quality |
| `fal-ai/flux-2-klein-9b` | Open source, fast |
| `fal-ai/flux/dev` | Good balance (default) |
| `fal-ai/flux/schnell` | ~1 second |
| `fal-ai/ideogram/v3` | Best for text rendering |
| `fal-ai/recraft-v3` | Design-focused |

## Text-to-Video

| Model | Notes |
|-------|-------|
| `fal-ai/veo3.1` | High quality |
| `fal-ai/bytedance/seedance/v1/pro` | Fast, good quality |
| `fal-ai/sora-2/pro` | OpenAI Sora |
| `fal-ai/kling-video/v2.5-turbo/pro` | Fast, reliable |
| `fal-ai/minimax/hailuo-02/pro` | Good for characters |

## Image-to-Video

| Model | Notes |
|-------|-------|
| `fal-ai/kling-video/v2.6/pro/image-to-video` | **Best overall** |
| `fal-ai/veo3/fast` | Fast, high quality |
| `fal-ai/bytedance/seedance/v1.5/pro/image-to-video` | Smooth motion |
| `fal-ai/minimax/hailuo-02/standard/image-to-video` | Good balance |
| `fal-ai/kling-video/o1/image-to-video` | First/last frame support |

## Text-to-Speech

| Model | Notes |
|-------|-------|
| `fal-ai/minimax/speech-2.6-hd` | **Best quality** |
| `fal-ai/minimax/speech-2.6-turbo` | Fast, good quality |
| `fal-ai/elevenlabs/eleven-v3` | Natural voices |
| `fal-ai/chatterbox/multilingual` | Multi-language, fast |
| `fal-ai/kling-video/v1/tts` | For video sync |

## Text-to-Music

| Model | Notes |
|-------|-------|
| `fal-ai/minimax-music/v2` | **Best quality** |
| `fal-ai/minimax-music/v1.5` | Fast |
| `fal-ai/lyria2` | Google's model |
| `fal-ai/elevenlabs/music` | Song generation |
| `fal-ai/sonauto/v2` | Instrumental |
| `fal-ai/ace-step` | Short clips |
| `fal-ai/beatoven` | Background music |

## Speech-to-Text

| Model | Features | Speed |
|-------|----------|-------|
| `fal-ai/whisper` | Multi-language, timestamps | Fast |
| `fal-ai/elevenlabs/scribe` | Speaker diarization | Medium |

## Image Editing

| Operation | Model | Description |
|-----------|-------|-------------|
| General Edit | `fal-ai/nano-banana-pro` | Best quality edits |
| Style Transfer | `fal-ai/flux/dev/image-to-image` | Apply style to image |
| Object Removal | `fal-ai/bria/fibo-edit` | Remove objects from image |
| Background Change | `fal-ai/flux-kontext` | Change/replace background |
| Inpainting | `fal-ai/flux/dev/inpainting` | Fill in masked areas |

## Image Upscale

| Model | Scale | Best For |
|-------|-------|----------|
| `fal-ai/aura-sr` | 4x | General upscaling, fast |
| `fal-ai/clarity-upscaler` | 2-4x | Detail preservation |
| `fal-ai/creative-upscaler` | 2-4x | Creative enhancement |

## Video Upscale

| Model | Notes |
|-------|-------|
| `fal-ai/video-upscaler` | General purpose |
| `fal-ai/topaz/upscale/video` | **Premium quality** |
| `fal-ai/bria/video/increase-resolution` | Fast |
| `fal-ai/flashvsr` | Real-time |
| `fal-ai/seedvr/upscale/video` | High fidelity |
| `fal-ai/bytedance-upscaler` | Good balance |

## Workflow Utilities

| Task | Model | Output Reference |
|------|-------|-----------------|
| Text concat (2 texts) | `fal-ai/text-concat` | `$node.results` |
| Text merge (array) | `fal-ai/workflow-utilities/merge-text` | `$node.text` |
| Video merge | `fal-ai/ffmpeg-api/merge-videos` | `$node.video.url` |
| Audio+Video merge | `fal-ai/ffmpeg-api/merge-audio-video` | `$node.video.url` |
| Frame extract | `fal-ai/ffmpeg-api/extract-frame` | `$node.frame.url` |
| Crop image | `fal-ai/workflow-utilities/crop-image` | `$node.image.url` |
| Remove background | `fal-ai/bria/background/remove` | `$node.image.url` |
| Image upscale | `fal-ai/seedvr/upscale/image` | `$node.image.url` |
| Image to 3D | `fal-ai/hunyuan3d-v3/image-to-3d` | `$node.model_mesh.url` |
| LLM (text) | `openrouter/router` | `$node.output` |
| LLM (vision) | `openrouter/router/vision` | `$node.output` |
