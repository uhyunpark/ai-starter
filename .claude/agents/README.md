# Agents

Agents are specialized AI assistants that Claude can invoke to help with specific tasks. They have access to tools and are optimized for particular workflows.

## How to Use Agents

Invoke an agent by asking Claude to use it:

```
"Use the planner agent to help me plan this feature"
"Run the code-reviewer agent on my recent changes"
"Use the architect agent to design this system"
```

Or reference the agent in context:

```
"@planner help me break down this task"
```

## Included Agents

### planner.md
**Purpose**: Create comprehensive implementation plans for complex features

**Use when**:
- Starting a new feature implementation
- Planning a refactoring effort
- Breaking down complex tasks into steps
- Identifying dependencies and risks

**Capabilities**:
- Analyzes requirements
- Creates phased implementation plans
- Identifies potential risks
- Suggests testing strategies

---

### architect.md
**Purpose**: Design system architecture and make technical decisions

**Use when**:
- Designing new systems or features
- Evaluating technical trade-offs
- Planning for scalability
- Making architectural decisions

**Capabilities**:
- Creates architecture diagrams
- Documents ADRs (Architecture Decision Records)
- Evaluates patterns and best practices
- Plans for future growth

---

### code-reviewer.md
**Purpose**: Review code for quality, security, and maintainability

**Use when**:
- After writing or modifying code
- Before committing changes
- When refactoring existing code
- To ensure code quality standards

**Capabilities**:
- Identifies security vulnerabilities
- Checks code quality
- Reviews performance
- Suggests improvements

---

### security-reviewer.md
**Purpose**: Detect and remediate security vulnerabilities

**Use when**:
- Writing code that handles user input
- Implementing authentication/authorization
- Working with sensitive data
- Before deploying to production

**Capabilities**:
- OWASP Top 10 analysis
- Secrets detection
- Input validation review
- Dependency security audit

---

## Creating Custom Agents

Create a new agent by adding a markdown file with YAML frontmatter:

```markdown
---
name: my-custom-agent
description: What this agent does and when to use it
tools: Read, Grep, Glob, Bash
model: opus
---

# My Custom Agent

## Your Role
[Describe the agent's purpose and expertise]

## Process
[Step-by-step workflow the agent follows]

## Output Format
[Expected output structure]
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique identifier for the agent |
| `description` | Yes | Brief description of purpose and trigger conditions |
| `tools` | Yes | Comma-separated list of tools the agent can use |
| `model` | No | AI model to use (opus, sonnet, haiku) |

### Available Tools

- `Read` - Read file contents
- `Write` - Create/overwrite files
- `Edit` - Modify existing files
- `Grep` - Search file contents
- `Glob` - Find files by pattern
- `Bash` - Execute shell commands
- `WebFetch` - Fetch web content
- `WebSearch` - Search the web

---

## Best Practices

1. **Be Specific**: Give agents clear, focused responsibilities
2. **Document Process**: Include step-by-step workflows
3. **Provide Examples**: Show expected inputs and outputs
4. **Define Constraints**: Specify what the agent should NOT do
5. **Include Checklists**: Help ensure completeness

## Related

- [Rules](../rules/README.md) - Always-active guidelines
- [Skills](../skills/README.md) - On-demand knowledge and tools
- [Concepts](../../docs/CONCEPTS.md) - Understanding the system
