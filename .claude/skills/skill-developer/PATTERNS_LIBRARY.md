# Common Patterns Library

Ready-to-use regex and glob patterns for skill triggers. Copy and customize for your skills.

---

## Intent Patterns (Regex)

### Feature/Endpoint Creation
```regex
(add|create|implement|build).*?(feature|endpoint|route|service|controller)
```

### Component Creation
```regex
(create|add|make|build).*?(component|UI|page|modal|dialog|form)
```

### Database Work
```regex
(add|create|modify|update).*?(user|table|column|field|schema|migration)
(database|prisma).*?(change|update|query)
```

### Error Handling
```regex
(fix|handle|catch|debug).*?(error|exception|bug)
(add|implement).*?(try|catch|error.*?handling)
```

### Explanation Requests
```regex
(how does|how do|explain|what is|describe|tell me about).*?
```

### Workflow Operations
```regex
(create|add|modify|update).*?(workflow|step|branch|condition)
(debug|troubleshoot|fix).*?workflow
```

### Testing
```regex
(write|create|add).*?(test|spec|unit.*?test)
```

---

## File Path Patterns (Glob)

### Frontend
```glob
frontend/src/**/*.tsx        # All React components
frontend/src/**/*.ts         # All TypeScript files
frontend/src/components/**   # Only components directory
src/components/**/*.vue      # Vue components
src/pages/**/*.jsx           # React pages
```

### Backend Services
```glob
src/services/**/*.ts         # Service files
src/controllers/**/*.ts      # Controller files
api/src/**/*.ts              # API routes
backend/src/**/*.py          # Python backend
```

### Database
```glob
**/schema.prisma             # Prisma schema (anywhere)
**/migrations/**/*.sql       # Migration files
database/src/**/*.ts         # Database scripts
**/models/**/*.py            # Python models
```

### Configuration
```glob
**/*.config.js               # JS config files
**/*.config.ts               # TS config files
**/settings.py               # Python settings
**/application.yml           # Spring config
```

### Test Exclusions
```glob
**/*.test.ts                 # TypeScript tests
**/*.test.tsx                # React component tests
**/*.spec.ts                 # Spec files
**/__tests__/**              # Test directories
**/test_*.py                 # Python tests
```

---

## Content Patterns (Regex)

### Prisma/Database
```regex
import.*[Pp]risma                # Prisma imports
PrismaService                    # PrismaService usage
prisma\.                         # prisma.something
\.findMany\(                     # Prisma query methods
\.create\(
\.update\(
\.delete\(
```

### Controllers/Routes
```regex
export class.*Controller         # Controller classes
router\.                         # Express router
app\.(get|post|put|delete|patch) # Express app routes
@Controller                      # NestJS decorators
@Get|@Post|@Put|@Delete          # Route decorators
```

### Error Handling
```regex
try\s*\{                        # Try blocks
catch\s*\(                      # Catch blocks
throw new                        # Throw statements
\.catch\(                       # Promise catch
```

### React/Components
```regex
export.*React\.FC               # React functional components
export default function.*       # Default function exports
useState|useEffect              # React hooks
import.*from ['"]react['"]      # React imports
```

### Python/Django
```regex
from django                     # Django imports
class.*View                     # Django views
def get\(|def post\(            # View methods
@login_required                 # Auth decorators
```

### Authentication
```regex
jwt|JWT                         # JWT usage
bcrypt|argon2                   # Password hashing
session|cookie                  # Session handling
authenticate|authorize          # Auth functions
```

---

## Usage Example

```json
{
  "my-skill": {
    "promptTriggers": {
      "intentPatterns": [
        "(create|add|build).*?(component|UI|page)"
      ]
    },
    "fileTriggers": {
      "pathPatterns": [
        "frontend/src/**/*.tsx"
      ],
      "contentPatterns": [
        "export.*React\\.FC",
        "useState|useEffect"
      ]
    }
  }
}
```

---

**Related Files:**
- [SKILL.md](SKILL.md) - Main skill guide
- [TRIGGER_TYPES.md](TRIGGER_TYPES.md) - Detailed trigger documentation
- [SKILL_RULES_REFERENCE.md](SKILL_RULES_REFERENCE.md) - Complete schema
