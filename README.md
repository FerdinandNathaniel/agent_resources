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

## Quick start

### Install skills globally
```bash
~/.config/agent_resources/setup.sh --skills
```

This symlinks all skills into `~/.copilot/skills/`, `~/.config/opencode/skills/`, and `~/.claude/skills/` — wherever you have those tools installed.

### Init a new project
```bash
cd my-project
~/.config/agent_resources/setup.sh --init
```

Copies AGENTS.md, copilot-instructions.md, and CONTEXT.md templates into your project.

## Skills included

| Skill | Invoke | What it does |
|---|---|---|
| `grill-with-docs` | `/grill-with-docs` | Relentless interview that builds CONTEXT.md and ADRs |
| `grilling` | Auto-loaded | Core interview loop: one question at a time |
| `domain-modeling` | Auto-loaded | Domain terminology and ADR discipline |
