#!/bin/bash

# fal.ai Workflow Creation Script
# Usage: ./create-workflow.sh --name NAME --title TITLE --description DESC --nodes JSON --outputs JSON
# Returns: Workflow JSON definition

set -e

# Default values
NAME=""
TITLE=""
DESCRIPTION=""
NODES=""
OUTPUTS=""

# Escape string for safe JSON embedding
json_escape() {
  printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\t/\\t/g' | tr -d '\n\r'
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --name)
            NAME="$2"
            shift 2
            ;;
        --title)
            TITLE="$2"
            shift 2
            ;;
        --description)
            DESCRIPTION="$2"
            shift 2
            ;;
        --nodes)
            NODES="$2"
            shift 2
            ;;
        --outputs)
            OUTPUTS="$2"
            shift 2
            ;;
        --help|-h)
            echo "fal.ai Workflow Creation Script" >&2
            echo "" >&2
            echo "Usage:" >&2
            echo "  ./create-workflow.sh --name NAME --nodes JSON --outputs JSON [options]" >&2
            echo "" >&2
            echo "Options:" >&2
            echo "  --name          Workflow name (required)" >&2
            echo "  --title         Display title (defaults to name)" >&2
            echo "  --description   Workflow description" >&2
            echo "  --nodes         Nodes JSON array (required)" >&2
            echo "  --outputs       Outputs JSON object (required)" >&2
            echo "" >&2
            echo "Example:" >&2
            echo "  ./create-workflow.sh --name my-pipeline \\" >&2
            echo "    --title \"My Pipeline\" \\" >&2
            echo "    --description \"Generate and upscale\" \\" >&2
            echo "    --nodes '[{\"nodeId\":\"gen\",\"modelId\":\"fal-ai/flux/dev\",\"input\":{\"prompt\":\"\$input.prompt\"}}]' \\" >&2
            echo "    --outputs '{\"image\":\"\$gen.images[0].url\"}'" >&2
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
    esac
done

# Validate required inputs
if [ -z "$NAME" ]; then
    echo "Error: --name is required" >&2
    exit 1
fi

if [ -z "$TITLE" ]; then
    TITLE="$NAME"
fi

if [ -z "$NODES" ]; then
    echo "Error: --nodes is required (JSON array)" >&2
    exit 1
fi

if [ -z "$OUTPUTS" ]; then
    echo "Error: --outputs is required (JSON object)" >&2
    exit 1
fi

# Create temp directory
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo "Creating workflow: $TITLE..." >&2

# Parse nodes array and build workflow structure
# This is a simplified version - the MCP tool handles complex validation
WORKFLOW_FILE="$TEMP_DIR/workflow.json"

# Escape user-provided strings for JSON
ESC_NAME=$(json_escape "$NAME")
ESC_TITLE=$(json_escape "$TITLE")
ESC_DESCRIPTION=$(json_escape "$DESCRIPTION")

# Build the workflow JSON (printf avoids heredoc expansion and sed portability issues)
printf '{\n  "_type": "ComfyApp",\n  "version": "0.1.0",\n  "name": "%s",\n  "title": "%s",\n  "description": "%s",\n  "nodes": {},\n  "outputs": %s\n}\n' \
    "$ESC_NAME" "$ESC_TITLE" "$ESC_DESCRIPTION" "$OUTPUTS" > "$WORKFLOW_FILE"

# Process nodes and add to workflow
# Note: This is a basic implementation. For full validation, use the MCP tool.
echo "Processing nodes..." >&2

# Use Python/jq if available for proper JSON manipulation
if command -v python3 &> /dev/null; then
    FAL_WORKFLOW_FILE="$WORKFLOW_FILE" FAL_NODES="$NODES" python3 << 'PYTHON_EOF'
import json
import os

workflow_file = os.environ["FAL_WORKFLOW_FILE"]
nodes_json = os.environ["FAL_NODES"]

# Read workflow
with open(workflow_file, "r") as f:
    workflow = json.load(f)

# Parse nodes
nodes = json.loads(nodes_json)

# Build nodes object
for node in nodes:
    node_id = node.get("nodeId", "")
    model_id = node.get("modelId", "")
    node_input = node.get("input", {})
    depends_on = node.get("dependsOn", [])

    # Detect dependencies from input references
    for key, value in node_input.items():
        if isinstance(value, str) and value.startswith("$") and not value.startswith("$input"):
            ref_node = value.split(".")[0][1:]  # Remove $ and get node name
            if ref_node not in depends_on:
                depends_on.append(ref_node)

    workflow["nodes"][node_id] = {
        "app": model_id,
        "input": node_input
    }

    if depends_on:
        workflow["nodes"][node_id]["dependsOn"] = depends_on

# Write result
print(json.dumps(workflow, indent=2))
PYTHON_EOF
else
    # Fallback: output the basic structure
    echo "Warning: Python not available, outputting basic structure" >&2
    cat "$WORKFLOW_FILE"
fi

echo "" >&2
echo "Workflow created successfully!" >&2
