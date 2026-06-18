---
name: domain-modeling
description: Build and sharpen a project's domain model. Use when the user wants to pin down domain terminology or a ubiquitous language, record an architectural decision, or when another skill needs to maintain the domain model.
---

# Domain Modeling

Actively build and sharpen the project's domain model as you design. Challenge terms, invent edge-case scenarios, and write the glossary and decisions down the moment they crystallise.

## File structure

Most repos have a single context:

```
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

If a `CONTEXT-MAP.md` exists at the root, the repo has multiple contexts. The map points to where each one lives:

```
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/                          ← system-wide decisions
├── src/
│   ├── ordering/
│   │   ├── CONTEXT.md
│   │   └── docs/adr/                 ← context-specific decisions
│   └── billing/
│       ├── CONTEXT.md
│       └── docs/adr/
```

Create files lazily — only when you have something to write.

## During the session

- **Challenge against the glossary**: When the user uses a term that conflicts with the existing language in `CONTEXT.md`, call it out immediately.
- **Sharpen fuzzy language**: When the user uses vague or overloaded terms, propose a precise canonical term.
- **Discuss concrete scenarios**: When domain relationships are being discussed, stress-test them with specific edge-case scenarios.
- **Cross-reference with code**: When the user states how something works, check whether the code agrees. Surface contradictions.
- **Update CONTEXT.md inline**: When a term is resolved, update `CONTEXT.md` right there. Don't batch these up. Keep it a pure glossary — no implementation details.
- **Offer ADRs sparingly**: Only offer to create an ADR when all three are true:
  1. Hard to reverse
  2. Surprising without context
  3. The result of a real trade-off
  If any is missing, skip the ADR.
