# AI Starter

A language/framework-agnostic starter kit for AI-driven development with Claude. Provides building blocks and Claude-guided onboarding for any project.

## What This Provides

- **Agents**: Specialized AI assistants for planning, architecture, code review, and security
- **Rules**: Universal coding standards that apply to all interactions
- **Skills**: On-demand knowledge modules (includes a meta-skill for creating custom skills)
- **Hooks**: Event-driven scripts for workflow automation (file tracking, validation, etc.)
- **Claude-guided Onboarding**: Claude will help customize this starter for your specific project

## Quick Start

### 1. Create Your Repository

Click **"Use this template"** on GitHub, then clone your new repository:

```bash
git clone https://github.com/your-username/your-new-repo.git
cd your-new-repo
```

<details>
<summary>Alternative: Copy to an existing project</summary>

```bash
# Clone this starter
git clone https://github.com/your-org/ai-starter.git

# Copy to your project
cp -r ai-starter/.claude your-project/
cp ai-starter/CLAUDE.md your-project/
cp -r ai-starter/docs your-project/  # optional
```
</details>

### 2. Start Claude

```bash
claude
```

### 3. Let Claude Help You Customize

On first use, Claude will:
1. Read the `CLAUDE.md` template
2. Ask questions about your project (tech stack, patterns, conventions)
3. Help customize the configuration for your needs

Just tell Claude:
```
"Help me set up CLAUDE.md for my project"
```

## What's Included

```
.claude/
├── settings.json           # Claude Code configuration (hooks, env vars)
│
├── agents/
│   ├── planner.md          # Implementation planning
│   ├── architect.md        # System design
│   ├── code-reviewer.md    # Code quality review
│   └── security-reviewer.md # Security analysis
│
├── rules/
│   ├── security.md         # Security guidelines
│   ├── coding-style.md     # Coding principles
│   └── git-workflow.md     # Git conventions
│
├── hooks/
│   └── post-tool-use-tracker.sh  # Example: track file modifications
│
└── skills/
    └── skill-developer/    # Meta-skill for creating custom skills
        ├── SKILL.md
        ├── SKILL_RULES_REFERENCE.md
        ├── TRIGGER_TYPES.md
        ├── HOOK_MECHANISMS.md
        ├── PATTERNS_LIBRARY.md
        └── TROUBLESHOOTING.md

docs/
└── CONCEPTS.md             # Detailed explanation of agents, rules, skills

CLAUDE.md                   # Project configuration (customize this!)
```

## Concepts

### Agents
Specialized AI assistants invoked for specific tasks. Each agent has access to tools and follows a defined workflow.

```
"Use the planner agent to help me plan this feature"
"Run the security-reviewer agent on my code"
```

### Rules
Always-active guidelines that Claude follows in every interaction. They define your project's standards for security, code style, and git workflow.

### Skills
On-demand knowledge modules loaded when relevant. Use the included **skill-developer** skill to create custom skills for your framework:

```
"Use skill-developer to create a React development skill"
"Use skill-developer to create a Django skill"
```

### Hooks
Event-driven scripts that run at specific points in Claude's workflow. The included example tracks file modifications, but you can create hooks for validation, notifications, or custom automation.

## Customization

### Adding Project-Specific Rules

Edit `CLAUDE.md` to add your project's specific guidelines:

```markdown
## Tech Stack
- Frontend: React with TypeScript
- Backend: Node.js with Express
- Database: PostgreSQL with Prisma

## Project Conventions
- Use functional components with hooks
- Follow the repository pattern for data access
- All API responses use standard envelope format
```

### Creating Custom Agents

Add a new `.md` file in `.claude/agents/`:

```markdown
---
name: my-agent
description: What this agent does
tools: Read, Grep, Glob
---

# My Agent

[Agent instructions here]
```

### Creating Custom Skills

Use the skill-developer meta-skill:

```
"I need to create a skill for our API patterns"
```

Claude will guide you through creating a custom skill with proper structure and triggers.

## Learn More

- [Concepts](docs/CONCEPTS.md) - Detailed explanation of agents, rules, skills, and hooks
- [Agents README](.claude/agents/README.md) - How to use and create agents
- [Rules README](.claude/rules/README.md) - How rules work
- [Skills README](.claude/skills/README.md) - How to use and create skills
- [Hooks README](.claude/hooks/README.md) - How to use and create hooks

## Contributing

Contributions welcome! Please read the contributing guidelines before submitting PRs.

## License

MIT
