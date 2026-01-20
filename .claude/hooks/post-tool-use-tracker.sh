#!/bin/bash
# Post-tool-use hook: Tracks files modified by Claude
#
# This hook runs after Edit, MultiEdit, or Write tools are used.
# It logs modified files for visibility into what Claude changed.
#
# Input: JSON via stdin with tool_name, tool_input, tool_output
# Output: Optional message to stdout (shown to Claude)
# Exit code: 0 (success)

# Read the tool input from stdin
input=$(cat)

# Extract the file path from the tool input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.filePath // empty' 2>/dev/null)

if [ -n "$file_path" ]; then
    # Log the modification (customize this for your needs)
    # Example: append to a log file
    # echo "$(date -Iseconds) Modified: $file_path" >> "$CLAUDE_PROJECT_DIR/.claude/modified-files.log"

    # Or just output for visibility (optional)
    : # No-op by default - customize as needed
fi

exit 0
