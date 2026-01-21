# Hooks

> **Official Documentation**: [Claude Code Hooks](https://code.claude.com/docs/en/hooks) | [Hooks Guide](https://code.claude.com/docs/en/hooks-guide)

Hooks are scripts that run in response to Claude Code events. They enable workflow automation and can inject context, block operations, or run follow-up actions.

## Included Hooks

### post-tool-use-tracker.sh

Tracks files modified by Claude (Edit, MultiEdit, Write tools). Customize this script to:
- Log modifications to a file
- Trigger notifications
- Run validation scripts
- Update external systems

## Configuration

Hooks are registered in `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/post-tool-use-tracker.sh"
          }
        ]
      }
    ]
  }
}
```

## Hook Events

| Event | Timing | Use Case |
|-------|--------|----------|
| `UserPromptSubmit` | Before prompt processing | Suggest skills, add context |
| `PreToolUse` | Before tool executes | Block dangerous operations |
| `PostToolUse` | After tool executes | Track changes, validate results |
| `Stop` | After response complete | Cleanup, notifications |

## Creating Custom Hooks

1. Create a script in `.claude/hooks/`
2. Make it executable: `chmod +x your-hook.sh`
3. Register it in `.claude/settings.json`

### Hook Script Interface

**Input:** JSON via stdin containing:
- `tool_name` - The tool that was called
- `tool_input` - Parameters passed to the tool
- `tool_output` - Result from the tool (PostToolUse only)

**Output:**
- stdout: Message shown to Claude (optional)
- stderr: Error message (for blocking in PreToolUse)

**Exit codes (PreToolUse):**
- `0` - Allow operation
- `2` - Block operation, send stderr to Claude
- Other - Block silently

## Learn More

- [Concepts: Hooks](../../docs/CONCEPTS.md#hooks)
- [Hook Mechanisms](../skills/skill-developer/HOOK_MECHANISMS.md)
