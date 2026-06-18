---
name: grill-with-docs
description: A relentless interview to sharpen a plan or design, which also creates docs (ADRs and glossary) as you go.
disable-model-invocation: true
---

# Grill With Docs

Run a grilling session that simultaneously builds the project's domain model — creating and updating CONTEXT.md (glossary) and ADRs as decisions crystallise.

## Process

1. **Grill me relentlessly** about every aspect of the plan until we reach shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one.

2. **Ask one question at a time**, waiting for my answer before continuing. Provide your recommended answer for each question.

3. **Cross-reference with the codebase**: when I state how something works, check whether the code agrees. Surface contradictions immediately.

4. **Build the domain model as you go**:
   - When a term is resolved, update `CONTEXT.md` right there. Keep it a pure glossary — no implementation details.
   - When a hard-to-reverse decision is made with real trade-offs, offer to create an ADR in `docs/adr/`.
   - Challenge fuzzy or overloaded terms. Propose precise canonical language.
   - Stress-test relationships with concrete edge-case scenarios.

5. **Offer ADRs sparingly** — only when all three are true:
   - Hard to reverse
   - Surprising without context
   - The result of a real trade-off with genuine alternatives
   If any is missing, skip the ADR.
