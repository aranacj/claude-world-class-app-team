# Evidence-based product quality rubric

Use 0=unassessed, 1=poor, 2=partial, 3=meets defined bar, 4=strong evidence/above bar. Do not assert 4 without measurement or user validation.

| Dimension | Evidence to collect | Acceptance example (tailor) |
|---|---|---|
| User value | interviews / validated assumptions / retention | core job solved end-to-end |
| Discoverability & information architecture | task-based navigation test | common journeys require few predictable steps |
| UX accessibility | WCAG audit and keyboard/screen-reader tests | target WCAG 2.2 AA for relevant surfaces |
| UI consistency & responsive behavior | design-token and viewport checks | no unhandled empty/loading/error states |
| Workflow correctness | process maps, role matrix, E2E tests | critical state transitions audited |
| Security/privacy | threat model, authz tests, dependency audit | no known critical auth/data exposure issue |
| Reliability | SLOs, failure recovery, monitoring | SLO agreed and instrumented |
| Performance | lab and real-user metrics | budgets defined and validated |
| Code quality | CI, review, debt tracking | critical paths maintainable/tested |
| Differentiation | competitive study and user feedback | distinct value thesis backed by evidence |
| Operations | backup/restore drill, rollback, runbooks | tested rollback and accountable owner |

Report scores with citations to specific local artifacts or test output; unmeasured dimensions remain 0. No overall 'world-class' badge from a self-assessment.
