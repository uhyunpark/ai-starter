# Project Configuration

<!--
  FIRST TIME SETUP
  ================
  When you first start Claude in this project, ask Claude to help you customize
  this file. Claude will ask questions about your tech stack, patterns, and
  preferences, then help fill in the sections below.

  Just say: "Help me set up CLAUDE.md for my project"
-->

## Project Overview

<!-- [FILL IN] Brief description of what this project does -->
**Description**: [Describe your project in 1-2 sentences]

<!-- [FILL IN] Your technology choices -->
**Tech Stack**:
- Frontend: [e.g., React, Vue, Angular, vanilla JS]
- Backend: [e.g., Node.js, Python, Go, Ruby]
- Database: [e.g., PostgreSQL, MongoDB, MySQL]
- Other: [e.g., Redis, Elasticsearch, message queues]

---

## Critical Rules

### Security (ALWAYS ENFORCE)

- NEVER commit secrets (API keys, passwords, tokens)
- ALWAYS validate user input at system boundaries
- ALWAYS use parameterized queries for database access
- ALWAYS sanitize output to prevent XSS
- STOP and alert if security vulnerability detected

### Code Quality

- Keep functions small (< 50 lines)
- Keep files focused (< 800 lines)
- Prefer immutability over mutation
- Handle all errors explicitly
- No debug statements in committed code

### Git Workflow

- Use conventional commits: `type: description`
- Types: feat, fix, refactor, docs, test, chore
- Create meaningful commit messages explaining "why"

---

## Project Conventions

<!-- [FILL IN] Your project-specific patterns and conventions -->

### File Organization
<!-- How is your code organized? By feature? By type? -->
```
[Describe your folder structure]
```

### Naming Conventions
<!-- How do you name files, functions, variables? -->
- Files: [e.g., kebab-case, PascalCase]
- Functions: [e.g., camelCase, snake_case]
- Components: [e.g., PascalCase]

### Code Patterns
<!-- What patterns does your project follow? -->
- [e.g., Repository pattern for data access]
- [e.g., Factory pattern for object creation]
- [e.g., Observer pattern for events]

---

## Available Agents

Use these agents for specific tasks:

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| `planner` | Create implementation plans | Starting new features, complex refactoring |
| `architect` | Design system architecture | Technical decisions, scalability planning |
| `code-reviewer` | Review code quality | After writing code, before commits |
| `security-reviewer` | Find security issues | Code handling user input, auth, sensitive data |

**Example**:
```
"Use the planner agent to break down this feature"
"Run code-reviewer on my recent changes"
```

---

## Project-Specific Instructions

<!-- [FILL IN] Add any project-specific instructions for Claude -->

### Build & Test Commands
```bash
# [FILL IN] Your build command
# Examples: npm run build | make | cargo build | ./gradlew build | go build

# [FILL IN] Your test command
# Examples: npm test | pytest | go test ./... | cargo test | ./gradlew test

# [FILL IN] Your lint command
# Examples: npm run lint | ruff check | golangci-lint run | cargo clippy
```

### Important Files
<!-- List important files Claude should know about -->
- `[path/to/config]` - Configuration file
- `[path/to/types]` - Type definitions
- `[path/to/schema]` - Database schema

### Things to Avoid
<!-- What should Claude NOT do in this project? -->
- [e.g., Don't modify the legacy/ folder]
- [e.g., Don't use library X, use library Y instead]
- [e.g., Don't add new dependencies without discussion]

---

## Onboarding Checklist

When setting up for a new developer (or Claude), ensure:

- [ ] Environment variables configured
- [ ] Dependencies installed
- [ ] Database migrations run
- [ ] Local development server starts
- [ ] Tests pass

---

<!--
  CUSTOMIZATION HELP
  ==================
  Need help filling this in? Just ask Claude:

  "What questions should I answer to complete CLAUDE.md?"
  "Help me document my project's conventions"
  "What patterns does my codebase use?"

  Claude will explore your codebase and help document it.
-->
