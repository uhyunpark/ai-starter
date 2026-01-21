# Rules

> **Official Documentation**: [Claude Code Settings](https://code.claude.com/docs/en/settings)

Rules are always-active guidelines that Claude follows throughout every interaction. They define coding standards, security requirements, and workflow practices for your project.

## How Rules Work

Rules in this folder are automatically loaded into Claude's context. They apply to all interactions without needing to be explicitly invoked.

Unlike agents (which are invoked for specific tasks) or skills (which are loaded on-demand), rules are:
- **Always active** - Applied to every response
- **Lightweight** - Should be concise and focused
- **Universal** - Apply across your entire project

## Included Rules

### security.md
**Purpose**: Mandatory security checks and practices

**Enforces**:
- No hardcoded secrets
- Input validation
- SQL injection prevention
- XSS prevention
- Proper error handling

---

### coding-style.md
**Purpose**: Universal coding principles and patterns

**Enforces**:
- Immutability patterns
- File organization (many small files)
- Error handling requirements
- Input validation
- Code quality checklist

---

### git-workflow.md
**Purpose**: Git and version control practices

**Enforces**:
- Conventional commit format
- PR workflow guidelines
- Branch naming conventions
- Feature implementation workflow

---

## Adding Custom Rules

Create a new `.md` file in this folder. Keep rules:

1. **Concise** - Rules should be quick to read
2. **Actionable** - Clear do's and don'ts
3. **Universal** - Apply across your project
4. **Checklistable** - Include verification steps

### Example Rule Structure

```markdown
# Rule Name

## Critical Requirements

- [Do this]
- [Don't do that]

## Examples

```
# Good
example_code()

# Bad
bad_example()
```

## Checklist

- [ ] Check 1
- [ ] Check 2
```

---

## Project-Specific Rules

Add rules specific to your tech stack:

**React Project**:
```markdown
# React Patterns

- Use functional components with hooks
- Memoize expensive computations
- Avoid prop drilling (use context)
```

**Python Project**:
```markdown
# Python Style

- Follow PEP 8
- Use type hints
- Prefer dataclasses for data structures
```

**Go Project**:
```markdown
# Go Conventions

- Handle all errors explicitly
- Use defer for cleanup
- Keep interfaces small
```

---

## Related

- [Agents](../agents/README.md) - Task-specific specialists
- [Skills](../skills/README.md) - On-demand knowledge
- [Concepts](../../docs/CONCEPTS.md) - Understanding the system
