# Workflow Reference

Generate production-ready fal.ai workflow JSON files that chain multiple AI models together.

## Core Architecture

### Valid Node Types

Only TWO valid node types exist:

| Type | Purpose |
|------|---------|
| `"run"` | Execute a model/app |
| `"display"` | Output results to user |

**INVALID:** `type: "input"` does NOT exist. Input is defined ONLY in `schema.input`.

### Reference Syntax

| Reference | Use Case | Example |
|-----------|----------|---------|
| `$input.field` | Input value | `$input.prompt` |
| `$node.output` | LLM text output | `$node-llm.output` |
| `$node.images.0.url` | First image URL | `$node-img.images.0.url` |
| `$node.image.url` | Single image URL | `$node-upscale.image.url` |
| `$node.video.url` | Video URL | `$node-vid.video.url` |
| `$node.audio_file.url` | Audio URL | `$node-music.audio_file.url` |
| `$node.frame.url` | Extracted frame | `$node-extract.frame.url` |
| `$node.results` | Text concat output | `$node-concat.results` |
| `$node.text` | Merge text output | `$node-merge.text` |

### CRITICAL: No String Interpolation

Variable MUST be the ENTIRE value. Never mix text with variables.

```json
// WRONG
"prompt": "Create image of $input.subject in $input.style"

// CORRECT
"prompt": "$input.prompt"
"prompt": "$node-llm.output"
```

To combine values, use `fal-ai/text-concat` or `fal-ai/workflow-utilities/merge-text`.

## Critical Rules

1. **Dependencies must match references** — every `$node-x.xxx` needs `"depends": ["node-x"]`
2. **ID must match object key** — `"my-node": { "id": "my-node" }`
3. **Use correct LLM type** — `openrouter/router` (text only) vs `openrouter/router/vision` (image analysis)
4. **Schema modelId required** — each input field needs `"modelId": "first-consuming-node"`
5. **Output depends on all referenced nodes**

## Minimal Working Example

```json
{
  "name": "my-workflow",
  "title": "My Workflow",
  "contents": {
    "name": "workflow",
    "nodes": {
      "output": {
        "type": "display",
        "id": "output",
        "depends": ["node-image"],
        "input": {},
        "fields": { "image": "$node-image.images.0.url" }
      },
      "node-image": {
        "type": "run",
        "id": "node-image",
        "depends": ["input"],
        "app": "fal-ai/flux/dev",
        "input": { "prompt": "$input.prompt" }
      }
    },
    "output": { "image": "$node-image.images.0.url" },
    "schema": {
      "input": {
        "prompt": {
          "name": "prompt",
          "label": "Prompt",
          "type": "string",
          "required": true,
          "modelId": "node-image"
        }
      },
      "output": {
        "image": { "name": "image", "label": "Generated Image", "type": "string" }
      }
    },
    "version": "1",
    "metadata": {
      "input": { "position": { "x": 0, "y": 0 } },
      "description": "Simple text to image workflow"
    }
  },
  "is_public": true,
  "user_id": "",
  "user_nickname": "",
  "created_at": ""
}
```

## Default Models for Workflows

| Task | Default Model |
|------|---------------|
| Image generation | `fal-ai/nano-banana-pro` |
| Image editing | `fal-ai/nano-banana-pro/edit` |
| Video (I2V) | `fal-ai/bytedance/seedance/v1.5/pro/image-to-video` |
| Text LLM | `openrouter/router` with `google/gemini-2.5-flash` |
| Vision LLM | `openrouter/router/vision` with `google/gemini-3-pro-preview` |
| Music | `fal-ai/elevenlabs/music` |
| Upscale | `fal-ai/seedvr/upscale/image` |
| Text concat | `fal-ai/text-concat` |
| Text merge | `fal-ai/workflow-utilities/merge-text` |
| Video merge | `fal-ai/ffmpeg-api/merge-videos` |
| Audio+Video merge | `fal-ai/ffmpeg-api/merge-audio-video` |
| Frame extract | `fal-ai/ffmpeg-api/extract-frame` |

