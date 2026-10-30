# Homebrew tap for Syzify

[Syzify](https://syzify.siliconbasement.com/) is a private training log that keeps your activities on your computer.

```
brew install --cask stasyanz/syzify/syzify
```

Syzify updates itself from inside the app, so `brew upgrade` leaves it alone unless you pass `--greedy`.

## Not notarized

Syzify is not notarized by Apple yet. A quarantined copy would be called "damaged", so this cask removes the quarantine flag after installing. That is the same step the website asks for after a manual download. Installing from this tap means trusting it and the [GitHub releases](https://github.com/Stasyanz/syzify/releases) it downloads from.

## Uninstalling

`brew uninstall --cask syzify` removes the app. `brew uninstall --cask --zap syzify` also removes its caches and preferences.

Neither touches your vault: your activities stay where they are until you delete them yourself.
