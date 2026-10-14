#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"
MODE="${2:---install}"
if [[ "$MODE" != --check && "$MODE" != --upgrade && "$MODE" != --install ]]; then echo 'Usage: install.sh TARGET [--check|--upgrade]' >&2; exit 2; fi
if [[ ! -d "$TARGET" ]]; then echo "Target does not exist: $TARGET" >&2; exit 2; fi
TARGET="$(cd "$TARGET" && pwd)"
if [[ "$TARGET" == "$ROOT" ]]; then echo 'Do not install into toolkit source directory' >&2; exit 2; fi
python3 - "$ROOT" "$TARGET" "$MODE" <<'PYINNER'
import hashlib, json, pathlib, sys, datetime, shutil
root,target,mode=pathlib.Path(sys.argv[1]),pathlib.Path(sys.argv[2]),sys.argv[3]
folder=target/'.claude'; manifest=folder/'team-toolkit-manifest.json'
try: old=json.loads(manifest.read_text()).get('files',{}) if manifest.exists() else {}
except Exception as e: raise SystemExit(f'Invalid manifest; refusing upgrade: {e}')
new=dict(old); changed=False
for category in ('skills','agents'):
  for source in sorted((root/'.claude'/category).rglob('*')):
    if not source.is_file(): continue
    rel=source.relative_to(root/'.claude').as_posix(); dest=folder/rel
    hashfile=lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    incoming=hashfile(source)
    if not dest.exists():
      print('ADD:',rel)
      if mode!='--check':
        dest.parent.mkdir(parents=True,exist_ok=True); shutil.copy2(source,dest); new[rel]=incoming; changed=True
    else:
      current=hashfile(dest)
      if current==incoming:
        print('CURRENT:',rel)
        if mode!='--check' and rel not in new: new[rel]=incoming; changed=True
      elif mode=='--upgrade' and rel in old and current==old[rel]:
        print('UPGRADE:',rel)
        backup=folder/'team-toolkit-backups'/datetime.datetime.now().strftime('%Y%m%d-%H%M%S')/rel
        backup.parent.mkdir(parents=True,exist_ok=True); shutil.copy2(dest,backup); shutil.copy2(source,dest)
        new[rel]=incoming; changed=True
      else: print('SKIP (existing/locally edited):',rel)
if mode!='--check':
  claude=target/'CLAUDE.md'; source=root/'CLAUDE.team.example.md'
  if not claude.exists(): claude.write_bytes(source.read_bytes()); print('ADDED CLAUDE.md starter')
  elif '<!-- claude-world-class-app-team -->' not in claude.read_text():
    with claude.open('a') as o: o.write('\n\n<!-- claude-world-class-app-team -->\n'+source.read_text())
    print('APPENDED operating contract to CLAUDE.md')
  if changed or not manifest.exists():
    folder.mkdir(parents=True,exist_ok=True)
    manifest.write_text(json.dumps({'schema_version':1,'files':dict(sorted(new.items()))},indent=2)+'\n')
print('Finished:',mode,'— inspect git diff and restart Claude Code')
PYINNER
