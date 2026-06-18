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

## Quick start

Clone the repo (anywhere you like), then run `setup.sh` from inside it:

```bash
git clone https://github.com/FerdinandNathaniel/agent_resources.git
cd agent_resources
./setup.sh --skills
```

The script auto-detects where it lives — it works the same whether cloned to `~/.config/agent_resources/`, `~/dotfiles/agent_resources/`, or anywhere else.

### Install skills globally

```bash
cd agent_resources
./setup.sh --skills
```

Symlinks skills into `~/.copilot/skills/` (VS Code), `~/.config/opencode/skills/` (OpenCode), `~/.claude/skills/` (Claude Code), and `~/.hermes/skills/` (Hermes Agent) — wherever you have those tools installed.

### Init a new project

```bash
cd my-project
/path/to/agent_resources/setup.sh --init
```

Copies AGENTS.md, copilot-instructions.md, and CONTEXT.md templates into your project.

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
