# Skills

Skills are on-demand knowledge modules that provide Claude with specialized information about specific topics, technologies, or workflows. They are loaded when relevant to the current task.

## How Skills Work

Skills can be activated in two ways:

1. **Manual invocation**: Ask Claude to use a skill
   ```
   "Use the skill-developer skill to help me create a new skill"
   ```

2. **Auto-activation** (with hooks): Skills can automatically activate based on:
   - Keywords in your prompt
   - Intent patterns (what you're trying to do)
   - File paths being edited
   - Content patterns in files

## Included Skills

### skill-developer/
**Purpose**: Meta-skill for creating new skills

**Use when**:
- Creating a new skill for your project
- Setting up skill auto-activation
- Debugging skill trigger issues
- Understanding skill best practices

**Contains**:
- `SKILL.md` - Main skill guide
- `SKILL_RULES_REFERENCE.md` - Configuration schema
- `TRIGGER_TYPES.md` - All trigger options
- `HOOK_MECHANISMS.md` - How hooks work
- `PATTERNS_LIBRARY.md` - Ready-to-use patterns
- `TROUBLESHOOTING.md` - Debug guide

---

## Creating Custom Skills

### 1. Simple Skill (Single File)

For straightforward skills, create a single markdown file:

```markdown
---
name: my-skill
description: Keywords that trigger this skill. Be explicit about when to use it.
---

# My Skill

## Purpose
What this skill helps with

## Key Information
The actual guidance, examples, patterns
```

### 2. Complex Skill (Folder with Reference Files)

For comprehensive skills, use the progressive disclosure pattern:

```
.claude/skills/my-skill/
├── SKILL.md              # Main file (< 500 lines)
├── REFERENCE_1.md        # Detailed reference
├── REFERENCE_2.md        # Another reference
└── EXAMPLES.md           # Code examples
```

### Best Practices

- **500-line rule**: Keep SKILL.md under 500 lines
- **Progressive disclosure**: Use reference files for details
- **Rich descriptions**: Include all trigger keywords
- **Real examples**: Show actual code patterns
- **Clear structure**: Use headings, lists, code blocks

---

## Skill Types

### Domain Skills
Provide knowledge about a specific area:
- Framework guidelines (React, Django, etc.)
- Project-specific patterns
- API documentation
- Architecture guides

### Guardrail Skills
Enforce critical requirements:
- Database verification
- Security checks
- Compliance requirements

---

## Creating Framework-Specific Skills

Use the **skill-developer** skill to create skills for your tech stack:

### Example: React Skill

```
"Use skill-developer to create a React development skill"
```

This will help you create:
- Component patterns
- Hook best practices
- State management guidelines
- Testing approaches

### Example: Django Skill

```
"Use skill-developer to create a Django development skill"
```

This will help you create:
- Model patterns
- View best practices
- URL configuration
- Testing approaches

---

## Auto-Activation Setup

To enable automatic skill activation, you need:

1. **skill-rules.json** - Define triggers
2. **Hook scripts** - Process triggers

See `skill-developer/SKILL.md` for complete setup instructions.

### Quick Example

```json
{
  "version": "1.0",
  "skills": {
    "react-guidelines": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "promptTriggers": {
        "keywords": ["react", "component", "hooks"],
        "intentPatterns": ["(create|add).*?component"]
      }
    }
  }
}
```

---

## Related

- [Agents](../agents/README.md) - Task-specific specialists
- [Rules](../rules/README.md) - Always-active guidelines
- [Concepts](../../docs/CONCEPTS.md) - Understanding the system
