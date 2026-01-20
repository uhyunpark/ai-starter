# Troubleshooting - Skill Activation Issues

Complete debugging guide for skill activation problems.

## Table of Contents

- [Skill Not Triggering](#skill-not-triggering)
  - [UserPromptSubmit Not Suggesting](#userpromptsubmit-not-suggesting)
  - [PreToolUse Not Blocking](#pretooluse-not-blocking)
- [False Positives](#false-positives)
- [Hook Not Executing](#hook-not-executing)
- [Performance Issues](#performance-issues)

---

## Skill Not Triggering

### UserPromptSubmit Not Suggesting

**Symptoms:** Ask a question, but no skill suggestion appears in output.

**Common Causes:**

#### 1. Keywords Don't Match

**Check:**
- Look at `promptTriggers.keywords` in skill-rules.json
- Are the keywords actually in your prompt?
- Remember: case-insensitive substring matching

**Example:**
```json
"keywords": ["layout", "grid"]
```
- "how does the layout work?" -> Matches "layout"
- "how does the grid system work?" -> Matches "grid"
- "how does it work?" -> No match

**Fix:** Add more keyword variations to skill-rules.json

#### 2. Intent Patterns Too Specific

**Check:**
- Look at `promptTriggers.intentPatterns`
- Test regex at https://regex101.com/
- May need broader patterns

**Example:**
```json
"intentPatterns": [
  "(create|add).*?(database.*?table)"  // Too specific
]
```
- "create a database table" -> Matches
- "add new table" -> Doesn't match (missing "database")

**Fix:** Broaden the pattern:
```json
"intentPatterns": [
  "(create|add).*?(table|database)"  // Better
]
```

#### 3. Typo in Skill Name

**Check:**
- Skill name in SKILL.md frontmatter
- Skill name in skill-rules.json
- Must match exactly

#### 4. JSON Syntax Error

**Check:**
```bash
cat .claude/skills/skill-rules.json | jq .
```

If invalid JSON, jq will show the error.

**Common errors:**
- Trailing commas
- Missing quotes
- Single quotes instead of double
- Unescaped characters in strings

**Fix:** Correct JSON syntax, validate with jq

---

### PreToolUse Not Blocking

**Symptoms:** Edit a file that should trigger a guardrail, but no block occurs.

**Common Causes:**

#### 1. File Path Doesn't Match Patterns

**Check:**
- File path being edited
- `fileTriggers.pathPatterns` in skill-rules.json
- Glob pattern syntax

**Example:**
```json
"pathPatterns": [
  "frontend/src/**/*.tsx"
]
```
- Editing: `frontend/src/components/Dashboard.tsx` -> Matches
- Editing: `backend/src/app.ts` -> Doesn't match

**Fix:** Adjust glob patterns or add the missing path

#### 2. Excluded by pathExclusions

**Check:**
- Are you editing a test file?
- Look at `fileTriggers.pathExclusions`

**Example:**
```json
"pathExclusions": [
  "**/*.test.ts",
  "**/*.spec.ts"
]
```
- Editing: `services/user.test.ts` -> Excluded
- Editing: `services/user.ts` -> Not excluded

**Fix:** If test exclusion too broad, narrow it or remove

#### 3. Content Pattern Not Found

**Check:**
- Does the file actually contain the pattern?
- Look at `fileTriggers.contentPatterns`
- Is the regex correct?

**Example:**
```json
"contentPatterns": [
  "import.*[Pp]risma"
]
```
- File has: `import { PrismaService } from './prisma'` -> Matches
- File has: `import { Database } from './db'` -> Doesn't match

**Fix:** Adjust content patterns or add missing imports

#### 4. Session Already Used Skill

**Check session state:**
```bash
ls .claude/hooks/state/
cat .claude/hooks/state/skills-used-{session-id}.json
```

If the skill is in `skills_used`, it won't block again in this session.

**Fix:** Delete the state file to reset:
```bash
rm .claude/hooks/state/skills-used-{session-id}.json
```

#### 5. File Marker Present

**Check file for skip marker:**
```bash
grep "@skip-validation" path/to/file.ts
```

If found, the file is permanently skipped.

**Fix:** Remove the marker if verification is needed again

#### 6. Environment Variable Override

**Check:**
```bash
echo $SKIP_DB_VERIFICATION
echo $SKIP_SKILL_GUARDRAILS
```

If set, the skill is disabled.

**Fix:** Unset the environment variable:
```bash
unset SKIP_DB_VERIFICATION
```

---

## False Positives

**Symptoms:** Skill triggers when it shouldn't.

**Common Causes & Solutions:**

### 1. Keywords Too Generic

**Problem:**
```json
"keywords": ["user", "system", "create"]  // Too broad
```
- Triggers on: "user manual", "file system", "create directory"

**Solution:** Make keywords more specific
```json
"keywords": [
  "user authentication",
  "user tracking",
  "create feature"
]
```

### 2. Intent Patterns Too Broad

**Problem:**
```json
"intentPatterns": [
  "(create)"  // Matches everything with "create"
]
```
- Triggers on: "create file", "create folder", "create account"

**Solution:** Add context to patterns
```json
"intentPatterns": [
  "(create|add).*?(database|table|feature)"  // More specific
]
```

### 3. File Paths Too Generic

**Problem:**
```json
"pathPatterns": [
  "src/**"  // Matches everything in src/
]
```

**Solution:** Use narrower patterns
```json
"pathPatterns": [
  "src/services/**/*.ts",  // Only service files
  "src/controllers/**/*.ts"
]
```

### 4. Adjust Enforcement Level

**Last resort:** If false positives are frequent:

```json
{
  "enforcement": "suggest"  // Instead of "block"
}
```

This makes it advisory instead of blocking.

---

## Hook Not Executing

**Symptoms:** Hook doesn't run at all - no suggestion, no block.

**Common Causes:**

### 1. Hook Not Registered

**Check `.claude/settings.json`:**
```bash
cat .claude/settings.json | jq '.hooks'
```

Expected: Hook entries present

**Fix:** Add missing hook registration

### 2. Bash Wrapper Not Executable

**Check:**
```bash
ls -l .claude/hooks/*.sh
```

Expected: `-rwxr-xr-x` (executable)

**Fix:**
```bash
chmod +x .claude/hooks/*.sh
```

### 3. Incorrect Shebang

**Check:**
```bash
head -1 .claude/hooks/skill-activation-prompt.sh
```

Expected: `#!/bin/bash`

**Fix:** Add correct shebang to first line

### 4. Dependencies Not Available

**Check:**
```bash
which node
which npx
```

Expected: Paths to executables

**Fix:** Install Node.js and required dependencies

---

## Performance Issues

**Symptoms:** Hooks are slow, noticeable delay before prompt/edit.

**Common Causes:**

### 1. Too Many Patterns

**Check:**
- Count patterns in skill-rules.json
- Each pattern = regex compilation + matching

**Solution:** Reduce patterns
- Combine similar patterns
- Remove redundant patterns
- Use more specific patterns (faster matching)

### 2. Complex Regex

**Problem:**
```regex
(create|add|modify|update|implement|build).*?(feature|endpoint|route|service|controller|component|UI|page)
```
- Long alternations = slow

**Solution:** Simplify
```regex
(create|add).*?(feature|endpoint)  // Fewer alternatives
```

### 3. Too Many Files Checked

**Problem:**
```json
"pathPatterns": [
  "**/*.ts"  // Checks ALL TypeScript files
]
```

**Solution:** Be more specific
```json
"pathPatterns": [
  "src/services/**/*.ts",  // Only specific directory
  "src/controllers/**/*.ts"
]
```

### 4. Large Files

Content pattern matching reads entire file - slow for large files.

**Solution:**
- Only use content patterns when necessary
- Consider file size limits

### Measure Performance

```bash
# Time hook execution
time echo '{"prompt":"test"}' | your-hook-script
```

**Target metrics:**
- UserPromptSubmit: < 100ms
- PreToolUse: < 200ms

---

**Related Files:**
- [SKILL.md](SKILL.md) - Main skill guide
- [HOOK_MECHANISMS.md](HOOK_MECHANISMS.md) - How hooks work
- [SKILL_RULES_REFERENCE.md](SKILL_RULES_REFERENCE.md) - Configuration reference
