# Coding Style

## Immutability (CRITICAL)

ALWAYS create new objects, NEVER mutate:

```
# WRONG: Mutation
function updateUser(user, name):
    user.name = name  # MUTATION!
    return user

# CORRECT: Immutability
function updateUser(user, name):
    return {
        ...user,  # Copy existing properties
        name: name  # Override with new value
    }
```

## File Organization

MANY SMALL FILES > FEW LARGE FILES:
- High cohesion, low coupling
- 200-400 lines typical, 800 max
- Extract utilities from large components
- Organize by feature/domain, not by type

## Error Handling

ALWAYS handle errors comprehensively:

```
try:
    result = risky_operation()
    return result
catch error:
    log_error("Operation failed:", error)
    raise Error("Detailed user-friendly message")
```

## Input Validation

ALWAYS validate user input at system boundaries:

```
# Define expected schema
schema = {
    email: string, format: email,
    age: integer, min: 0, max: 150
}

# Validate before processing
validated = validate(input, schema)
```

## Code Quality Checklist

Before marking work complete:
- [ ] Code is readable and well-named
- [ ] Functions are small (<50 lines)
- [ ] Files are focused (<800 lines)
- [ ] No deep nesting (>4 levels)
- [ ] Proper error handling
- [ ] No debug statements left in code
- [ ] No hardcoded values
- [ ] Immutable patterns used where appropriate
