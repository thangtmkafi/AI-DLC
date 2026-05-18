# User Story Template

```markdown
## US-NN: [Title]

**Persona:** [link to personas.md#persona-name]
**Source:** REQ-XX, REQ-YY (from requirements.md)
**Epic:** EPIC-N (if applicable)
**Unit:** UNIT-N (assigned in Stage 9)

**Story:**
As a [persona],
I want [capability],
so that [outcome].

**Acceptance Criteria:**

- **AC-1:** Given [context], when [action], then [observable result]
- **AC-2:** Given [context], when [action], then [observable result]
- **AC-3:** Given [edge case], when [action], then [observable result]

**Out of scope for this story:**
- [Explicitly NOT covered, link to other story if elsewhere]

**Open items this depends on:**
- [Reference to open-items.md#id, or "none"]

**KB citations:**
- [KB section §X.Y]

**NFR notes:**
- Performance: [if relevant]
- Privacy: [auto-enabled if PII touched]
- Accessibility: [WCAG level if UI]

**Definition of Done:**
- [ ] All AC pass manual verification
- [ ] Code generated and reviewed
- [ ] Build succeeds
- [ ] Audit trail wired (auto via extension)
- [ ] No AI Review Checklist criticals open
```

## Rules

- One story per atomic capability (INVEST: Independent, Negotiable, Valuable, Estimable, Small, Testable)
- 3-7 AC per story typical; more = split the story
- AC must be observable (a tester can verify)
- "User is happy" is not an AC — use measurable behavior
- Use neutral roles (`user`, `operator`) until project's role taxonomy is confirmed
