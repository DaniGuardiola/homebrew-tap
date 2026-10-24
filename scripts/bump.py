#!/usr/bin/env python3
"""Points each cask at its project's latest stable GitHub release, using the release's SHA256SUMS."""
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parent.parent
# cask -> (release repository, DMG name for a version)
CASKS = {
    'igor-computer': ('DaniGuardiola/igor.computer', 'igor.computer-{version}-arm64.dmg'),
}

def gh(*args):
    return subprocess.check_output(['gh', *args], text=True)

for cask, (repository, asset) in CASKS.items():
    path = ROOT / 'Casks' / f'{cask}.rb'
    text = path.read_text()
    current = re.search(r'^  version "([^"]+)"$', text, re.M)[1]
    # Without a tag, gh uses the latest release, which is never a prerelease.
    tag = json.loads(gh('release', 'view', '--repo', repository, '--json', 'tagName'))['tagName']
    version = tag.removeprefix('v')
    if version == current:
        continue
    sums = gh('release', 'download', tag, '--repo', repository, '--pattern', 'SHA256SUMS', '--output', '-')
    name = asset.format(version=version)
    digest = next(line.split()[0] for line in sums.splitlines() if line.split()[1:] == [name])
    text = re.sub(r'^  version "[^"]+"$', f'  version "{version}"', text, count=1, flags=re.M)
    text = re.sub(r'^  sha256 "[^"]+"$', f'  sha256 "{digest}"', text, count=1, flags=re.M)
    path.write_text(text)
    print(f'{cask}: {current} -> {version}')
