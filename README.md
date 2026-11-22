# DaniGuardiola's Homebrew tap

```sh
brew trust daniguardiola/tap  # Homebrew asks you to trust third-party taps once
brew install --cask daniguardiola/tap/extend-computer
brew install --cask daniguardiola/tap/igor-computer
brew install daniguardiola/tap/zen
```

| Cask | App |
| --- | --- |
| `extend-computer` | [extend.computer](https://extend.computer/): share keyboard, mouse and displays between your devices |
| `igor-computer` | [igor.computer](https://github.com/DaniGuardiola/igor.computer): a persistent computer for AI agents |
| `zen` (formula) | [zen.dio.la](https://zen.dio.la): companion for a quiet conversation with a Madhyamaka monk |

Apps here update themselves, so `brew upgrade` skips them unless you pass
`--greedy`. Casks follow each project's latest stable release; an hourly
workflow bumps them.
