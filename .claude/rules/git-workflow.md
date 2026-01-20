# Git Workflow

## Commit Message Format

```
<type>: <description>

<optional body>
```

Types: feat, fix, refactor, docs, test, chore, perf, ci

## Pull Request Workflow

When creating PRs:
1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Draft comprehensive PR summary
4. Include test plan with TODOs
5. Push with `-u` flag if new branch

## Feature Implementation Workflow

1. **Plan First**
   - Use **planner** agent to create implementation plan
   - Identify dependencies and risks
   - Break down into phases

2. **Code Review**
   - Use **code-reviewer** agent immediately after writing code
   - Address CRITICAL and HIGH issues
   - Fix MEDIUM issues when possible

3. **Commit & Push**
   - Detailed commit messages
   - Follow conventional commits format

## Branch Naming

Use descriptive branch names:
- `feature/add-user-authentication`
- `fix/login-redirect-issue`
- `refactor/cleanup-api-routes`
- `docs/update-readme`

## Before Merging

- [ ] All tests pass
- [ ] Code reviewed
- [ ] No merge conflicts
- [ ] PR description updated
- [ ] Documentation updated (if needed)
