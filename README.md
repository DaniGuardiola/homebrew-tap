# DaniGuardiola's Homebrew tap

```sh
brew trust daniguardiola/tap  # Homebrew asks you to trust third-party taps once
brew install --cask daniguardiola/tap/extend-computer
brew install --cask daniguardiola/tap/igor-computer
```

| Cask | App |
| --- | --- |
| `extend-computer` | [extend.computer](https://extend.computer/): share keyboard, mouse and displays between your devices |
| `igor-computer` | [igor.computer](https://github.com/DaniGuardiola/igor.computer): a persistent computer for AI agents |

Apps here update themselves, so `brew upgrade` skips them unless you pass
`--greedy`. Casks follow each project's latest stable release; an hourly
workflow bumps them.
