# Installation, use, upgrades and GitHub publishing

## Choose a workflow

- **New app**: create a new project directory; install skills and subagents there; open it in VS Code; call `/build-app`.
- **Existing app**: create a branch, commit/stash local changes, install without overwriting existing definitions, review changes, then begin with a read-only audit.
- **Existing install**: pull a tagged or reviewed toolkit release and run `-Mode Check` / `--check`; run Upgrade only after reviewing the output. A manifest lets the installer safely upgrade *unchanged* managed skill and agent files.

## Prerequisites

1. VS Code and the official Claude Code extension OR Claude Code terminal installed and authenticated.
2. Git installed for cloning and updating this public repository.
3. Appropriate project access. Installations do not install Figma plugins or expose private repositories by themselves.

## New project — Windows PowerShell

```powershell
mkdir C:\Projects\my-app
git clone https://github.com/aranacj/claude-world-class-app-team.git C:\Projects\claude-world-class-app-team
& 'C:\Projects\claude-world-class-app-team\scripts\install.ps1' -TargetPath 'C:\Projects\my-app'
code C:\Projects\my-app
```

## Existing project — Windows PowerShell

```powershell
cd C:\Projects\my-app
git switch -c chore/claude-team-setup
& 'C:\Projects\claude-world-class-app-team\scripts\install.ps1' -TargetPath .
git status --short
```

If already on a working branch, you may instead commit or stash pending work before installation. Files with matching names are *never overwritten* on initial install. `CLAUDE.md` is created when missing or receives an appended, marked operating contract exactly once; review that edit. Note that the user owns this host-project file.

## New/existing project — macOS and Linux

```bash
git clone https://github.com/aranacj/claude-world-class-app-team.git ~/claude-world-class-app-team
mkdir -p ~/projects/my-app # only for new projects
bash ~/claude-world-class-app-team/scripts/install.sh ~/projects/my-app
```

## Update or upgrade

**Recommended:** inspect updates before applying; optionally pin a GitHub release tag (`git checkout v1.0.0`) rather than tracking `main`.

Windows:

```powershell
cd C:\Projects\claude-world-class-app-team
git pull --ff-only
.\scripts\install.ps1 -TargetPath C:\Projects\my-app -Mode Check
.\scripts\install.ps1 -TargetPath C:\Projects\my-app -Mode Upgrade
```

macOS/Linux:

```bash
cd ~/claude-world-class-app-team
git pull --ff-only
bash scripts/install.sh ~/projects/my-app --check
bash scripts/install.sh ~/projects/my-app --upgrade
```

- `Install` (default): adds missing skill/agent files, skips any existing ones.
- `Check`: previews missing/new, unchanged, locally modified and upgradeable managed files without writing.
- `Upgrade`: updates only files whose current SHA-256 matches the previous installation manifest, backing up old copies to `.claude/team-toolkit-backups/<timestamp>/`. Any file without a matching manifest entry is preserved and requires a manual merge.
- The manifest `.claude/team-toolkit-manifest.json` stays in the **target project** and can be versioned with the project. It does not track secrets or project data.
- `CLAUDE.md` is not replaced during upgrades. You can review `CLAUDE.team.example.md` changes and selectively update your project's contract.

## VS Code / Claude Code

1. Open the target project folder (`File > Open Folder`).
2. Install/enable official Claude Code extension and sign in.
3. Restart Claude Code after installation (or reopen VS Code window).
4. In a Claude Code session, invoke `/build-app <your idea>` or tell Claude what to build.
5. Keep one main session; Claude can delegate subtasks to the specialist agents in `.claude/agents/`. Separate VS Code windows are optional, not required. Agents consume account usage.
6. Confirm agent discovery in Claude Code (`/agents`, if supported by the installed version), inspect `.claude/agents` and `.claude/skills` if a definition is missing.

## Useful first prompts

**Greenfield:** `/build-app I want to create a simple yet powerful property management platform. Lead the discovery and planning first. Ask high-impact questions and give me the next concrete milestone.`

**Existing:** `Use build-app and workflow-mapper to inspect the repository in read-only mode. Summarize the user journeys, broken navigation, permissions, risks and a prioritized roadmap. Do not make changes.`

**Resume:** `Read docs/product/PROJECT_STATE.md and continue the next approved phase. Show unresolved decisions and evidence before implementing.`

## Figma

Figma integration is optional. Set up an authorized Claude Code/Figma integration separately, following current provider documentation. Give Claude the Figma file or node link and ask the Figma specialist to map screens, tokens, states and flows. Without a live integration, work from exported screenshots and labeled design specs; do not claim the tool can directly edit Figma.

## GitHub public release — repository owner guide

1. On GitHub create a **public empty repository** named `claude-world-class-app-team` under your own account `aranacj` (no generated README, `.gitignore` or license because these exist already).
2. Review every file for secrets, incorrect credits and third-party license restrictions.
3. Copy the release tree to a local folder, open a terminal there, then:

```powershell
git init -b main
git config user.name "Christian"
git config user.email "YOUR_GITHUB_VERIFIED_EMAIL_OR_NOREPLY"
git add .
git commit -m "Initial release: Claude World-Class App Team"
git remote add origin https://github.com/aranacj/claude-world-class-app-team.git
git push -u origin main
```

4. Check the commit and author on GitHub. **Do not add `Co-authored-by:`** in the commit message. If another collaborator later commits, GitHub will correctly attribute their commit to them; a repository README cannot alter factual commit authorship.
5. Suggested short GitHub About description: `A guided Claude Code AI development team: 10 skills and 10 agents for product, Figma, UX, architecture, security, coding, QA and launch. VS Code-ready.`
6. Add repository topics: `claude-code`, `claude-skills`, `ai-agents`, `vscode`, `software-development`, `product-design`, `figma`, `ux`, `architecture`, `qa`.
7. Create a GitHub Release after testing. The `LICENSE` is **source-available, not MIT or open-source**; GitHub may show "Other" for license detection.

## Troubleshooting

- **Skill not detected:** Confirm `.claude/skills/build-app/SKILL.md` exists in the *opened project*, not just the toolkit source checkout; restart Claude Code.
- **Subagent not found:** Check `.claude/agents/*.md` in the correct workspace; ensure plugin/permissions support delegation.
- **File conflict on install/upgrade:** The installer intentionally skips unknown/local edits. Compare the new source with the target; manually reconcile only if permitted under your installation rights, or reinstall an unmodified kit copy into a fresh project.
- **Windows execution policy:** Run from a trusted local clone; if execution is blocked, prefer a one-session `powershell -ExecutionPolicy Bypass -File ...` only after inspecting the installer rather than changing machine-wide policy.
- **Permission errors:** Verify you own the target folder, have a writable filesystem and do not have files locked in VS Code.
