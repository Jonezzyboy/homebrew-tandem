cask "tandem-repos" do
  version "0.2.3"
  sha256 "d0a4da27474da7219a3d475cde207ae3ff382a570cc112c795ee1a287f1f686e"

  url "https://github.com/Jonezzyboy/tandem/releases/download/v#{version}/Tandem_v#{version}_macos_universal.zip"
  name "Tandem"
  desc "Worktrees, merge order and linked PRs for one change across many repos"
  homepage "https://github.com/Jonezzyboy/tandem"

  depends_on formula: "gh"
  depends_on :macos

  app "Tandem.app"
  # homebrew-core's td (a to-do list) installs the same command; brew refuses to
  # link over it, and casks can no longer declare a conflict with a formula.
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
