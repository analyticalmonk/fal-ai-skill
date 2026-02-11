# Platform API Reference

Base URL: `https://api.fal.ai/v1`

## API Endpoints

| Operation | Endpoint | Method |
|-----------|----------|--------|
| Model Search | `GET /models` | GET |
| Pricing | `GET /models/pricing` | GET |
| Usage | `GET /models/usage` | GET |
| List Requests | `GET /models/requests/by-endpoint` | GET |
| Delete Payloads | `DELETE /models/requests/{id}/payloads` | DELETE |

## Setup & Configuration

```bash
# Interactive setup
bash scripts/setup.sh --add-fal-key

# Set key directly
bash scripts/setup.sh --add-fal-key "your_key_here"

# Show current config
bash scripts/setup.sh --show-config
```

Get your API key at: https://fal.ai/dashboard/keys

## Model Pricing

```bash
# Single model pricing
bash scripts/pricing.sh --model "fal-ai/flux/dev"

# Multiple models
bash scripts/pricing.sh --model "fal-ai/flux/dev,fal-ai/kling-video/v2.1/pro"

# All pricing for a category
bash scripts/pricing.sh --category "text-to-image"
```

## Usage Tracking

```bash
# Current period usage
bash scripts/usage.sh

# Filter by model
bash scripts/usage.sh --model "fal-ai/flux/dev"

# Date range
bash scripts/usage.sh --start "2024-01-01" --end "2024-01-31"

# Specific timeframe
bash scripts/usage.sh --timeframe "day"
```

Timeframes: `minute`, `hour`, `day`, `week`, `month`

## Cost Estimation

```bash
# Estimate by API calls
bash scripts/estimate-cost.sh --model "fal-ai/flux/dev" --calls 100

# Estimate by units
bash scripts/estimate-cost.sh --model "fal-ai/kling-video/v2.1/pro" --units 60
```

## Request Management

```bash
# List recent requests
bash scripts/requests.sh --model "fal-ai/flux/dev" --limit 10

# Delete request payloads (cleanup)
bash scripts/requests.sh --delete "request_id_here"
```

## Common Flags (All Scripts)

```
--add-fal-key [KEY]   Add/update FAL_KEY in .env
--help, -h            Show help
--json                Output raw JSON
```
