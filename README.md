# homebrew-tandem

Homebrew tap for [Tandem](https://github.com/Jonezzyboy/tandem) — a desktop app for
working on one change across many repos: a git worktree per repo on a shared branch,
merge order worked out from their manifests, and PRs opened and cross-linked together.

```sh
brew install --cask Jonezzyboy/tandem/tandem
```

Universal (Apple Silicon and Intel), and you need `gh` signed in (`gh auth login`) —
the app has no login of its own.

The app is ad-hoc signed rather than notarised with an Apple Developer ID, so the cask
clears the quarantine attribute on install to stop Gatekeeper blocking first launch.

`Casks/tandem.rb` is written by the
[release workflow](https://github.com/Jonezzyboy/tandem/blob/main/.github/workflows/release.yml)
on every published release — edit the template in that repo, not the cask here.
