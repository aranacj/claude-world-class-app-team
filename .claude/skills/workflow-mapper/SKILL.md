---
name: workflow-mapper
description: Map all screens, routes, actions, modules, roles, state transitions, cross-feature links and dead ends in an existing application; generate Mermaid diagrams and structured navigation inventories. Use for full application maps, navigation audits and discovering disconnected functionality.
---
# Application Workflow Mapper

## Goal
Create an evidence-based, navigable model of how the entire application connects—not merely a sitemap.

## Read-only rule
Inspect without changing source, Figma, data or deployments. Do not claim 100% coverage without route and role evidence. Do not crawl authenticated systems using credentials unless explicitly authorized. Do not perform destructive workflows.

## Evidence discovery
1. Define scope (repo branches, web/mobile apps, user roles, environments, feature flags) and choose a reproducible snapshot (commit/hash if available).
2. Inventory UI routes/pages, nested navigation, menus, dialogs, tabs, links, contextual CTAs, redirects, access guards, deep links and entry points. Use code search and route definitions when accessible.
3. Map backend actions that change state, APIs, background jobs, emitted events, database relationships and permissions, only when supported by inspected sources.
4. If browser/prototype access exists, trace high-priority user paths and compare runtime behavior against code-defined routes. Mark untested edges.
5. Build edge table with: source, action, destination, condition/permission, state transition, evidence, confidence.
6. Identify unreachable pages, orphan actions, navigation loops, hidden but valuable capabilities, ambiguous labels, duplicate flows, unauthorized/error gaps and feature handoff failures.
7. Partition graph by domain so it is readable. Provide an overview diagram and one domain-level flowchart per module; do not output a single unreadable giant chart.
8. Rank missing links by user impact; recommend contextual navigation and task-centered hubs. Verify links with UX auditor.

## Required files to produce (only when writing reports is authorized)
- reports/workflows/route-inventory.md
- reports/workflows/edge-inventory.csv
- reports/workflows/application-map.mmd
- reports/workflows/domain-<name>.mmd
- reports/workflows/gaps-and-recommendations.md

If file writing is not authorized, present the same artifacts in the response instead.

## Edge inventory columns
source_id,source_label,trigger,destination_id,destination_label,role,condition,state_change,evidence,confidence,verified_runtime

## Mermaid conventions
Use stable short node IDs; friendly labels; separate permission decisions; label edges with the user action; show start, completion and recovery. Keep each diagram focused and syntax-valid. If Mermaid is unsupported, provide route/edge tables.

## Coverage report
Count discovered routes, inspected routes, role variants, confirmed transitions, inferred transitions, untested areas and known dead ends. Never fabricate percentages.

## Handoff
`ux-auditor` assesses friction; `product-architect` specifies cross-module remediation; `figma-design` updates navigation concepts. Do not refactor the application while mapping it.
