# agent_resources

Personal repository of materials and resources for working with AI coding agents.

## Structure

```
agent_resources/
├── setup.sh              # Install skills, agents, prompts globally
├── skills/               # Agent Skills (SKILL.md) — portable, auto-loaded
├── agents/               # Custom agent definitions (.agent.md)
├── prompts/              # Reusable prompt files (.prompt.md)
├── instructions/         # Templates for project-level context files
└── reference/            # Format guides and supporting docs
```

## Platform support

`setup.sh` is pure POSIX bash — works on **macOS** and **Linux** out of the box.

**Windows** requires a bash runtime (choose one):
- [Git Bash](https://git-scm.com) (comes with Git for Windows) — recommended
- [WSL](https://learn.microsoft.com/en-us/windows/wsl/) (Ubuntu via Windows Subsystem for Linux)

> Symlinks on Windows: enable **Developer Mode** (Settings → For developers) or run Git Bash **as Administrator** — otherwise `ln -s` may fail or create copies instead.

## Workflow

This repo follows a three-step flow for every new project:

### 1. One-time: clone & install skills

Clone the repo anywhere, then run `setup.sh --skills` once per machine:

```bash
git clone https://github.com/FerdinandNathaniel/agent_resources.git
cd agent_resources
./setup.sh --skills
```

This symlinks all skills into `~/.copilot/skills/` (VS Code), `~/.config/opencode/skills/` (OpenCode), `~/.claude/skills/` (Claude Code), and `~/.hermes/skills/` (Hermes Agent) — wherever you have those tools installed. The script auto-detects its location, so the repo can live anywhere.

### 2. Per-project: init templates

When starting a new project, copy in the context templates:

```bash
cd my-new-project
/path/to/agent_resources/setup.sh --init
```

This creates `AGENTS.md` and `CONTEXT.md` in the project root, plus `.github/copilot-instructions.md`. These are starting points — edit them to describe your project.

### 3. Per-session: grill with docs

Open your agent in the project and invoke the skill:

> **`/grill-with-docs`**

The agent will interview you relentlessly about your plan or design — one question at a time — while simultaneously building your project's `CONTEXT.md` glossary and creating ADRs in `docs/adr/` for hard-to-reverse decisions. The result: a shared language between you and the agent, documented decisions, and far less verbose conversations going forward.

### All commands

```bash
cd agent_resources
./setup.sh --all       # Install everything (skills + agents + prompts)
./setup.sh --skills    # Symlink skills only
./setup.sh --agents    # Symlink custom agents only
./setup.sh --prompts   # Copy prompts into current project
./setup.sh --init      # Copy template files into current project
./setup.sh --help      # Show usage
```

## Skills included

| Skill | Invoke | What it does |
|---|---|---|
| `grill-with-docs` | `/grill-with-docs` | Relentless interview that builds CONTEXT.md and ADRs |
| `grilling` | Auto-loaded | Core interview loop: one question at a time |
| `domain-modeling` | Auto-loaded | Domain terminology and ADR discipline |
