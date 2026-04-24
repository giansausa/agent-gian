#!/bin/bash
# tsc-check-before-commit.sh — PreToolUse(Bash) hook
# Runs tsc --noEmit on packages with staged TS/TSX changes before allowing git commit.
# Blocks commit (exit 2) if tsc errors are found.
# Silent pass-through for non-commit commands, non-TS projects, or clean type checks.
#
# Install: registered in ~/.claude/settings.json under hooks.PreToolUse (matcher: "Bash").

INPUT=$(cat)

# Extract the Bash command
CMD=$(echo "$INPUT" | node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>{try{process.stdout.write(JSON.parse(d).tool_input?.command||'')}catch{}})" 2>/dev/null)

# Only intercept `git commit` (not git commit --amend review, etc. — keep it simple)
if ! [[ "$CMD" =~ (^|[[:space:]])git[[:space:]]+commit([[:space:]]|$) ]]; then
  exit 0
fi

# Skip if repo is in a state we can't analyze
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

# Get staged .ts/.tsx files
STAGED=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null | grep -E '\.(ts|tsx)$' || true)
[ -z "$STAGED" ] && exit 0

# Find the tsconfig.json nearest to each staged file, de-duped
TSCONFIG_DIRS=""
while IFS= read -r file; do
  [ -z "$file" ] && continue
  dir=$(dirname "$file")
  while [ "$dir" != "." ] && [ "$dir" != "/" ] && [ -n "$dir" ]; do
    if [ -f "$dir/tsconfig.json" ]; then
      # Skip root tsconfigs that just extend a base with no compilerOptions (common in monorepos)
      if [ "$dir" = "." ]; then
        # Check if this root tsconfig is usable
        has_files=$(node -e "try{const c=require('./tsconfig.json');process.stdout.write(c.compilerOptions?Object.keys(c.compilerOptions).length>0?'1':'0':'0')}catch{process.stdout.write('0')}" 2>/dev/null)
        [ "$has_files" = "0" ] && break
      fi
      case ":$TSCONFIG_DIRS:" in
        *":$dir:"*) ;;
        *) TSCONFIG_DIRS="$TSCONFIG_DIRS:$dir" ;;
      esac
      break
    fi
    dir=$(dirname "$dir")
  done
done <<< "$STAGED"

[ -z "$TSCONFIG_DIRS" ] && exit 0

# Run tsc in each affected package, collect errors
ALL_ERRORS=""
IFS=':' read -ra DIRS <<< "${TSCONFIG_DIRS#:}"
for d in "${DIRS[@]}"; do
  [ -z "$d" ] && continue
  # Run tsc — capture up to 40 lines, stop after the first failing package to keep output readable
  OUTPUT=$(cd "$d" && npx --no-install tsc --noEmit 2>&1 | head -40)
  if echo "$OUTPUT" | grep -q "error TS"; then
    ALL_ERRORS="${ALL_ERRORS}=== $d ===\n${OUTPUT}\n\n"
    break
  fi
done

if [ -n "$ALL_ERRORS" ]; then
  # Emit a JSON block decision for Claude Code
  REASON=$(printf "tsc --noEmit failed on staged changes. Fix type errors before committing.\n\n%b" "$ALL_ERRORS")
  ESCAPED=$(echo "$REASON" | node -e "let d='';process.stdin.on('data',c=>d+=c);process.stdin.on('end',()=>process.stdout.write(JSON.stringify(d)))")
  echo "{\"decision\":\"block\",\"reason\":${ESCAPED}}"
  exit 2
fi

exit 0
