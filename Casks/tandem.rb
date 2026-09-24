cask "tandem" do
  version "0.2.2"
  sha256 "b68b0fd38e45df3ffa887e4d520705b04e67b84705e1a8be2ebe04340ccaa838"

  url "https://github.com/Jonezzyboy/tandem/releases/download/v#{version}/Tandem_v#{version}_macos_universal.zip"
  name "Tandem"
  desc "Worktrees, merge order and linked PRs for one change across many repos"
  homepage "https://github.com/Jonezzyboy/tandem"

  # homebrew-core's td (a to-do list) installs the same command name.
  conflicts_with formula: "td"
  depends_on formula: "gh"
  depends_on :macos

  app "Tandem.app"
  binary "#{appdir}/Tandem.app/Contents/MacOS/td"

  # Ad-hoc signed rather than notarised, so Gatekeeper blocks first launch
  # otherwise. Drop once the build carries a Developer ID signature.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Tandem.app"],
        writable_paths: ["Tandem.app"],
        writable_base:  :appdir
  end

  # Changes and worktrees under ~/code/.tandem are the user's work, so zap
  # leaves them alone.
  zap trash: [
    "~/Library/Caches/com.alanjones.tandem",
    "~/Library/HTTPStorages/com.alanjones.tandem",
    "~/Library/Saved Application State/com.alanjones.tandem.savedState",
    "~/Library/WebKit/com.alanjones.tandem",
  ]
end
