# CONTEXT.md format

`CONTEXT.md` is a pure glossary — no implementation details, no specs, no scratch notes.

```markdown
# Glossary

## Term
A precise, one-sentence definition of the term.

## Another term
...
```

## Rules

- Each term gets one entry with a single-sentence definition
- Do not include how something is implemented — only what it *is* in the domain
- Update immediately when a term is resolved (don't batch)
- If the same word means different things in different subdomains, prefix: `Ordering/Account` vs `Billing/Account`
