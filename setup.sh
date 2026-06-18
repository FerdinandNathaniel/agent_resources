#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── Detect targets ──────────────────────────────────────────────
TARGETS=()
has_vscode()  { [ -d "$HOME/.copilot" ]; }
has_opencode(){ [ -d "$HOME/.config/opencode" ]; }
has_claude()  { [ -d "$HOME/.claude" ]; }
has_hermes()  { [ -d "$HOME/.hermes" ]; }

# ── Flags ───────────────────────────────────────────────────────
DO_SKILLS=false
DO_AGENTS=false
DO_PROMPTS=false
DO_INIT=false

usage() {
  echo "Usage: ./setup.sh [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --all         Install everything (skills, agents, prompts)"
  echo "  --skills      Symlink skills into agent skill directories"
  echo "  --agents      Symlink custom agents into agent directories"
  echo "  --prompts     Copy prompts into current project's .github/prompts/"
  echo "  --init        Copy template instructions into current project"
  echo "  --help        Show this message"
  exit 0
}

# ── Parse flags ─────────────────────────────────────────────────
if [ $# -eq 0 ]; then
  usage
fi

for arg in "$@"; do
  case "$arg" in
    --all)      DO_SKILLS=true; DO_AGENTS=true; DO_PROMPTS=true ;;
    --skills)   DO_SKILLS=true ;;
    --agents)   DO_AGENTS=true ;;
    --prompts)  DO_PROMPTS=true ;;
    --init)     DO_INIT=true ;;
    --help)     usage ;;
    *)          echo "Unknown flag: $arg"; usage ;;
  esac
done

# ── Symlink skills ──────────────────────────────────────────────
install_skills() {
  local src="$REPO_DIR/skills"
  if [ ! -d "$src" ] || [ -z "$(ls -A "$src" 2>/dev/null)" ]; then
    echo "  No skills to install."
    return
  fi

  for target_dir in "$HOME/.copilot/skills" "$HOME/.config/opencode/skills" "$HOME/.claude/skills" "$HOME/.hermes/skills"; do
    if [ -d "$(dirname "$target_dir")" ]; then
      mkdir -p "$target_dir"
      echo "  → $target_dir"
      for skill_dir in "$src"/*/; do
        [ -d "$skill_dir" ] || continue
        local name="$(basename "$skill_dir")"
        local link="$target_dir/$name"
        if [ -L "$link" ] && [ "$(readlink "$link")" = "$skill_dir" ]; then
          echo "    ✓ $name (already linked)"
        elif [ -e "$link" ]; then
          echo "    ⚠ $name exists — skipping"
        else
          ln -s "$skill_dir" "$link"
          echo "    + $name"
        fi
      done
    fi
  done
}

# ── Symlink custom agents ──────────────────────────────────────
install_agents() {
  local src="$REPO_DIR/agents"
  if [ ! -d "$src" ] || [ -z "$(ls -A "$src" 2>/dev/null)" ]; then
    echo "  No agents to install."
    return
  fi

  for target_dir in "$HOME/.copilot/agents" "$HOME/.config/opencode/agents"; do
    if [ -d "$(dirname "$target_dir")" ]; then
      mkdir -p "$target_dir"
      echo "  → $target_dir"
      for agent_file in "$src"/*.agent.md; do
        [ -f "$agent_file" ] || continue
        local name="$(basename "$agent_file")"
        local link="$target_dir/$name"
        if [ -L "$link" ] && [ "$(readlink "$link")" = "$agent_file" ]; then
          echo "    ✓ $name (already linked)"
        elif [ -e "$link" ]; then
          echo "    ⚠ $name exists — skipping"
        else
          ln -s "$agent_file" "$link"
          echo "    + $name"
        fi
      done
    fi
  done
}

# ── Copy prompts into current project ──────────────────────────
install_prompts() {
  local src="$REPO_DIR/prompts"
  if [ ! -d "$src" ] || [ -z "$(ls -A "$src" 2>/dev/null)" ]; then
    echo "  No prompts to install."
    return
  fi

  local target="$PWD/.github/prompts"
  mkdir -p "$target"
  echo "  → $target"
  for prompt_file in "$src"/*.prompt.md; do
    [ -f "$prompt_file" ] || continue
    local name="$(basename "$prompt_file")"
    local dest="$target/$name"
    if [ -f "$dest" ]; then
      echo "    ⚠ $name exists — skipping"
    else
      cp "$prompt_file" "$dest"
      echo "    + $name"
    fi
  done
}

# ── Init project templates ─────────────────────────────────────
init_templates() {
  local src="$REPO_DIR/instructions"
  if [ ! -d "$src" ] || [ -z "$(ls -A "$src" 2>/dev/null)" ]; then
    echo "  No instruction templates found."
    return
  fi

  # AGENTS.md → project root
  if [ -f "$src/AGENTS.md" ]; then
    if [ -f "$PWD/AGENTS.md" ]; then
      echo "  ⚠ AGENTS.md exists — skipping"
    else
      cp "$src/AGENTS.md" "$PWD/AGENTS.md"
      echo "  + $PWD/AGENTS.md"
    fi
  fi

  # copilot-instructions.md → .github/
  if [ -f "$src/copilot-instructions.md" ]; then
    mkdir -p "$PWD/.github"
    if [ -f "$PWD/.github/copilot-instructions.md" ]; then
      echo "  ⚠ .github/copilot-instructions.md exists — skipping"
    else
      cp "$src/copilot-instructions.md" "$PWD/.github/copilot-instructions.md"
      echo "  + $PWD/.github/copilot-instructions.md"
    fi
  fi

  # CONTEXT.md → project root
  if [ -f "$src/CONTEXT.md" ]; then
    if [ -f "$PWD/CONTEXT.md" ]; then
      echo "  ⚠ CONTEXT.md exists — skipping"
    else
      cp "$src/CONTEXT.md" "$PWD/CONTEXT.md"
      echo "  + $PWD/CONTEXT.md"
    fi
  fi
}

# ── Run ─────────────────────────────────────────────────────────
echo "agent_resources — setup"
echo ""

[ "$DO_SKILLS" = true ] && { echo "== Skills";  install_skills;  echo ""; }
[ "$DO_AGENTS" = true ] && { echo "== Agents";  install_agents;  echo ""; }
[ "$DO_PROMPTS" = true ] && { echo "== Prompts"; install_prompts; echo ""; }
[ "$DO_INIT" = true ]   && { echo "== Init";    init_templates;  echo ""; }

echo "Done."
