# Claude World-Class App Team

**One app idea. One Claude Code conversation. A coordinated product-and-engineering team.**

Created and maintained by **Christian ([@aranacj](https://github.com/aranacj))**.

A practical Claude Code toolkit for product research, workflow mapping, Figma design, usability audits, architecture, security, implementation, testing and review. It provides **10 reusable skills and 10 specialist subagents** so you can start with an idea such as “I want to build a great time-tracking app” and let the product lead guide the correct development sequence.

> **License:** Source-available, use and unmodified copying allowed; modifications and derivative distributions prohibited without written permission. **Not open-source.** Read [LICENSE](LICENSE) before using or distributing.
>
> **Reality check:** the toolkit supplies expert workflows and checks, not guaranteed business success, security compliance or autonomous unattended releases. Validate all results and authorize significant changes.

## Start here

**Requirements:** Claude Code installed and authenticated; VS Code with the official Claude Code extension or a terminal; Git for GitHub-based install. Figma access requires a separately configured integration. No special subscription is needed for each specialist; subagents consume your Claude Code usage allocation.

### New project on Windows (PowerShell)

```powershell
mkdir C:\Projects\my-app
# Clone this repo once (no piping remote code directly to a shell)
git clone https://github.com/aranacj/claude-world-class-app-team.git C:\Projects\claude-world-class-app-team
& 'C:\Projects\claude-world-class-app-team\scripts\install.ps1' -TargetPath 'C:\Projects\my-app'
code C:\Projects\my-app
```

### Existing VS Code project on Windows

```powershell
# From a PowerShell terminal in your existing app repository:
& 'C:\Projects\claude-world-class-app-team\scripts\install.ps1' -TargetPath .
# Inspect the diff before committing
 git status --short
 git diff -- CLAUDE.md
```

### macOS / Linux (new or existing project)

```bash
git clone https://github.com/aranacj/claude-world-class-app-team.git ~/claude-world-class-app-team
# For new projects: mkdir -p ~/projects/my-app
bash ~/claude-world-class-app-team/scripts/install.sh /path/to/your/project
```

Use **one main Claude Code session**. The main session invokes `/build-app` or automatically discovers the skill for requests like “Build a project management SaaS.” It calls specialist subagents only when their expertise is needed. You do **not** need ten VS Code windows or separate paid accounts.

### Start building

Open the target project in VS Code and in Claude Code write:

```text
/build-app I want to build a category-leading time tracking platform for construction teams. Guide me through discovery, differentiation, workflows, world-class UI/UX, secure architecture, incremental development, independent QA and launch readiness. Ask only decisions that truly need my input; keep a record of approved decisions; do not modify production systems without my permission.
```

### Upgrade from GitHub

The install scripts **never silently overwrite existing files**, including earlier toolkit installs. To preview incoming differences, first pull the toolkit:

```powershell
cd C:\Projects\claude-world-class-app-team
git pull --ff-only
.\scripts\install.ps1 -TargetPath C:\Projects\my-app -Mode Check
```

Then to upgrade **toolkit-managed files only**, keeping backups and skipping any locally edited files:

```powershell
.\scripts\install.ps1 -TargetPath C:\Projects\my-app -Mode Upgrade
```

On macOS/Linux:

```bash
cd ~/claude-world-class-app-team && git pull --ff-only
bash scripts/install.sh /path/to/your/project --check
bash scripts/install.sh /path/to/your/project --upgrade
```

**Upgrade behavior:** Uses a local installation manifest of SHA-256 checksums. Files changed by the user are skipped; previously installed, unchanged toolkit files can be backed up and upgraded. `CLAUDE.md` is never overwritten by upgrades. If upgrading a project installed with an older toolkit (no manifest), existing files are skipped for manual reconciliation. See [INSTALL.md](INSTALL.md).

## How the team fits together

| Role | Purpose |
|---|---|
| Product Lead `/build-app` | Orchestrates stages and tracks decisions |
| Workflow Mapper | Routes, dependencies, cross-module navigation |
| UX Auditor | Usability defects, information hierarchy, accessibility |
| Product Architect | Feature scope, user journeys, product strategy |
| Figma Design | Design analysis, tokens, interaction specifications |
| UX Designer | User-centered journeys and UX guidance |
| Software Architect | System boundaries, APIs, data, security and tradeoffs |
| Senior Developer | Implements scoped, approved increments |
| QA Engineer | Tests functional and non-functional requirements |
| Code Reviewer | Independent regression, reliability and security review |

Read [INSTALL.md](INSTALL.md) for installation scenarios, safe upgrades, verification, VS Code setup, troubleshooting and publishing instructions. Read [CLAUDE.team.example.md](CLAUDE.team.example.md) for project operating rules.

## Security and privacy

Review skill content and scripts before installing. Treat AI-generated code and output as untrusted until reviewed. Use least-privilege credentials and isolated test data. Never commit `.env`, API keys or secrets. Deployments, production schema migrations and destructive actions require explicit authorization.

## Attribution

**Author:** Christian (GitHub [@aranacj](https://github.com/aranacj)). This repository uses a single-author attribution and includes no `Co-authored-by` trailers. Your future commits are attributed according to *your* local Git identity; verify `git config user.name` and `git config user.email` if you want your GitHub account shown as the commit author.