## Common Patterns

### Pattern 1: LLM Prompt → Image → Video

```
[Input] → [LLM: Image Prompt] → [Image Gen]
                ↓
          [LLM: Video Prompt] → [Video Gen] → [Output]
```

### Pattern 2: Parallel Processing (Fan-Out)

```
                → [Process A] →
[Hub Node] → [Process B] → [Merge] → [Output]
                → [Process C] →
```

All parallel nodes depend on hub, NOT on each other.

### Pattern 3: Video Extension with Extract Frame

```
[Video 1] → [Extract Last Frame] → [Video 2 with Start Frame] → [Merge] → [Output]
```

```json
"node-extract": {
  "depends": ["node-video-1"],
  "app": "fal-ai/ffmpeg-api/extract-frame",
  "input": {
    "video_url": "$node-video-1.video.url",
    "frame_type": "last"
  }
},
"node-video-2": {
  "depends": ["node-extract", "node-prompt-2"],
  "app": "fal-ai/kling-video/o1/image-to-video",
  "input": {
    "prompt": "$node-prompt-2.output",
    "image_url": "$node-extract.frame.url"
  }
}
```

### Pattern 4: First/Last Frame Video (Kling O1)

```json
"node-video": {
  "depends": ["node-start-frame", "node-end-frame", "node-prompt"],
  "app": "fal-ai/kling-video/o1/image-to-video",
  "input": {
    "prompt": "$node-prompt.output",
    "image_url": "$node-start-frame.images.0.url",
    "tail_image_url": "$node-end-frame.images.0.url"
  }
}
```

### Pattern 5: Video with Custom Music

```json
"node-music": {
  "depends": ["input"],
  "app": "fal-ai/elevenlabs/music",
  "input": { "prompt": "$input.music_style" }
},
"node-merge": {
  "depends": ["node-video", "node-music"],
  "app": "fal-ai/ffmpeg-api/merge-audio-video",
  "input": {
    "video_url": "$node-video.video.url",
    "audio_url": "$node-music.audio_file.url"
  }
}
```

### Pattern 6: Text Combining (Label + Merge)

```json
"label-brand": {
  "app": "fal-ai/text-concat",
  "input": { "text1": "Brand expert:", "text2": "$brand-llm.output" }
},
"merged-context": {
  "depends": ["label-brand", "label-visual"],
  "app": "fal-ai/workflow-utilities/merge-text",
  "input": {
    "texts": ["$label-brand.results", "$label-visual.results"],
    "separator": "\n\n---\n\n"
  }
}
```

## Input Schema

```json
"schema": {
  "input": {
    "text_field": {
      "name": "text_field",
      "label": "Display Label",
      "type": "string",
      "description": "Help text",
      "required": true,
      "modelId": "consuming-node"
    },
    "image_urls": {
      "name": "image_urls",
      "type": { "kind": "list", "elementType": "string" },
      "required": true,
      "modelId": "node-id"
    }
  }
}
```

## Pre-Output Checklist

Before outputting any workflow, verify:

- All nodes have `type: "run"` or `type: "display"` ONLY (NO `type: "input"`)
- No string interpolation — variable MUST be ENTIRE value
- Every `$node.xxx` has matching `depends` entry
- Every node `id` matches object key
- Input schema has `modelId` for each field
- Output depends on ALL referenced nodes
- Correct LLM type (router vs router/vision)

## Usage

```bash
bash scripts/create-workflow.sh \
  --name "my-workflow" \
  --title "My Workflow Title" \
  --nodes '[...]' \
  --outputs '{...}'
```

## Model Schemas

Every model's input/output schema:
```
https://fal.ai/api/openapi/queue/openapi.json?endpoint_id=[endpoint_id]
```
