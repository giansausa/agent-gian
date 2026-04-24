#!/usr/bin/env bash
# smoke-invoke.sh — verifies every SKILL.md file is syntactically valid markdown
# with correct YAML frontmatter. Does NOT actually invoke skills in Claude Code
# (that requires a live CC session); this is a static-check layer.
set -euo pipefail

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${PLUGIN_ROOT}/skills"

EXPECTED=(
  "agent-gian"
  "agent-gian-diagnose-first"
  "agent-gian-review"
  "agent-gian-qa"
  "agent-gian-commit"
  "agent-gian-pause"
  "agent-gian-resume"
)

for name in "${EXPECTED[@]}"; do
  file="${SKILLS_DIR}/${name}/SKILL.md"
  [ -f "${file}" ] || { echo "FAIL: missing ${file}"; exit 1; }

  # Verify frontmatter opens with --- on line 1 and contains required keys
  head -1 "${file}" | grep -q "^---$" || { echo "FAIL: ${file} does not start with frontmatter delimiter"; exit 1; }

  for key in "name:" "version:" "description:" "allowed-tools:" "triggers:"; do
    head -30 "${file}" | grep -q "^${key}" || { echo "FAIL: ${file} missing ${key}"; exit 1; }
  done

  # Verify name matches directory
  actual_name=$(head -30 "${file}" | awk -F': *' '/^name:/ {print $2; exit}')
  if [ "${actual_name}" != "${name}" ]; then
    echo "FAIL: ${file} name field '${actual_name}' does not match directory '${name}'"
    exit 1
  fi

  echo "OK: ${name}"
done

echo "PASS: all 7 skills present with valid frontmatter"
