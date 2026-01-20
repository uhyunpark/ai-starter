# Claude Code Concepts

This document explains the core concepts of Claude Code's extensibility system: Agents, Rules, Skills, and Hooks.

## Table of Contents

- [Overview](#overview)
- [Agents](#agents)
- [Rules](#rules)
- [Skills](#skills)
- [Hooks](#hooks)
- [How They Work Together](#how-they-work-together)
- [Best Practices](#best-practices)

---

## Overview

Claude Code can be customized and extended through four main mechanisms:

| Concept | Location | Activation | Purpose |
|---------|----------|------------|---------|
| **Agents** | `.claude/agents/` | On-demand (invoked) | Specialized task assistants |
| **Rules** | `.claude/rules/` | Always active | Universal guidelines |
| **Skills** | `.claude/skills/` | On-demand or auto | Domain knowledge |
| **Hooks** | `.claude/hooks/` | Event-triggered | Workflow automation |

---

## Agents

### What Are Agents?

Agents are specialized AI assistants that Claude can invoke to help with specific tasks. Each agent has:
- A defined role and expertise
- Access to specific tools
- A workflow or process to follow
- Expected outputs

### When to Use Agents

Use agents for:
- **Complex, multi-step tasks** that benefit from a defined process
- **Specialized expertise** (security, architecture, planning)
- **Consistent workflows** that should be followed the same way each time

### Agent Structure

Agents are markdown files with YAML frontmatter:

```markdown
---
name: my-agent
description: When and why to use this agent
tools: Read, Grep, Glob, Bash
model: opus
---

# Agent Name

## Your Role
[What this agent does]

## Process
[Step-by-step workflow]

## Output Format
[Expected output structure]
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique identifier |
| `description` | Yes | Purpose and trigger conditions |
| `tools` | Yes | Available tools (Read, Write, Edit, Grep, Glob, Bash, etc.) |
| `model` | No | AI model (opus, sonnet, haiku) |

### How to Invoke Agents

```
"Use the planner agent to help me plan this feature"
"@architect design a system for..."
"Run code-reviewer on my changes"
```

---

## Rules

### What Are Rules?

Rules are always-active guidelines that Claude follows in every interaction. They define:
- Coding standards
- Security requirements
- Workflow practices
- Project conventions

### When to Use Rules

Use rules for:
- **Universal requirements** that apply to all code
- **Security policies** that must always be enforced
- **Coding standards** that define your style
- **Git workflow** conventions

### Rule Structure

Rules are simple markdown files:

```markdown
# Rule Name

## Critical Requirements
- Do this
- Don't do that

## Examples
[Code examples]

## Checklist
- [ ] Verification step 1
- [ ] Verification step 2
```

### Key Characteristics

- **Always loaded** - No need to invoke
- **Lightweight** - Should be concise
- **Non-blocking** - Guide behavior, don't prevent action

---

## Skills

### What Are Skills?

Skills are on-demand knowledge modules that provide Claude with specialized information about specific topics, technologies, or workflows.

### When to Use Skills

Use skills for:
- **Framework-specific guidance** (React, Django, Rails)
- **Project-specific patterns** (your API conventions, data models)
- **Complex domain knowledge** (authentication flows, payment processing)
- **Reference documentation** that's too large for rules

### Skill Types

#### 1. Domain Skills
Provide knowledge about a specific area:
- Framework guidelines
- API documentation
- Architecture guides

#### 2. Guardrail Skills
Enforce critical requirements:
- Database verification before queries
- Security checks before deployment
- Compliance validation

### Skill Structure

Simple skill (single file):
```markdown
---
name: my-skill
description: Keywords that trigger this skill
---

# Skill Name

## Purpose
What this helps with

## Key Information
The actual guidance
```

Complex skill (folder with references):
```
.claude/skills/my-skill/
├── SKILL.md              # Main file (< 500 lines)
├── REFERENCE_1.md        # Detailed reference
└── EXAMPLES.md           # Code examples
```

### The 500-Line Rule

Keep main skill files under 500 lines. Use reference files for additional detail. This ensures:
- Skills load quickly
- Context isn't overwhelmed
- Information is organized

### How to Invoke Skills

```
"Use the frontend-guidelines skill"
"Load the API patterns skill before we start"
```

Or with auto-activation (via hooks), skills load automatically based on:
- Keywords in your prompt
- File paths being edited
- Content patterns in files

---

## Hooks

### What Are Hooks?

Hooks are scripts that run in response to Claude Code events. They enable automation and can:
- Inject context before Claude processes a prompt
- Block or modify tool execution
- Run actions after Claude responds

### Hook Events

| Event | Timing | Use Case |
|-------|--------|----------|
| `UserPromptSubmit` | Before prompt processing | Suggest relevant skills |
| `PreToolUse` | Before tool executes | Block dangerous operations |
| `PostToolUse` | After tool executes | Validate results |
| `Stop` | After response complete | Cleanup, reminders |

### How Hooks Work

1. **Configuration**: Register hooks in `.claude/settings.json`
2. **Trigger**: Event occurs (user submits prompt, tool is called, etc.)
3. **Execution**: Hook script runs with event data
4. **Result**: Output affects Claude's behavior

### Exit Codes (PreToolUse)

| Exit Code | Effect |
|-----------|--------|
| 0 | Allow - tool executes normally |
| 2 | Block - stderr sent to Claude |
| Other | Block - no message to Claude |

### Example: Skill Auto-Activation

A UserPromptSubmit hook can:
1. Read the user's prompt
2. Match against skill triggers
3. Output skill suggestions to stdout
4. Claude sees suggestions as context

---

## How They Work Together

### Typical Flow

1. **User submits prompt**
   - Hooks (UserPromptSubmit) run, may suggest skills
   - Rules are always in context

2. **Claude processes request**
   - Uses relevant agents if invoked
   - Follows active rules
   - Consults loaded skills

3. **Claude uses tools**
   - Hooks (PreToolUse) may block or modify
   - Rules guide code quality

4. **Response complete**
   - Hooks (Stop) may run follow-up actions

### Example: Feature Implementation

```
User: "Add user authentication"

1. UserPromptSubmit hook suggests: security-reviewer, auth-patterns skill
2. Rules enforce: security guidelines, coding style
3. User invokes: "Use planner agent"
4. Agent creates plan, references skills for auth best practices
5. User implements
6. PreToolUse hook: may require security skill check
7. User invokes: "Run code-reviewer"
8. Agent reviews, ensures rules followed
```

---

## Best Practices

### Agents
- Give clear, focused responsibilities
- Include step-by-step workflows
- Define expected outputs
- Specify what NOT to do

### Rules
- Keep concise and actionable
- Focus on universal requirements
- Include examples
- Add verification checklists

### Skills
- Follow 500-line rule
- Use progressive disclosure
- Include real code examples
- Write detailed descriptions with trigger keywords

### Hooks
- Keep scripts fast (< 200ms)
- Fail open (don't break workflow on errors)
- Log for debugging
- Use session tracking to avoid repetition

---

## Creating Custom Extensions

### Quick Reference

| Want to... | Create a... |
|------------|-------------|
| Add a specialized assistant | Agent |
| Enforce a universal standard | Rule |
| Provide domain knowledge | Skill |
| Automate a workflow | Hook |

### Getting Started

1. **Agents**: Copy an existing agent, modify for your use case
2. **Rules**: Add a markdown file to `.claude/rules/`
3. **Skills**: Use the skill-developer skill to create new skills
4. **Hooks**: See Hook documentation in skill-developer

---

## Learn More

- [Agents README](../.claude/agents/README.md)
- [Rules README](../.claude/rules/README.md)
- [Skills README](../.claude/skills/README.md)
- [Skill Developer Guide](../.claude/skills/skill-developer/SKILL.md)
