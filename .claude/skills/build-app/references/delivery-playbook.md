# Delivery playbook

## Stage artifacts (examples, not mandatory bureaucracy)
- 0: `00-intake.md`, current-product inventory and constraints
- 1: `01-product-strategy.md`, `02-competitive-landscape.md`, metrics, prioritized outcomes
- 2: `03-personas-and-journeys.md`, `04-workflow-map.md`, roles/permission matrix, error/state matrix
- 3: `05-experience-spec.md`, component inventory, accessibility audit, design review notes
- 4: `06-architecture.md`, `07-threat-model.md`, ADRs, data/contract schemas
- 5: `08-delivery-plan.md`, backlog of thin vertical slices and acceptance criteria
- 6: code and change report; CI/test artifacts
- 7: `09-verification.md`, issue log, risk acceptance
- 8: `10-launch-checklist.md`, monitoring/rollback, user feedback plan

## Gate checklist
Each gate states PASS / CONDITIONAL / BLOCKED, objective evidence, unknowns, decision owner, and risk.
- Strategy: named users, real pain, differentiated promise, measurable outcomes, explicit non-goals.
- Workflow: primary journey is discoverable, state changes traceable, permissions aligned, edge cases recoverable.
- UX: key user tasks usable on desktop/mobile, keyboard/screen-reader review scoped, empty/loading/error states specified.
- Engineering: bounded designs, migrations planned, isolation and security threats reviewed, measurable non-functional targets.
- Implementation: feature acceptance tests, observable telemetry, scoped changes, security controls.
- Release: critical security bugs fixed, recovery runbook and rollback, data privacy review, owner approval.

## Decision thresholds
Seek confirmation for irreversible tech/vendor, cross-tenant data design, budgets, scope that affects schedule, breaking APIs, or production actions. For low-risk reversible choices choose a well-supported default and show rationale.

## Example intake
User: "Build the best app for landlords." Do NOT begin writing CRUD pages. Identify primary segment (small landlord vs operator), user jobs (onboard tenancy, notice, inspections), current app context, competitive differentiation and MVP outcomes. Map move-out notice -> inspection -> deposit -> resolution with permissions and exceptions. Start one vertical slice after approval.
